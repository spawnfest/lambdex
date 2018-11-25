defmodule LambdexCore.LambdaExecution do
  use GenServer

  alias LambdexCore.Execution

  def start_link({lambda_source, lambda_envs, lambda_params}, opts \\ []) do
    GenServer.start_link(__MODULE__, {lambda_source, lambda_envs, lambda_params}, opts)
  end

  @impl true
  def init({lambda_source, lambda_envs, lambda_params}) do
    state = %{
      lambda_source: lambda_source,
      lambda_envs: lambda_envs,
      lambda_params: lambda_params,
      execution: %Execution{}
    }

    {:ok, state}
  end

  @impl true
  def handle_call(:run, _from, state) do
    start_time = System.monotonic_time(:milliseconds)
    at_time = :os.system_time(:seconds)

    result =
      try do
        {lambda_fn, _params} = Code.eval_string(state.lambda_source)
        {:ok, Kernel.apply(lambda_fn, [state.lambda_envs, state.lambda_params])}
      rescue
        #CompileError ->
        error ->
          {:error, error}
      end

    duration = System.monotonic_time(:milliseconds) - start_time
    reductions = get_process_reduction_count()
    execution =
      state.execution
      |> Execution.put_executed_at(at_time)
      |> Execution.put_duration(duration)
      |> Execution.put_reductions(reductions)
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

  defp get_process_reduction_count() do
    {:ok, reductions} = Keyword.fetch(:erlang.process_info(self()), :reductions)
    reductions
  end
end
