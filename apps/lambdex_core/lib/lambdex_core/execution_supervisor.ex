defmodule LambdexCore.ExecutionSupervisor do
  @moduledoc """
  This is the supervisor (not really a Supervisor) of the Lambda Executions
  """
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end
end
