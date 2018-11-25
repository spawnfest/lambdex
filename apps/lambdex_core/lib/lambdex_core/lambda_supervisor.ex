defmodule LambdexCore.LambdaSupervisor do
  use GenServer

  Process.flag(:trap_exit, true)

  def start_link(lambda, opts \\ []) do
    GenServer.start_link(__MODULE__, lambda, opts)
  end

  @impl true
  def init(lambda) do
    #start_supervised_task(lambda)

    {:ok, lambda}
  end

  @impl true
  def handle_info({:DOWN, _ref, :process, pid, reason}, state) do
    IO.puts "#{inspect(reason)} by #{inspect(pid)}"
    {:stop, reason, state}
  end
  def handle_info(msg, state) do
    IO.inspect msg, label: "msg"
    {:noreply, state}
  end

  @impl true
  def handle_call(:run, _from, lambda) do
    result = Kernel.apply(lambda.code, lambda.params)
    {:reply, result, lambda}
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
