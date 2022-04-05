# defmodule Backend.Users.Address do
#   use Ecto.Schema
#   import Ecto.Changeset

#   @fields [:street, :neighborhood, :city, :state, :postal_code]

#   schema "address" do
#     field :street, :string
#     field :number, :integer
#     field :complement, :string
#     field :neighborhood, :string
#     field :city, :string
#     field :state, :string
#     field :postal_code, :string
#   end

#   def chagendset(params) do
#     %__MODULE__{}
#     |> cast(params, @fields)
#     |> validate_required(@fields)
#   end
# end
