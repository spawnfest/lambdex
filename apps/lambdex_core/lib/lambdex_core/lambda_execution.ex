defmodule LambdexCore.LambdaExecution do
  use GenServer

  alias LambdexCore.Execution

  Process.flag(:trap_exit, true)

  def start_link({lambda_fn, lambda_envs, lambda_params}, opts \\ []) do
    GenServer.start_link(__MODULE__, {lambda_fn, lambda_envs, lambda_params}, opts)
  end

  @impl true
  def init({lambda_fn, lambda_envs, lambda_params}) do
    # start_supervised_task(lambda)
    state = %{
      lambda_fn: lambda_fn,
      lambda_envs: lambda_envs,
      lambda_params: lambda_params,
      execution: %Execution{}
    }

    {:ok, state}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, reason}, state) do
    IO.puts("#{inspect(reason)} by #{inspect(pid)}")
    # {:stop, reason, state}
    {:noreply, state}
  end

  def handle_info(msg, state) do
    IO.inspect(msg, label: "msg")
    {:noreply, state}
  end

  @impl true
  def handle_call(:run, _from, state) do
    start_time = System.monotonic_time(:milliseconds)
    at_time = :os.system_time(:seconds)

    result =
      try do
        {:ok, Kernel.apply(state.lambda_fn, state.lambda_params)}
      rescue
        error ->
          {:error, error}
      end

    duration = System.monotonic_time(:milliseconds) - start_time

    execution =
      state.execution
      |> Execution.put_executed_at(at_time)
      |> Execution.put_duration(duration)
      |> Execution.put_result(result)

    {:reply, execution, %{state | execution: execution}}
  end

  ############
  # API
  ############

  def run_sync(pid) do
    GenServer.call(pid, :run)
  end

  def start_supervised_task(lambda) do
    Task.Supervisor.async_nolink(LambdexCore.LambdaTaskSupervisor, lambda.code, lambda.params)
  end
end
