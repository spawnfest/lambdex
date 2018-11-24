defmodule LambdexCore.LambdaSupervisor do
  use GenServer

  def start_link(lambda, opts \\ []) do
    GenServer.start_link(__MODULE__, lambda, opts)
  end

  @impl true
  def init(%{code: code} = state) do
    run(code)

    {:ok, state}
  end

  def run(lambda) do
    IO.inspect lambda
  end
end
