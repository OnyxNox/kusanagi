defmodule TextBus.Handlers.SSE do
  @behaviour :cowboy_handler

  def init(req, state) do
    topic = :cowboy_req.binding(:topic, req)
    ensure_topic(topic)

    TextBus.Topic.subscribe(topic, self())

    req =
      :cowboy_req.stream_reply(200, %{
        "content-type" => "text/event-stream",
        "cache-control" => "no-cache",
        "connection" => "keep-alive"
      }, req)

    loop(req, topic)
    {:ok, req, state}
  end

  defp loop(req, topic) do
    receive do
      {:message, ^topic, seq, msg} ->
        frame = "id: #{seq}\ndata: #{msg}\n\n"
        :ok = :cowboy_req.stream_body(frame, :nofin, req)
        loop(req, topic)

      {:cowboy_req, :terminate} ->
        TextBus.Topic.unsubscribe(topic, self())
        :ok
    end
  end

  defp ensure_topic(name) do
    case Registry.lookup(TextBus.TopicRegistry, name) do
      [] -> TextBus.TopicSup.start_topic(name)
      _ -> :ok
    end
  end
end
