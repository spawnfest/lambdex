defmodule LambdexServer.Lambdas.Lambda do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lambdas" do
    field :code, :string
    field :enabled, :boolean, default: true
    field :params, :map
    field :path, :string
    field :name, :string
    belongs_to :user, LambdexServer.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(lambda, attrs) do
    lambda
    |> cast(attrs, [:name, :path, :params, :code, :enabled, :user_id])
    |> foreign_key_constraint(:user_id)
    |> validate_required([:name, :path, :params, :code, :enabled, :user_id])
  end
end
