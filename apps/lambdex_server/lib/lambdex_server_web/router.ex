defmodule LambdexServerWeb.Router do
  use LambdexServerWeb, :router

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
    plug(LambdexServer.Auth.AuthAccessPipeline)
  end

  scope "/api", LambdexServerWeb do
    pipe_through :api

    resources "/users", UserController
    post("/users/token", UserController, :token)
    post "/lambdas/:path", LambdaExecutionController, :run_lambda

    scope "/" do
      pipe_through :auth

      resources "/lambdas", LambdaController
      resources "/lambda_executions", LambdaExecutionController

    end
  end

  scope "/", LambdexServerWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
