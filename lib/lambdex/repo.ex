defmodule Lambdex.Repo do
  use Ecto.Repo,
    otp_app: :lambdex,
    adapter: Ecto.Adapters.Postgres
end
