defmodule LiveViewsPlayground.Repo do
  use Ecto.Repo,
    otp_app: :live_views_playground,
    adapter: Ecto.Adapters.Postgres
end
