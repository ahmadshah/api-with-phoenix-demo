defmodule ApiWithPhoenixDemo.Router do
  use ApiWithPhoenixDemo.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/v1", ApiWithPhoenixDemo do
    pipe_through :api
    post "/authenticate", AuthController, :login
    get "/token/revoke", TokenController, :revoke
    get "/token/refresh", TokenController, :refresh
  end
end
