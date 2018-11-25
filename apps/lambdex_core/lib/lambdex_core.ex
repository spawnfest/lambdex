defmodule LambdexCore do
  @moduledoc """
  Documentation for LambdexCore.
  """

  @doc """
  Run synchronously a lambda function

  ## Examples

      iex> LambdexCore.run_sync("fn -> :hello_lambda end", %{})
      %LambdexCore.Execution{
        result: :hello_lambda
      }
  """
  def run_sync(lambda_source, lambda_envs, lambda_params \\ [])
  def run_sync(lambda_source, lambda_envs, nil), do: run_sync(lambda_source, lambda_envs, [])
  def run_sync(lambda_source, lambda_envs, lambda_params) when is_binary(lambda_source) do
    {lambda_fn, _params} = Code.eval_string(lambda_source)
    {:ok, pid} =
      DynamicSupervisor.start_child(
        LambdexCore.ExecutionSupervisor,
        {LambdexCore.LambdaExecution, {lambda_fn, lambda_envs, lambda_params}}
      )

    result = LambdexCore.LambdaExecution.run_sync(pid)
    IO.inspect(result, label: "the result of the test was:")
  end
end
