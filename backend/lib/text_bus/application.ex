defmodule TextBus.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Create an in-memory registry to track topics
      {Registry, keys: :unique, name: TextBus.TopicRegistry},
      TextBus.TopicSup,
      TextBus.HTTPServer
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TextBus.Supervisor)
  end
end
