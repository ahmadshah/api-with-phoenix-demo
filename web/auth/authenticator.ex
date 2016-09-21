defmodule ApiWithPhoenixDemo.Auth.Authenticator do
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Guardian.Plug, as: Guardian
  alias ApiWithPhoenixDemo.{Repo, User, Auth.Token}

  def authenticate(email, password) do
    try do
      user = Repo.get_by!(User, email: email)
      case checkpw(password, user.password) do
        false -> {:error}
        true -> {:ok, user}
      end
    rescue
      Ecto.NoResultsError -> {:error}
    end
  end
end
