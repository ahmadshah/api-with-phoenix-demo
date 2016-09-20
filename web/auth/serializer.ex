defmodule ApiWithPhoenixDemo.Auth.Serializer do
  @behaviour Guardian.Serializer

  alias ApiWithPhoenixDemo.Repo
  alias ApiWithPhoenixDemo.User

  def for_token(user = %User{}), do: {
    :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknow resource type" }

  def from_token("User:" <> id), do: { :ok, Repo.get(User, id) }
  def from_token(_), do: { :error, "Unkown resource type" }
end
