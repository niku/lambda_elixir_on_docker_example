defmodule LambdaElixirOnDockerExample.ReservedEnvironmentVariable do
  # https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-runtime
  defstruct [
    :_handler,
    :_x_amzn_trace_id,
    :aws_region,
    :aws_execution_env,
    :aws_lambda_function_name,
    :aws_lambda_function_memory_size,
    :aws_lambda_function_version,
    :aws_lambda_initialization_type,
    :aws_lambda_log_group_name,
    :aws_lambda_log_stream_name,
    :aws_access_key_id,
    :aws_secret_access_key,
    :aws_session_token,
    :aws_lambda_runtime_api,
    :lambda_task_root,
    :lambda_runtime_dir,
    :tz
  ]
end
