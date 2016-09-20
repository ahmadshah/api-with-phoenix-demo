defmodule ApiWithPhoenixDemo.Factory do
  use ExMachina.Ecto, repo: ApiWithPhoenixDemo.Repo

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  def user_factory do
    %ApiWithPhoenixDemo.User{
      email: "foo@bar.com",
      password: hashpwsalt("123456"),
      first_name: "Foo",
      last_name: "Bar"
    }
  end
end
