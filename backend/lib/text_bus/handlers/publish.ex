defmodule TextBus.Handlers.Publish do
  @behaviour :cowboy_handler

  def init(req, state) do
    topic = :cowboy_req.binding(:topic, req)
    {:ok, body, req} = :cowboy_req.read_body(req)

    case Jason.decode(body) do
      {:ok, %{"message" => msg}} ->
        ensure_topic(topic)
        TextBus.Topic.publish(topic, msg)

        req =
          :cowboy_req.stream_reply(202, %{"content-type" => "application/json"}, req)

        :ok = :cowboy_req.stream_body(~s({"status":"accepted"}), :fin, req)
        {:ok, req, state}

      _ ->
        {:ok, req} = :cowboy_req.reply(400, %{}, "invalid", req)
        {:ok, req, state}
    end
  end

  defp ensure_topic(name) do
    case Registry.lookup(TextBus.TopicRegistry, name) do
      [] -> TextBus.TopicSup.start_topic(name)
      _ -> :ok
    end
  end
end
