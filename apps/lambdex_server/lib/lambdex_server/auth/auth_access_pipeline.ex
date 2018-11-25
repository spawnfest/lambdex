defmodule LambdexServer.Auth.AuthAccessPipeline do
  @moduledoc false

  use Guardian.Plug.Pipeline,
    otp_app: :lambdex_server,
    module: LambdexServer.Auth.Guardian,
    error_handler: LambdexServer.Auth.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
  plug(LambdexServer.Auth.Plug.CurrentUser)
end
