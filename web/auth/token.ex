defmodule ApiWithPhoenixDemo.Auth.Token do
  alias Guardian.Plug, as: GuardianPlug
  alias ApiWithPhoenixDemo.Repo
  alias ApiWithPhoenixDemo.Auth.Jwt
  alias ApiWithPhoenixDemo.User

  def grant(conn, user) do
    conn = GuardianPlug.api_sign_in(conn, user)
    claims = fetch_claims(conn)

    token = %Jwt{
      id: user.id,
      token: fetch_token(conn),
      expired_at: claims["exp"]
    }

    {:ok, conn, token}
  end

  def revoke(conn), do: Guardian.revoke!(fetch_token(conn), fetch_claims(conn))

  def refresh(conn) do
    resource = fetch_user(conn)
    user = Repo.get(User, resource.id)
    ttl = Application.fetch_env!(:guardian, Guardian)[:ttl]

    case Guardian.refresh!(fetch_token(conn), fetch_claims(conn), %{ttl: ttl}) do
      {:error, error} -> {:error, error}
      {:ok, new_token, new_claims} ->
        token = %Jwt{
          id: user.id,
          token: new_token,
          expired_at: new_claims["exp"]
        }

        {:ok, conn, token}
    end
  end

  defp fetch_token(conn), do: GuardianPlug.current_token(conn)

  defp fetch_claims(conn) do
    {:ok, claims} = GuardianPlug.claims(conn)
    claims
  end

  defp fetch_user(conn), do: GuardianPlug.current_resource(conn)
end
