defmodule TextBus.Handlers.WS do
  @behaviour :cowboy_websocket

  def init(req, _state) do
    topic = :cowboy_req.binding(:topic, req)
    ensure_topic(topic)
    {:cowboy_websocket, req, %{topic: topic}}
  end

  def websocket_init(state) do
    TextBus.Topic.subscribe(state.topic, self())
    {:ok, state}
  end

  def websocket_handle({:text, msg}, state) do
    TextBus.Topic.publish(state.topic, msg)
    {:ok, state}
  end

  def websocket_info({:message, _topic, seq, msg}, state) do
    {:reply, {:text, Jason.encode!(%{id: seq, data: msg})}, state}
  end

  def terminate(_reason, _req, state) do
    TextBus.Topic.unsubscribe(state.topic, self())
    :ok
  end

  defp ensure_topic(name) do
    case Registry.lookup(TextBus.TopicRegistry, name) do
      [] -> TextBus.TopicSup.start_topic(name)
      _ -> :ok
    end
  end
end
