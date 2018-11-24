defmodule LambdexServerWeb.LambdaExecutionView do
  use LambdexServerWeb, :view
  alias LambdexServerWeb.LambdaExecutionView

  def render("index.json", %{lambda_executions: lambda_executions}) do
    %{data: render_many(lambda_executions, LambdaExecutionView, "lambda_execution.json")}
  end

  def render("show.json", %{lambda_execution: lambda_execution}) do
    %{data: render_one(lambda_execution, LambdaExecutionView, "lambda_execution.json")}
  end

  def render("lambda_execution.json", %{lambda_execution: lambda_execution}) do
    %{id: lambda_execution.id, data: lambda_execution.data}
  end
end
