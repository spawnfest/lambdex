# defmodule LambdexWeb.LambdaExecutionControllerTest do
#   use LambdexWeb.ConnCase

#   alias Lambdex.Lambdas
#   alias Lambdex.Lambdas.LambdaExecution

#   @create_attrs %{
#     data: %{}
#   }
#   @update_attrs %{
#     data: %{}
#   }
#   @invalid_attrs %{data: nil}

#   def fixture(:lambda_execution) do
#     {:ok, lambda_execution} = Lambdas.create_lambda_execution(@create_attrs)
#     lambda_execution
#   end

#   setup %{conn: conn} do
#     {:ok, token, _claims} = Lambdex.Auth.Guardian.encode_and_sign(%{id: @user_id}, %{}, ttl: {2, :minutes})

#     conn =
#       conn
#       |> put_req_header("accept", "application/json")
#       |> put_req_header("authorization", "Bearer #{token}")

#     {:ok, conn: conn}
#   end

#   describe "index" do
#     test "lists all lambda_executions", %{conn: conn} do
#       conn = get(conn, Routes.lambda_execution_path(conn, :index))
#       assert json_response(conn, 200)["data"] == []
#     end
#   end

#   describe "create lambda_execution" do
#     test "renders lambda_execution when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.lambda_execution_path(conn, :create), lambda_execution: @create_attrs)
#       assert %{"id" => id} = json_response(conn, 201)["data"]

#       conn = get(conn, Routes.lambda_execution_path(conn, :show, id))

#       assert %{
#                "id" => id,
#                "data" => %{}
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.lambda_execution_path(conn, :create), lambda_execution: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "update lambda_execution" do
#     setup [:create_lambda_execution]

#     test "renders lambda_execution when data is valid", %{conn: conn, lambda_execution: %LambdaExecution{id: id} = lambda_execution} do
#       conn = put(conn, Routes.lambda_execution_path(conn, :update, lambda_execution), lambda_execution: @update_attrs)
#       assert %{"id" => ^id} = json_response(conn, 200)["data"]

#       conn = get(conn, Routes.lambda_execution_path(conn, :show, id))

#       assert %{
#                "id" => id,
#                "data" => %{}
#              } = json_response(conn, 200)["data"]
#     end

#     test "renders errors when data is invalid", %{conn: conn, lambda_execution: lambda_execution} do
#       conn = put(conn, Routes.lambda_execution_path(conn, :update, lambda_execution), lambda_execution: @invalid_attrs)
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "delete lambda_execution" do
#     setup [:create_lambda_execution]

#     test "deletes chosen lambda_execution", %{conn: conn, lambda_execution: lambda_execution} do
#       conn = delete(conn, Routes.lambda_execution_path(conn, :delete, lambda_execution))
#       assert response(conn, 204)

#       assert_error_sent 404, fn ->
#         get(conn, Routes.lambda_execution_path(conn, :show, lambda_execution))
#       end
#     end
#   end

#   defp create_lambda_execution(_) do
#     lambda_execution = fixture(:lambda_execution)
#     {:ok, lambda_execution: lambda_execution}
#   end
# end
