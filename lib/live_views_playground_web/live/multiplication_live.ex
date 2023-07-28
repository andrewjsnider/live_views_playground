defmodule LiveViewsPlaygroundWeb.MultiplicationLive do
  use LiveViewsPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, %{a: random_number()})
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1 class="mb-10"><%= @a %>'s Multiplication Quiz</h1>
    <div class="problems-grid mt-5">
      <%= for _ <- 1..35 do %>
        <% b = random_number() %>
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
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="rand">Random Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="1">1's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="2">2's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="3">3's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="4">4's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="5">5's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="6">6's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="7">7's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="8">8's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="9">9's Quiz</button>
      <button class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded" phx-click="quiz" phx-value-a="10">10's Quiz</button>
    </div>
    """
  end

  def handle_event("quiz", %{"a" => value}, socket) do
    number = determine_value(value)

    socket = assign(socket, %{a: number})
    {:noreply, socket}
  end

  defp random_number do
    Enum.random(1..10)
  end

  defp determine_value(value) do
    if value == "rand" do
      random_number()
    else
      value
    end
  end
end
