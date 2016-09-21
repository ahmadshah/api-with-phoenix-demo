defmodule ApiWithPhoenixDemo.Auth.AuthenticatorTest do
  use ApiWithPhoenixDemo.ModelCase

  import ApiWithPhoenixDemo.Factory

  alias ApiWithPhoenixDemo.Auth.Authenticator

  test "authenticate user" do
    insert(:user)
    {:ok, user} = Authenticator.authenticate("foo@bar.com", "123456")
    assert is_integer(user.id)
  end
end
