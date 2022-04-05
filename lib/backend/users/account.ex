defmodule Backend.Users.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :address, :map
    field :cpf, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :cpf, :address])
    |> validate_required([:name, :cpf, :address])
    |> validate_length(:cpf, min: 11)
  end
end
