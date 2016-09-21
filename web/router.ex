defmodule ApiWithPhoenixDemo.Router do
  use ApiWithPhoenixDemo.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", ApiWithPhoenixDemo do
    pipe_through :api
    post "/authenticate", AuthController, :login
  end
end
