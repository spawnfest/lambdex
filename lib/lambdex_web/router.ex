defmodule LambdexWeb.Router do
  use LambdexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug(Lambdex.Auth.AuthAccessPipeline)
  end

  scope "/api", LambdexWeb do
    pipe_through :api

    resources "/users", UserController
    post("/users/token", UserController, :token)

    scope "/" do
      pipe_through :auth

      resources "/lambdas", LambdaController
      resources "/lambda_executions", LambdaExecutionController
      #post "/lambas/:id/run", LambdaController, :run
    end

  end

  scope "/", LambdexWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
