defmodule LambdaElixirOnDockerExample.InvocationData do
  def get_lambda_runtime_aws_request_id(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-aws-request-id', invocation_data, nil) do
      x
      |> to_string()
    end
  end

  def get_lambda_runtime_deadline_ms(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-deadline-ms', invocation_data, nil) do
      x
      |> to_string()
      |> String.to_integer()
    end
  end

  def get_lambda_runtime_invoked_function_arn(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-invoked-function-arn', invocation_data, nil) do
      x
      |> to_string()
    end
  end

  def get_lambda_runtime_trace_id(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-trace-id', invocation_data, nil) do
      x
      |> to_string()
    end
  end

  def get_lambda_runtime_client_context(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-client-context', invocation_data, nil) do
      x
      |> to_string()
    end
  end

  def get_lambda_runtime_cognito_identity(invocation_data) do
    with x when not is_nil(x) <-
           :proplists.get_value('lambda-runtime-cognito-identity', invocation_data, nil) do
      x
      |> to_string()
    end
  end
end
