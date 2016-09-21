defmodule ApiWithPhoenixDemo.AuthController do
  use ApiWithPhoenixDemo.Web, :controller

  alias ApiWithPhoenixDemo.Auth.{Authenticator, Token}

  plug Guardian.Plug.EnsureNotAuthenticated

  def login(conn, %{"email" => email, "password" => password}) do
    case Authenticator.authenticate(email, password) do
      {:error} -> {:error}
      {:ok, user} ->
        {:ok, conn, token} = Token.grant(conn, user)
        render(conn, "login.json", token)
    end
  end
end
