defmodule LiveViewsPlaygroundWeb.TodoLive do
  use LiveViewsPlaygroundWeb, :live_view
  import Phoenix.HTML.Form

  @todos [
    %{id: 1, description: "Learn Elixir", completed: false},
    %{id: 2, description: "Learn Phoenix", completed: false},
    %{id: 3, description: "Learn Rails", completed: true},
    %{id: 4, description: "Make Breakfast", completed: false}
  ]

  @description ""

  def mount(_params, _session, socket) do
    socket = assign(socket, %{todos: sort(@todos), description: @description})
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-3">
      <h1 class="font-bold text-5xl text-slate-700 py-10 uppercase">DEMO to Do LiSt</h1>
      <div class="shadow-lg shadow-slate-300 rounded-md p-10">
        <%= form_for %{}, "#", [phx_validates: true, phx_submit: :new], fn f -> %>
          <div class="flex gap-3 pb-5">
            <%= text_input(f, :description, value: @description) %>
            <button class="bg-emerald-500 hover:bg-emerald-600 text-white p-2 px-4 w-full rounded-full">
              Add To Do Item
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
              <label class="text-xl">
                <span class={if todo.completed, do: "line-through animate-wiggle inline-block"}>
                  <%= todo.description %>
                </span>
              </label>
              <a
                phx-click="delete"
                phx-value-id={todo.id}
                class="text-red-500 font-bold cursor-pointer"
              >
                x
              </a>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  def handle_event("new", %{"description" => description}, socket) do
    if description != "" do
      new_todo = build_todo(socket.assigns.todos, description)
      todos = add_new_todo(socket.assigns.todos, new_todo)
      {:noreply, assign(socket, :todos, sort(todos))}
    else
      {:noreply, socket}
    end
  end

  def handle_event("delete", %{"id" => id}, socket) do
    todos = delete_item_by_id(socket.assigns.todos, String.to_integer(id))
    {:noreply, assign(socket, :todos, sort(todos))}
  end

  def handle_event("complete", %{"id" => id}, socket) do
    todos = complete_item_by_id(socket.assigns.todos, String.to_integer(id))
    sorted = Enum.sort_by(todos, & &1.completed)
    socket = assign(socket, :todos, sort(todos))
    {:noreply, socket}
  end

  def sort(todos), do: Enum.sort_by(todos, & &1.completed)

  defp add_new_todo(todos, todo), do: todos ++ [todo]

  defp build_todo(todos, description) do
    %{id: length(todos) + 1, description: description, completed: false}
  end

  defp complete_item_by_id(todos, id) do
    Enum.map(todos, fn todo ->
      if todo.id == id do
        Map.put(todo, :completed, !todo.completed)
      else
        todo
      end
    end)
  end

  defp delete_item_by_id(todos, id), do: Enum.filter(todos, fn todo -> todo.id != id end)
end
