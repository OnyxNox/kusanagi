defmodule TextBus.TopicSup do
  use DynamicSupervisor

  def start_link(_), do: DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_topic(name) do
    child_spec = {TextBus.Topic, name}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
