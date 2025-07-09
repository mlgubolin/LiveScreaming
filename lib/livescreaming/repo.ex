defmodule Livescreaming.Repo do
  use Ecto.Repo,
    otp_app: :livescreaming,
    adapter: Ecto.Adapters.Postgres
end
