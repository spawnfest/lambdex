defmodule LambdexCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: LambdexCore.ExecutionSupervisor}
    ]

    opts = [strategy: :one_for_one, name: LambdexCore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
