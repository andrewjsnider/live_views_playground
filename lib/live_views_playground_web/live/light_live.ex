defmodule LiveViewsPlaygroundWeb.LightLive do
  use LiveViewsPlaygroundWeb, :live_view

  def mount(_params, _session, socker) do
    socket = assign(socker, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-8">
      <h1><%= @brightness %>%</h1>
      <div class="bg-gray-300 w-100 h-5 rounded-full overflow-hidden">
        <div id="volumeFill" class="h-full bg-yellow-400" style={"width: #{@brightness}%"}></div>
      </div>
      <div class="flex flex-row justify-center">
        <button phx-click="off" class="lightbulb-button">
          <img src="/images/off.png" />
        </button>
        <button phx-click="down" class="lightbulb-button">
          <div class="w-8 h-8 relative">
            <div class="minus-line"></div>
          </div>
        </button>
        <button phx-click="up" class="lightbulb-button">
          <div class="w-8 h-8 relative">
            <div class="plus-line"></div>
          </div>
        </button>
        <button phx-click="on" class="lightbulb-button">
          <img src="/images/on.png" />
        </button>
      </div>
    </div>

    <div>
      <p>
        Light bulbs are vector art from <a
          class="text-blue-500 hover:text-blue-700"
          href="https://pixabay.com/vectors/alphabet-word-images-bulb-filament-1296212/"
        >Pixabay</a>.
      </p>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end
end
