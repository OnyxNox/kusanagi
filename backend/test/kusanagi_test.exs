defmodule KusanagiTest do
  use ExUnit.Case
  doctest Kusanagi

  test "greets the world" do
    assert Kusanagi.hello() == :world
  end
end
