defmodule ApiWithPhoenixDemo.Auth.Authenticator do
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Guardian.Plug, as: Guardian
  alias ApiWithPhoenixDemo.{Repo, User, Auth.Token}

  def authenticate(conn, email, password) do
    try do
      user = Repo.get_by!(User, email: email)
      case checkpw(password, user.password) do
        false -> {:error}
        true -> grant_token(conn, user)
      end
    rescue
      Ecto.NoResultsError -> {:error}
    end
  end

  defp grant_token(conn, user) do
    conn = Guardian.api_sign_in(conn, user)
    {:ok, claims} = Guardian.claims(conn)

    token = %Token{
      id: user.id,
      token: Guardian.current_token(conn),
      expired_at: Map.get(claims, "exp")
    }

    {:ok, conn, token}
  end
end
