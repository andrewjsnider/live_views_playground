defmodule LiveViewsPlaygroundWeb.LightLive do
  use LiveViewsPlaygroundWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto py-8">
      <h1><%= @brightness %>%</h1>
      <div class="bg-gray-300 w-100 h-5 rounded-full overflow-hidden">
        <div
          id="volumeFill"
          class="h-full bg-yellow-400 transition-all ease-out duration-[250ms]"
          style={"width: #{@brightness}%"}
        >
        </div>
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
        Based on a tutorial from <a
          href="https://pragmaticstudio.com/tutorials/getting-started-with-phoenix-liveview"
          class="text-blue-500 hover:text-blue-700"
        >
          The Pragmatic Studio
        </a>.
        Light bulbs are vector art from <a
          class="text-blue-500 hover:text-blue-700"
          href="https://pixabay.com/vectors/alphabet-word-images-bulb-filament-1296212/"
        >Pixabay</a>.
      </p>
    </div>
    """
  end

  def handle_event(event, _, socket) do
    new_brightness = change_brightness(event, socket.assigns.brightness)

    socket = assign(socket, :brightness, new_brightness)
    {:noreply, socket}
  end

  defp change_brightness(event, brightness) do
    case event do
      "on" -> 100
      "off" -> 0
      "down" -> max(brightness - 10, 0)
      "up" -> min(brightness + 10, 100)
      _ -> brightness
    end
  end
end
