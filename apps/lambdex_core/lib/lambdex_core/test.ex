defmodule LambdexCore.Test do
  def run(lambda) do
    {:ok, pid} =
      DynamicSupervisor.start_child(
        LambdexCore.ExecutionSupervisor,
        {LambdexCore.LambdaExecution, lambda}
      )

    result = LambdexCore.LambdaExecution.run_sync(pid)
    IO.inspect(result, label: "the result of the test was:")
  end
end
