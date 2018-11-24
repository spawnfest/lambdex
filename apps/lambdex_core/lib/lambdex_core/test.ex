defmodule LambdexCore.Test do

  def run(lambda) do
    DynamicSupervisor.start_child(LambdexCore.ExecutionSupervisor, {LambdexCore.LambdaSupervisor, lambda})
  end
end
