defmodule ApiWithPhoenixDemo.Auth.AuthenticatorTest do
  use ApiWithPhoenixDemo.ConnCase

  import ApiWithPhoenixDemo.Factory

  alias ApiWithPhoenixDemo.Auth.Authenticator

  test "authenticate user" do
    insert(:user)
    {:ok, _, token} =
      build_conn
      |> Authenticator.authenticate("foo@bar.com", "123456")
    assert_contains(token, [:id, :expired_at, :token])
    assert is_integer(token.id)
    assert is_integer(token.expired_at)
    assert String.match?(token.token, ~r/[A-Za-z0-9.-_]/)
  end
end
