defmodule LiveViewsPlaygroundWeb.TodoLive do
  use LiveViewsPlaygroundWeb, :live_view
  import Phoenix.HTML.Form

  alias LiveViewsPlayground.Todos
  alias LiveViewsPlayground.Todos.Todo

  def mount(_params, _session, socket) do
    todos = Todos.list_todos()

    {:ok,
     assign(socket, %{todos: sort_completed_last(todos), description: "", editing_todo_id: ""})}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-3">
      <h1 class="font-bold text-5xl text-slate-700 py-10 uppercase">DEMO to Do LiSt</h1>
      <div class="sm:w-full md:w-full lg:w-1/2 shadow-lg shadow-slate-300 rounded-md p-10">
        <%= form_for %{}, "#", [phx_submit: :new], fn f -> %>
          <div class="flex gap-3 pb-5">
            <%= text_input(f, :description, placeholder: "Add New Item", class: "w-full") %>
            <button class="bg-emerald-500 hover:bg-emerald-600 uppercase text-white p-2 px-4 sm:w-1/3 md:1/2 rounded-full">
              Add
            </button>
          </div>
        <% end %>

        <ul class="decoration-none mx-auto">
          <%= for todo <- @todos do %>
            <li class="w-full flex justify-start items-center py-2 gap-4">
              <input
                type="checkbox"
                name="todo_id"
                phx-click="complete"
                checked={todo.completed}
                phx-value-id={todo.id}
              />
              <%= if todo.id == @editing_todo_id do %>
                <%= form_for %{}, "#", [phx_submit: :stop_editing, phx_change: :update_description], fn f -> %>
                  <%= hidden_input(f, :id, value: todo.id) %>
                  <%= text_input(f, :description,
                    id: "description_#{todo.id}",
                    value: todo.description
                  ) %>
                  <button class="bg-yellow-300 py-1 px-2 hover:bg-yellow-400 uppercase text-xs rounded-sm">
                    Done
                  </button>
                <% end %>
              <% else %>
                <label class="text-xl">
                  <span class={if todo.completed, do: "line-through animate-wiggle inline-block"}>
                    <%= todo.description %>
                  </span>
                </label>

                <a
                  phx-click="start_editing"
                  phx-value-id={todo.id}
                  class="text-emerald-500 cursor-pointer"
                >
                  Edit
                </a>
                <a
                  phx-click="delete"
                  phx-value-id={todo.id}
                  phx-confirm="Are you sure you want to delete this todo?"
                  class="text-red-500 font-bold cursor-pointer"
                >
                  x
                </a>
              <% end %>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("new", %{"description" => description}, socket) do
    if description != "" do
      case Todos.create_todo(%{"description" => description}) do
        {:ok, _todo} ->
          todos = Todos.list_todos()
          {:noreply, assign(socket, :todos, todos)}

        _ ->
          {:noreply, socket}
      end
    else
      {:noreply, socket}
    end
  end

  def handle_event("complete", %{"id" => id_string}, socket) do
    id = String.to_integer(id_string)

    todo = Enum.find(socket.assigns.todos, &(&1.id == id))

    updated_todo_params = %{completed: !todo.completed}

    case Todos.update_todo(todo, updated_todo_params) do
      {:ok, updated_todo} ->
        todos =
          Enum.map(socket.assigns.todos, fn
            ^todo -> updated_todo
            other -> other
          end)

        {:noreply, assign(socket, :todos, todos)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  def handle_event("start_editing", %{"id" => id_string}, socket) do
    id = String.to_integer(id_string)
    {:noreply, assign(socket, :editing_todo_id, id)}
  end

  def handle_event("stop_editing", _, socket) do
    {:noreply, assign(socket, :editing_todo_id, nil)}
  end

  def handle_event(
        "update_description",
        %{"id" => id_string, "description" => value},
        socket
      ) do
    id = String.to_integer(id_string)

    todo = Enum.find(socket.assigns.todos, &(&1.id == id))

    updated_todo_params = %{description: value}

    IO.inspect(value)

    case Todos.update_todo(todo, updated_todo_params) do
      {:ok, updated_todo} ->
        todos =
          Enum.map(socket.assigns.todos, fn
            ^todo -> updated_todo
            other -> other
          end)

        {:noreply, assign(socket, :todos, todos)}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    Todos.delete_todo(Todos.get_todo!(id))
    todos = Todos.list_todos()
    {:noreply, assign(socket, :todos, todos)}
  end

  def sort_completed_last(todos), do: Enum.sort_by(todos, & &1.completed)
end
