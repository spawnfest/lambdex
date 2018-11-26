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

%User{id: user_id} =
  %User{}
  |> User.changeset(%{email: "test@lambdex.com", name: "test user", password: "password"})
  |> Repo.insert!()

github_lambda = ~S"""
fn(environment, client_params) ->
  HTTPoison.start()
  %HTTPoison.Response{body: body} = HTTPoison.get!("https://api.github.com/orgs/#{environment["org_name"]}/repos", [Accept: "application/vnd.github.inertia-preview+json"])
  body
  end
"""

Repo.insert!(%Lambda{code: github_lambda, name: "get spawnfest repos!", params: %{org_name: "spawnfest"}, path: "spawnfest-repos", user_id: user_id})

Repo.insert!(%Lambda{code: ~s[fn(environment, client_params) ->
    raise RuntimeError
    end], name: "always error :(", params: %{}, path: "always-error", user_id: user_id})

Enum.map(1..4, fn i ->
  %Lambda{id: _lambda_id} =
    Repo.insert!(%Lambda{code: ~s[fn(environment, client_params) -> "hello lambda!" end], name: "lambda ##{i}", params: %{}, path: "lambda#{i}", user_id: user_id})
end)
