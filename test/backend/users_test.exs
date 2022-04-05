defmodule Backend.UsersTest do
  use Backend.DataCase

  alias Backend.Users

  describe "accounts" do
    alias Backend.Users.Account

    @valid_attrs %{address: %{}, cpf: "some cpf", name: "some name"}
    @update_attrs %{address: %{}, cpf: "some updated cpf", name: "some updated name"}
    @invalid_attrs %{address: nil, cpf: nil, name: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Users.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Users.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Users.create_account(@valid_attrs)
      assert account.address == %{}
      assert account.cpf == "some cpf"
      assert account.name == "some name"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Users.update_account(account, @update_attrs)
      assert account.address == %{}
      assert account.cpf == "some updated cpf"
      assert account.name == "some updated name"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_account(account, @invalid_attrs)
      assert account == Users.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Users.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Users.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Users.change_account(account)
    end
  end
end
