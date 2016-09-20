defmodule ApiWithPhoenixDemo.Assertion do
  defmacro assert_contains(struct, keys) do
    quote do
      Map.from_struct(unquote(struct))
      |> Map.keys
      |> Enum.each(fn(key) -> assert Enum.member?(unquote(keys), key) end)
    end
  end
end
