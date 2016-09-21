defmodule ApiWithPhoenixDemo.TokenController do
  use ApiWithPhoenixDemo.Web, :controller

  alias ApiWithPhoenixDemo.Auth.Token

  plug Guardian.Plug.EnsureAuthenticated

  def revoke(conn, _params) do
    case Token.revoke(conn) do
      {:error, error} -> {:error, error}
      :ok -> render(conn, "revoke.json", [])
    end
  end

  def refresh(conn, _params) do
    case Token.refresh(conn) do
      {:error, error} -> {:error, error}
      {:ok, _, token} -> render(conn, ApiWithPhoenixDemo.AuthView, "login.json", token)
    end
  end
end
