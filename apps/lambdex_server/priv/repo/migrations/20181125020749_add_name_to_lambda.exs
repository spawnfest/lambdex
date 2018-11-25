defmodule LambdexServer.Repo.Migrations.AddLambdaName do
  use Ecto.Migration

  def change do
    alter table("lambdas") do
      add :name, :string
    end
  end
end
