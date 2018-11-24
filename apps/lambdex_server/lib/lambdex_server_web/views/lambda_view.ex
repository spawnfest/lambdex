defmodule LambdexServerWeb.LambdaView do
  use LambdexServerWeb, :view
  alias LambdexServerWeb.LambdaView

  def render("index.json", %{lambdas: lambdas}) do
    %{data: render_many(lambdas, LambdaView, "lambda.json")}
  end

  def render("show.json", %{lambda: lambda}) do
    %{data: render_one(lambda, LambdaView, "lambda.json")}
  end

  def render("lambda.json", %{lambda: lambda}) do
    %{
      id: lambda.id,
      path: lambda.path,
      params: lambda.params,
      code: lambda.code,
      enabled: lambda.enabled
    }
  end
end
