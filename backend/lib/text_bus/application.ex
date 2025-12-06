defmodule TextBus.Application do
  use Application

  def start(_type, _args) do
    children = [TextBus.HTTPServer]

    Supervisor.start_link(children, strategy: :one_for_one, name: TextBus.Supervisor)
  end
end
