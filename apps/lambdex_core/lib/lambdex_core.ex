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
  def run_sync(lambda_source, lambda_envs, lambda_params) when is_map(lambda_params) and map_size(lambda_params) == 0, do: run_sync(lambda_source, lambda_envs, [])
  def run_sync(lambda_source, lambda_envs, lambda_params) when is_binary(lambda_source) do
    {:ok, pid} =
      DynamicSupervisor.start_child(
        LambdexCore.ExecutionSupervisor,
        {LambdexCore.LambdaExecution, {lambda_source, lambda_envs, lambda_params}}
      )

    result = LambdexCore.LambdaExecution.run_sync(pid)
  end
end
