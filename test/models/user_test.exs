defmodule ApiWithPhoenixDemo.UserTest do
  use ApiWithPhoenixDemo.ModelCase

  import ApiWithPhoenixDemo.Factory

  alias ApiWithPhoenixDemo.User
  alias ApiWithPhoenixDemo.Repo

  @valid_attrs %{email: "foo@bar.com", original_password: "123456", first_name: "Foo", last_name: "Bar"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with empty attributes" do
    changeset = User.changeset(%User{}, %{})
    refute changeset.valid?
  end

  test "changeset with empty email" do
    valid_attrs = Map.delete(@valid_attrs, :email)
    changeset = User.changeset(%User{}, valid_attrs)
    refute changeset.valid?
  end

  test "create user with existing email" do
    insert(:user)
    changeset = User.changeset(%User{}, @valid_attrs)
    {:error, changeset} = Repo.insert(changeset)
    refute changeset.valid?
  end

  test "changeset with empty password" do
    valid_attrs = Map.delete(@valid_attrs, :original_password)
    changeset = User.changeset(%User{}, valid_attrs)
    refute changeset.valid?
  end

  test "changeset with short password" do
    valid_attrs = Map.put(@valid_attrs, :original_password, "123")
    changeset = User.changeset(%User{}, valid_attrs)
    refute changeset.valid?
  end

  test "changeset with empty first_name" do
    valid_attrs = Map.delete(@valid_attrs, :first_name)
    changeset = User.changeset(%User{}, valid_attrs)
    refute changeset.valid?
  end

  test "changeset with empty last_name" do
    valid_attrs = Map.delete(@valid_attrs, :last_name)
    changeset = User.changeset(%User{}, valid_attrs)
    refute changeset.valid?
  end
end
