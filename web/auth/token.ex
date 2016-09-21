defmodule ApiWithPhoenixDemo.Auth.Token do
  alias Guardian.Plug, as: Guardian
  alias ApiWithPhoenixDemo.Auth.Jwt

  def grant(conn, user) do
    conn = Guardian.api_sign_in(conn, user)
    {:ok, claims} = Guardian.claims(conn)

    token = %Jwt{
      id: user.id,
      token: Guardian.current_token(conn),
      expired_at: claims["exp"]
    }

    {:ok, conn, token}
  end

  def revoke(conn) do

  end

  def refresh(conn) do

  end
end
