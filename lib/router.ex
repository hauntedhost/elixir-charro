defmodule Charro.Router do

  def call(conn) do
    content_for(conn.req_path, conn)
  end

  def content_for("/", conn) do
    Map.merge(conn, %{
      resp_code: 200,
      resp_body: "OK",
      resp_headers: default_resp_headers(),
    })
  end

  def content_for("/ping", conn) do
    Map.merge(conn, %{
      resp_code: 200,
      resp_body: "PING",
      resp_headers: default_resp_headers(),
    })
  end

  def content_for(_, conn) do
    Map.merge(conn, %{
      resp_code: 404,
      resp_body: "",
      resp_headers: default_resp_headers(),
    })
  end

  defp default_resp_headers do
    [
      {"content-type", "text/html"},
    ]
  end
end
