defmodule LambdaElixirOnDockerExampleTest do
  use ExUnit.Case
  doctest LambdaElixirOnDockerExample

  test "greets the world" do
    assert LambdaElixirOnDockerExample.hello() == :world
  end
end
