defmodule LambdexServerWeb.LambdaExecutionController do
  use LambdexServerWeb, :controller

  alias LambdexServer.Lambdas
  alias LambdexServer.Lambdas.LambdaExecution

  action_fallback LambdexServerWeb.FallbackController

  def index(conn, _params) do
    lambda_executions = Lambdas.list_lambda_executions()
    render(conn, "index.json", lambda_executions: lambda_executions)
  end

  def create(conn, %{"lambda_execution" => lambda_execution_params}) do
    with {:ok, %LambdaExecution{} = lambda_execution} <-
           Lambdas.create_lambda_execution(lambda_execution_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.lambda_execution_path(conn, :show, lambda_execution))
      |> render("show.json", lambda_execution: lambda_execution)
    end
  end

  def show(conn, %{"id" => id}) do
    lambda_execution = Lambdas.get_lambda_execution!(id)
    render(conn, "show.json", lambda_execution: lambda_execution)
  end

  def update(conn, %{"id" => id, "lambda_execution" => lambda_execution_params}) do
    lambda_execution = Lambdas.get_lambda_execution!(id)

    with {:ok, %LambdaExecution{} = lambda_execution} <-
           Lambdas.update_lambda_execution(lambda_execution, lambda_execution_params) do
      render(conn, "show.json", lambda_execution: lambda_execution)
    end
  end

  def delete(conn, %{"id" => id}) do
    lambda_execution = Lambdas.get_lambda_execution!(id)

    with {:ok, %LambdaExecution{}} <- Lambdas.delete_lambda_execution(lambda_execution) do
      send_resp(conn, :no_content, "")
    end
  end
end
