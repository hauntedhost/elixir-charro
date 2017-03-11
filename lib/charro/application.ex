defmodule Charro.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # match any host, any route
    dispatch_config = :cowboy_router.compile([
      {:_, [{:_, Charro.CowboyHandler, [router: Charro.Router]}]}
    ])

    # start http server
    :cowboy.start_http(
      :http,
      100,
      [{:port, 4000}],
      [{:env, [{:dispatch, dispatch_config}]}]
    )

    children = []
    opts = [strategy: :one_for_one, name: Charro.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
