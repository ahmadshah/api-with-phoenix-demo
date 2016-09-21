defmodule ApiWithPhoenixDemo.AuthView do
  use ApiWithPhoenixDemo.Web, :view

  def render("login.json", token) do
    JaSerializer.format(ApiWithPhoenixDemo.TokenSerializer, token)
  end
end
