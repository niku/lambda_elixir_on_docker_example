defmodule LambdaElixirOnDockerExample.DefinedEnvironmentVariable do
  # https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-runtime

  def get__handler() do
    System.get_env("_HANDLER")
  end

  def get__x_amzn_trace_id() do
    System.get_env("_X_AMZN_TRACE_ID")
  end

  def get_aws_region() do
    System.get_env("AWS_REGION")
  end

  def get_aws_execution_env() do
    System.get_env("AWS_EXECUTION_ENV")
  end

  def get_aws_lambda_function_name() do
    System.get_env("AWS_LAMBDA_FUNCTION_NAME")
  end

  def get_aws_lambda_function_memory_size() do
    System.get_env("AWS_LAMBDA_FUNCTION_MEMORY_SIZE")
  end

  def get_aws_lambda_function_version() do
    System.get_env("AWS_LAMBDA_FUNCTION_VERSION")
  end

  def get_aws_lambda_initialization_type() do
    System.get_env("AWS_LAMBDA_INITIALIZATION_TYPE")
  end

  def get_aws_lambda_log_group_name() do
    System.get_env("AWS_LAMBDA_LOG_GROUP_NAME")
  end

  def get_aws_lambda_log_stream_name() do
    System.get_env("AWS_LAMBDA_LOG_STREAM_NAME")
  end

  def get_aws_access_key_id() do
    System.get_env("AWS_ACCESS_KEY_ID")
  end

  def get_aws_secret_access_key() do
    System.get_env("AWS_SECRET_ACCESS_KEY")
  end

  def get_aws_session_token() do
    System.get_env("AWS_SESSION_TOKEN")
  end

  def get_aws_lambda_runtime_api() do
    System.get_env("AWS_LAMBDA_RUNTIME_API")
  end

  def get_lambda_task_root() do
    System.get_env("LAMBDA_TASK_ROOT")
  end

  def get_lambda_runtime_dir() do
    System.get_env("LAMBDA_RUNTIME_DIR")
  end

  def get_tz() do
    System.get_env("TZ")
  end
end
