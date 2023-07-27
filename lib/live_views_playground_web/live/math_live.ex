defmodule LiveViewsPlaygroundWeb.MathLive do
  use LiveViewsPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, %{a: random_number(10)})
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mb-10">Multiplication Quiz</h1>
      <div class="problems-grid mt-5">
        <%= for _ <- 1..24 do %>
          <% b = random_number(@a) %>
          <% numbers = [@a, b] %>
          <% [first | [last]] = Enum.shuffle(numbers) %>
          <table class="problem">
            <tr>
              <td></td>
              <td class="number"><%= first %></td>
            </tr>
            <tr>
              <td>x</td>
              <td class="number"><%= last %></td>
            </tr>
            <tr class="answer-row">
              <td></td>
              <td class="answer"></td>
            </tr>
          </table>
        <% end %>
      </div>

    <div class="flex justify-center gap-4 mt-9 print:hidden">
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="rand">Random Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="one">1's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="two">2's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="three">3's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="four">4's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="five">5's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="six">6's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="seven">7's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="eight">8's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="nine">9's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="ten">10's Quiz</button>
    </div>
    """
  end

  def handle_event("one", _, socket) do
    socket = assign(socket, %{a: 1})
    {:noreply, socket}
  end

  def handle_event("two", _, socket) do
    socket = assign(socket, %{a: 2})
    {:noreply, socket}
  end

  def handle_event("three", _, socket) do
    socket = assign(socket, %{a: 3})
    {:noreply, socket}
  end

  def handle_event("four", _, socket) do
    socket = assign(socket, %{a: 4})
    {:noreply, socket}
  end

  def handle_event("five", _, socket) do
    socket = assign(socket, %{a: 5})
    {:noreply, socket}
  end

  def handle_event("six", _, socket) do
    socket = assign(socket, %{a: 6})
    {:noreply, socket}
  end

  def handle_event("seven", _, socket) do
    socket = assign(socket, %{a: 7})
    {:noreply, socket}
  end

  def handle_event("eight", _, socket) do
    socket = assign(socket, %{a: 8})
    {:noreply, socket}
  end

  def handle_event("nine", _, socket) do
    socket = assign(socket, %{a: 9})
    {:noreply, socket}
  end

  def handle_event("ten", _, socket) do
    socket = assign(socket, %{a: 10})
    {:noreply, socket}
  end

  def handle_event("rand", _, socket) do
    socket = assign(socket, %{a: random_number(10)})
    {:noreply, socket}
  end

  defp random_number(number) do
    max =
      case number < 5 do
        true -> 4
        false -> number
      end

    Enum.random(1..max)
  end
end
