defmodule Figgis.Repo do
  use Ecto.Repo,
    otp_app: :figgis,
    adapter: Ecto.Adapters.Postgres
end
