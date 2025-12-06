defmodule TextBus.Handlers.Health do
  @behaviour :cowboy_handler

  def init(req, state) do
    req =
      :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "Pong!", req)

    {:ok, req, state}
  end
end
