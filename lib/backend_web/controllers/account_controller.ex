defmodule BackendWeb.AccountController do
  use BackendWeb, :controller

  alias Backend.Users
  alias Backend.Users.Account

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    accounts = Users.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    address = Users.get_cep(account_params["address"])

    with {:ok, %Account{} = account} <- Users.create_account(account_params |> Map.put("address", address)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Users.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Users.get_account!(id)

    with {:ok, %Account{} = account} <- Users.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Users.get_account!(id)

    with {:ok, %Account{}} <- Users.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
