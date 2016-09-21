defmodule ApiWithPhoenixDemo.TokenControllerTest do
  use ApiWithPhoenixDemo.ConnCase

  setup do
    user = insert(:user)
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn =
      build_conn
      |> put_req_header("authorization", "Bearer #{jwt}")
    %{conn: conn}
  end

  test "revoke token", conn do
    response =
      get(conn.conn, "/v1/token/revoke")
      |> json_response(200)

    assert %{} = response
  end

  test "refresh token", conn do
    response =
      get(conn.conn, "/v1/token/refresh")
      |> json_response(200)

    assert_response_attributes(response, ["expired-at", "token"])
    assert String.match?(fetch_node(response, "data.attributes.token"), ~r/[a-zA-Z0-9-_.]/)
    assert is_integer(fetch_node(response, "data.attributes.expired-at"))

    refute is_nil(fetch_node(response, "data.id"))
  end
end
