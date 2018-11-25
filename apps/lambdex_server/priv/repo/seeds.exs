# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LambdexServer.Repo.insert!(%LambdexServer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LambdexServer.Repo
alias LambdexServer.Accounts.User
alias LambdexServer.Lambdas.Lambda
alias LambdexServer.Lambdas.LambdaExecution

%User{id: user_id} =
  %User{}
  |> User.changeset(%{email: "test@lambdex.com", name: "test user", password: "password"})
  |> Repo.insert!()

Enum.map(1..10, fn i ->
  %Lambda{id: lambda_id} =
    Repo.insert!(%Lambda{code: ~s[fn -> "hello lambda!" end], name: "lambda ##{i}", params: %{}, path: "lambda#{i}", user_id: user_id})


  Enum.map(1..100, fn j ->
    Repo.insert!(%LambdaExecution{data: %{}, lambda_id: lambda_id})
  end)
end)
