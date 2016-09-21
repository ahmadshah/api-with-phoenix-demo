defmodule ApiWithPhoenixDemo.Assertion do
  defmacro fetch_node(map, node) do
    quote do
      String.split(unquote(node), ".")
      |> Enum.reduce(unquote(map), fn(n, m) -> Map.get(m, n) end)
    end
  end

  defmacro assert_contains(struct, keys) do
    quote do
      Map.from_struct(unquote(struct))
      |> Map.keys
      |> Enum.each(fn(key) -> assert Enum.member?(unquote(keys), key) end)
    end
  end

  defmacro assert_response_attributes(response, keys) do
    quote do
      attributes =
        fetch_node(unquote(response), "data.attributes")
        |> Map.keys

      Enum.each(attributes, fn(attr) -> assert Enum.member?(unquote(keys), attr) end)
    end
  end
end
