# defmodule LambdexWeb.LambdaControllerTest do
#   use LambdexWeb.ConnCase

#   alias Lambdex.Lambdas
#   alias Lambdex.Lambdas.Lambda
#   alias Lambdex.Accounts

#   @create_attrs %{
#     user_id: "2a38dfee-6849-4067-8f93-2e9df8649842",
#     code: "some code",
#     enabled: true,
#     params: %{},
#     path: "some path"
#   }
#   @update_attrs %{
#     code: "some updated code",
#     enabled: false,
#     params: %{},
#     path: "some updated path"
#   }
#   @invalid_attrs %{code: nil, enabled: nil, params: nil, path: nil}

#   @user_attrs %{
#     email: "my@email.com",
#     name: "a_name",
#     password: "password"
#   }

#   def fixture(:lambda) do
#     {:ok, lambda} = Lambdas.create_lambda(@create_attrs)
#     lambda
#   end

#   def fixture(:user) do
#     {:ok, user} = Accounts.create_user(@user_attrs)
#     user
#   end

#   setup %{conn: conn} do
#     {:ok, conn: conn |> put_req_header("accept", "application/json")}
#   end

#   def auth_conn(conn, user) do
#     {:ok, token, _claims} = Lambdex.Auth.Guardian.encode_and_sign(user, %{}, ttl: {2, :minutes})
#     put_req_header(conn, "authorization", "Bearer #{token}")
#   end

#   describe "index" do
#     setup [:create_user]

#     test "lists all lambdas", %{conn: conn, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> get(Routes.lambda_path(conn, :index))
#       assert json_response(conn, 200)["data"] == []
#     end
#   end

#   describe "create lambda" do
#     setup [:create_user]

#     test "renders lambda when data is valid", %{conn: conn, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> post(Routes.lambda_path(conn, :create), lambda: @create_attrs)
#       assert %{"id" => id} = json_response(conn, 201)["data"]

#       conn = get(conn, Routes.lambda_path(conn, :show, id))

#       assert %{
#                "id" => id,
#                "code" => "some code",
#                "enabled" => true,
#                "params" => %{},
#                "path" => "some path"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> post(Routes.lambda_path(conn, :create), lambda: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "update lambda" do
#     setup [:create_lambda, :create_user]

#     test "renders lambda when data is valid", %{conn: conn, lambda: %Lambda{id: id} = lambda, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> put(Routes.lambda_path(conn, :update, lambda), lambda: @update_attrs)
#       assert %{"id" => ^id} = json_response(conn, 200)["data"]

#       conn = get(conn, Routes.lambda_path(conn, :show, id))

#       assert %{
#                "id" => id,
#                "code" => "some updated code",
#                "enabled" => false,
#                "params" => %{},
#                "path" => "some updated path"
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn, lambda: lambda, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> put(Routes.lambda_path(conn, :update, lambda), lambda: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "delete lambda" do
#     setup [:create_lambda, :create_user]

#     test "deletes chosen lambda", %{conn: conn, lambda: lambda, user: user} do
#       conn =
#         conn
#         |> auth_conn(user)
#         |> delete(Routes.lambda_path(conn, :delete, lambda))
#       assert response(conn, 204)

#       assert_error_sent 404, fn ->
#         conn
#         |> auth_conn(user)
#         |> get(Routes.lambda_path(conn, :show, lambda))
#       end
#     end
#   end

#   defp create_lambda(_) do
#     lambda = fixture(:lambda)
#     {:ok, lambda: lambda}
#   end

#   defp create_user(_) do
#     user = fixture(:user)
#     {:ok, user: user}
#   end
# end
