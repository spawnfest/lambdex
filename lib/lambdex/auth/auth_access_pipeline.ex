defmodule Lambdex.Auth.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :lambdex,
    module: Lambdex.Auth.Guardian,
    error_handler: Lambdex.Auth.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
