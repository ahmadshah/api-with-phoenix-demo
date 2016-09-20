defmodule ApiWithPhoenixDemo.User do
  use ApiWithPhoenixDemo.Web, :model

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :original_password, :string, virtual: true
    field :password, :string
    field :first_name, :string
    field :last_name, :string
    timestamps
  end

  @required_fields ~w(email original_password first_name last_name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password(params[:original_password])
    |> validate_length(:original_password, min: 6)
    |> unique_constraint(:email)
  end

  defp hash_password(model, password) do
    case is_nil(password) do
      true -> model
      false -> put_change(model, :password, hashpwsalt(password))
    end
  end
end
