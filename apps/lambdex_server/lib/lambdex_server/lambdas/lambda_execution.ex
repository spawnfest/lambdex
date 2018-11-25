defmodule LambdexServer.Lambdas.LambdaExecution do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lambda_executions" do
    field :data, :map
    belongs_to :lambda, LambdexServer.Lambdas.Lambda

    timestamps()
  end

  @doc false
  def changeset(lambda_execution, attrs) do
    lambda_execution
    |> cast(attrs, [:data, :lambda_id])
    |> foreign_key_constraint(:lambda_id)
    |> validate_required([:data])
  end
end
