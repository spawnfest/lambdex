defmodule LambdexCore.Execution do
  @moduledoc """
  The Lambda Execution
  """

  @derive Jason.Encoder
  defstruct lambda_id: nil,
    executed_at: nil,
    result: nil,
    output: "",
    sign: nil,
    duration: 0,
    reductions: 0,
    request_id: "",
    status: nil,
    params: %{},
    envs: %{}

  def put_duration(%__MODULE__{} = execution, duration) do
    %{execution | duration: duration}
  end

  def put_result(%__MODULE__{} = execution, {:ok, result}) do
    %{execution | result: result}
    |> set_success
  end
  def put_result(%__MODULE__{} = execution, {:error, error}) do
    %{execution | result: "#{inspect(error)}"}
    |> set_error()
  end

  def put_output(%__MODULE__{} = execution, output) do
    %{execution | output: output}
  end

  def set_success(%__MODULE__{} = execution) do
    %{execution | status: :success}
  end
  def set_error(%__MODULE__{} = execution) do
    %{execution | status: :error}
  end

  def put_executed_at(%__MODULE__{} = execution, time) do
    %{execution | executed_at: time}
  end

  def put_reductions(%__MODULE__{} = execution, reductions) do
    %{execution | reductions: reductions}
  end

  def put_params(%__MODULE__{} = execution, params) do
    %{execution | params: params}
  end

  def put_envs(%__MODULE__{} = execution, envs) do
    %{execution | envs: envs}
  end
end
