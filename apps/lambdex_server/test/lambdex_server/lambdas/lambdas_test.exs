defmodule LambdexServer.LambdasTest do
  use LambdexServer.DataCase

  alias LambdexServer.Lambdas
  alias LambdexServer.Accounts

  @user_attrs %{
    email: "my@email.com",
    name: "a_name",
    password: "password"
  }

  describe "lambdas" do
    alias LambdexServer.Lambdas.Lambda

    @valid_attrs %{code: "some code", enabled: true, params: %{}, path: "some path"}
    @update_attrs %{
      code: "some updated code",
      enabled: false,
      params: %{},
      path: "some updated path"
    }
    @invalid_attrs %{code: nil, enabled: nil, params: nil, path: nil}

    def lambda_fixture(attrs \\ %{}) do
      {:ok, user} = Accounts.create_user(@user_attrs)

      {:ok, lambda} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.put(:user_id, user.id)
        |> Lambdas.create_lambda()

      lambda
    end

    test "list_lambdas/0 returns all lambdas" do
      lambda = lambda_fixture()
      assert Lambdas.list_lambdas() == [lambda]
    end

    test "get_lambda!/1 returns the lambda with given id" do
      lambda = lambda_fixture()
      assert Lambdas.get_lambda!(lambda.id) == lambda
    end

    test "create_lambda/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lambdas.create_lambda(@invalid_attrs)
    end

    test "update_lambda/2 with valid data updates the lambda" do
      lambda = lambda_fixture()
      assert {:ok, %Lambda{} = lambda} = Lambdas.update_lambda(lambda, @update_attrs)
      assert lambda.code == "some updated code"
      assert lambda.enabled == false
      assert lambda.params == %{}
      assert lambda.path == "some updated path"
    end

    test "update_lambda/2 with invalid data returns error changeset" do
      lambda = lambda_fixture()
      assert {:error, %Ecto.Changeset{}} = Lambdas.update_lambda(lambda, @invalid_attrs)
      assert lambda == Lambdas.get_lambda!(lambda.id)
    end

    test "delete_lambda/1 deletes the lambda" do
      lambda = lambda_fixture()
      assert {:ok, %Lambda{}} = Lambdas.delete_lambda(lambda)
      assert_raise Ecto.NoResultsError, fn -> Lambdas.get_lambda!(lambda.id) end
    end

    test "change_lambda/1 returns a lambda changeset" do
      lambda = lambda_fixture()
      assert %Ecto.Changeset{} = Lambdas.change_lambda(lambda)
    end
  end

  describe "lambda_executions" do
    alias LambdexServer.Lambdas.LambdaExecution

    @valid_attrs %{data: %{}}
    @update_attrs %{data: %{}}
    @invalid_attrs %{data: nil}

    def lambda_execution_fixture(attrs \\ %{}) do
      {:ok, lambda_execution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lambdas.create_lambda_execution()

      lambda_execution
    end

    test "list_lambda_executions/0 returns all lambda_executions" do
      lambda_execution = lambda_execution_fixture()
      assert Lambdas.list_lambda_executions() == [lambda_execution]
    end

    test "get_lambda_execution!/1 returns the lambda_execution with given id" do
      lambda_execution = lambda_execution_fixture()
      assert Lambdas.get_lambda_execution!(lambda_execution.id) == lambda_execution
    end

    test "create_lambda_execution/1 with valid data creates a lambda_execution" do
      assert {:ok, %LambdaExecution{} = lambda_execution} =
               Lambdas.create_lambda_execution(@valid_attrs)

      assert lambda_execution.data == %{}
    end

    test "create_lambda_execution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lambdas.create_lambda_execution(@invalid_attrs)
    end

    test "update_lambda_execution/2 with valid data updates the lambda_execution" do
      lambda_execution = lambda_execution_fixture()

      assert {:ok, %LambdaExecution{} = lambda_execution} =
               Lambdas.update_lambda_execution(lambda_execution, @update_attrs)

      assert lambda_execution.data == %{}
    end

    test "update_lambda_execution/2 with invalid data returns error changeset" do
      lambda_execution = lambda_execution_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Lambdas.update_lambda_execution(lambda_execution, @invalid_attrs)

      assert lambda_execution == Lambdas.get_lambda_execution!(lambda_execution.id)
    end

    test "delete_lambda_execution/1 deletes the lambda_execution" do
      lambda_execution = lambda_execution_fixture()
      assert {:ok, %LambdaExecution{}} = Lambdas.delete_lambda_execution(lambda_execution)

      assert_raise Ecto.NoResultsError, fn ->
        Lambdas.get_lambda_execution!(lambda_execution.id)
      end
    end

    test "change_lambda_execution/1 returns a lambda_execution changeset" do
      lambda_execution = lambda_execution_fixture()
      assert %Ecto.Changeset{} = Lambdas.change_lambda_execution(lambda_execution)
    end
  end
end
