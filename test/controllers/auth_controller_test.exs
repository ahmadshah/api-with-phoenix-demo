defmodule ApiWithPhoenixDemo.AuthControllerTest do
  use ApiWithPhoenixDemo.ConnCase

  setup do
    insert(:user)
    :ok
  end

  test "authenticate a valid user" do
    response =
      build_conn
      |> post("/v1/authenticate", [email: "foo@bar.com", password: "123456"])
      |> json_response(200)

    assert_response_attributes(response, ["expired-at", "token"])
    assert String.match?(fetch_node(response, "data.attributes.token"), ~r/[a-zA-Z0-9-_.]/)
    assert is_integer(fetch_node(response, "data.attributes.expired-at"))

    refute is_nil(fetch_node(response, "data.id"))
  end
end
