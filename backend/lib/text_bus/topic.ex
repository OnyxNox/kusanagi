defmodule TextBus.Topic do
  use GenServer

  def start_link(name), do: GenServer.start_link(__MODULE__, name, name: via(name))
  def publish(topic, msg), do: GenServer.cast(via(topic), {:publish, msg})
  def subscribe(topic, pid), do: GenServer.cast(via(topic), {:subscribe, pid})
  def unsubscribe(topic, pid), do: GenServer.cast(via(topic), {:unsubscribe, pid})
  def replay(topic, n), do: GenServer.call(via(topic), {:replay, n})

  defp via(name), do: {:via, Registry, {TextBus.TopicRegistry, name}}

  def init(name) do
    table = :ets.new(:topic_messages, [:ordered_set, :protected])
    {:ok, %{name: name, seq: 0, table: table, subs: MapSet.new()}}
  end

  def handle_cast({:publish, msg}, state) do
    seq = state.seq + 1
    :ets.insert(state.table, {seq, msg})
    Enum.each(state.subs, fn pid -> send(pid, {:message, state.name, seq, msg}) end)
    {:noreply, %{state | seq: seq}}
  end

  def handle_cast({:subscribe, pid}, state),
    do: {:noreply, %{state | subs: MapSet.put(state.subs, pid)}}

  def handle_cast({:unsubscribe, pid}, state),
    do: {:noreply, %{state | subs: MapSet.delete(state.subs, pid)}}

  def handle_call({:replay, n}, _from, state) do
    msgs =
      :ets.tab2list(state.table)
      |> Enum.sort_by(&elem(&1, 0))
      |> Enum.take(-n)

    {:reply, msgs, state}
  end
end
