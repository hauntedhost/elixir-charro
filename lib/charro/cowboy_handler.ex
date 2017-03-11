defmodule Charro.CowboyHandler do

  def init(_type, req, opts) do
    {:ok, req, opts}
  end

  def handle(request, opts) do
    router = Keyword.fetch!(opts, :router)

    conn =
      request
      |> new_conn
      |> router.call

    {:ok, reply} = :cowboy_req.reply(
      conn.resp_code,
      conn.resp_headers,
      conn.resp_body,
      request
    )

    {:ok, reply, opts}
  end

  def terminate(_reason, _request, _state), do: :ok

  defp new_conn(request) do
    {req_path, _request} = :cowboy_req.path(request)
    %{req_path: req_path}
  end
end
