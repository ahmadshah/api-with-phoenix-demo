defmodule ApiWithPhoenixDemo.Router do
  use ApiWithPhoenixDemo.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWithPhoenixDemo do
    pipe_through :api
  end
end
