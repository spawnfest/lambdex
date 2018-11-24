defmodule Lambdex.Repo.Migrations.CreateLambdaExecutions do
  use Ecto.Migration

  def change do
    create table(:lambda_executions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :data, :map
      add :lambda_id, references(:lambdas, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:lambda_executions, [:lambda_id])
  end
end
