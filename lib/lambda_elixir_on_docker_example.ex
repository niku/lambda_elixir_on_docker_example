defmodule LambdaElixirOnDockerExample do
  @moduledoc """
  Documentation for `LambdaElixirOnDockerExample`.
  """

  def handle(body, invocation_data) do
    IO.inspect({body, invocation_data})

    IO.inspect(
      get_lambda_runtime_cognito_identity:
      LambdaElixirOnDockerExample.InvocationData.get_lambda_runtime_cognito_identity(
        invocation_data
      )
    )

    "hello~"
  end
end
