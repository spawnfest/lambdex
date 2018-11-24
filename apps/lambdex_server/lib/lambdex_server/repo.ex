defmodule LambdexServer.Repo do
  use Ecto.Repo,
    otp_app: :lambdex_server,
    adapter: Ecto.Adapters.Postgres
end
