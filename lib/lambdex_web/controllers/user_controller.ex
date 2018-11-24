defmodule LambdexWeb.UserController do
  use LambdexWeb, :controller

  alias Lambdex.Accounts
  alias Lambdex.Accounts.User

  action_fallback LambdexWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def token(conn, %{"data" => %{"email" => email, "password" => password}}) do
    with {:ok, user} <- Lambdex.Auth.authenticate_user(email, password),
         claims <- %{},
         {:ok, token, claims} <-
           Lambdex.Auth.Guardian.encode_and_sign(user, claims, ttl: {24, :hours}) do
      render(conn, "token.json", token: token)
    end
  end
end
