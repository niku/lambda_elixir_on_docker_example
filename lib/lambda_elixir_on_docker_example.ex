defmodule LambdaElixirOnDockerExample do
  @moduledoc """
  Documentation for `LambdaElixirOnDockerExample`.
  """

  def handle(
        %LambdaElixirOnDockerExample.ReservedEnvironmentVariable{},
        body,
        lambda_runtime_aws_request_id,
        lambda_runtime_deadline_ms
      ) do
    IO.inspect({body, lambda_runtime_aws_request_id, lambda_runtime_deadline_ms})
    "hello~"
  end
end
