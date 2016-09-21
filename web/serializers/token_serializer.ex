defmodule ApiWithPhoenixDemo.TokenSerializer do
  use JaSerializer

  attributes [:token, :expired_at]
end
