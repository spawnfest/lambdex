defmodule LambdexWeb.UserControllerTest do
  use LambdexWeb.ConnCase

  alias Lambdex.Accounts
  alias Lambdex.Accounts.User

  @create_attrs %{
    email: "my@email.com",
    name: "a_name",
    password: "password"
  }
  @update_attrs %{
    email: "u_my@email.com",
    name: "u_name",
    password: "upassword"
  }
  @invalid_attrs %{email: nil, name: nil, password_hash: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "my@email.com",
               "name" => "a_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "email" => "u_my@email.com",
               "name" => "u_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  describe "create token" do
    setup [:create_user]

    test "creates a token for the user", %{conn: conn, user: _user} do
      payload = %{
        "email" => "my@email.com",
        "password" => "password"
      }
      conn = post(conn, Routes.user_path(conn, :token), data: payload)
      %{"token" => token} = json_response(conn, 200)
      assert is_binary(token)
    end

    test "return error if user login failed", %{conn: conn, user: _user} do
      payload = %{
        "email" => "my@email.com",
        "password" => "wrongpass"
      }
      conn = post(conn, Routes.user_path(conn, :token), data: payload)
      assert json_response(conn, 400) != %{}
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
