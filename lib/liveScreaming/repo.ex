defmodule LiveScreaming.Repo do
  use Ecto.Repo,
    otp_app: :liveScreaming,
    adapter: Ecto.Adapters.Postgres
end
