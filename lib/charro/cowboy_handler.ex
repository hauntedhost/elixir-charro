defmodule Charro.CowboyHandler do

  def init(_type, req, opts) do
    {:ok, req, opts}
  end

  def handle(request, opts) do
    {:ok, reply} = :cowboy_req.reply(
      200,
      [{"content-type", "text/html"}],
      "OK",
      request
    )

    {:ok, reply, opts}
  end

  def terminate(_reason, _request, _state), do: :ok
end
