defmodule LambdexServer.Repo.Migrations.CreateLambdas do
  use Ecto.Migration

  def change do
    create table(:lambdas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :path, :string
      add :params, :map
      add :code, :string
      add :enabled, :boolean, default: true, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:lambdas, [:user_id])
  end
end
