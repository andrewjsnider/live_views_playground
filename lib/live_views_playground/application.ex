defmodule LiveViewsPlayground.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveViewsPlaygroundWeb.Telemetry,
      # Start the Ecto repository
      LiveViewsPlayground.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveViewsPlayground.PubSub},
      # Start Finch
      {Finch, name: LiveViewsPlayground.Finch},
      # Start the Endpoint (http/https)
      LiveViewsPlaygroundWeb.Endpoint
      # Start a worker by calling: LiveViewsPlayground.Worker.start_link(arg)
      # {LiveViewsPlayground.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewsPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewsPlaygroundWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
