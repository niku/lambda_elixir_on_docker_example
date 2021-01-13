defmodule LambdaElixirOnDockerExample.Poller do
  use GenServer

  def start_link([]) do
    reserved_environment_variable = %LambdaElixirOnDockerExample.ReservedEnvironmentVariable{
      _handler: Application.fetch_env!(:lambda_elixir_on_docker_example, :_handler),
      _x_amzn_trace_id:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :_x_amzn_trace_id),
      aws_region: Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_region),
      aws_execution_env:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_execution_env),
      aws_lambda_function_name:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_function_name),
      aws_lambda_function_memory_size:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_function_memory_size),
      aws_lambda_function_version:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_function_version),
      aws_lambda_initialization_type:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_initialization_type),
      aws_lambda_log_group_name:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_log_group_name),
      aws_lambda_log_stream_name:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_log_stream_name),
      aws_access_key_id:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_access_key_id),
      aws_secret_access_key:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_secret_access_key),
      aws_session_token:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_session_token),
      aws_lambda_runtime_api:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :aws_lambda_runtime_api),
      lambda_task_root:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :lambda_task_root),
      lambda_runtime_dir:
        Application.fetch_env!(:lambda_elixir_on_docker_example, :lambda_runtime_dir),
      tz: Application.fetch_env!(:lambda_elixir_on_docker_example, :tz)
    }

    GenServer.start_link(__MODULE__, reserved_environment_variable)
  end

  def init(
        %LambdaElixirOnDockerExample.ReservedEnvironmentVariable{} = reserved_environment_variable
      ) do
    send(self(), :poll)
    {:ok, reserved_environment_variable}
  end

  def handle_info(
        :poll,
        %LambdaElixirOnDockerExample.ReservedEnvironmentVariable{
          _handler: handler,
          aws_lambda_runtime_api: aws_lambda_runtime_api
        } = reserved_environment_variable
      ) do
    {:ok, {_, headers, body}} =
      :httpc.request(
        :get,
        {'http://#{aws_lambda_runtime_api}/2018-06-01/runtime/invocation/next', []},
        [],
        []
      )

    lambda_runtime_aws_request_id =
      :proplists.get_value('lambda-runtime-aws-request-id', headers)
      |> to_string()

    lambda_runtime_deadline_ms =
      :proplists.get_value('lambda-runtime-deadline-ms', headers)
      |> to_string()
      |> String.to_integer()

    body =
      body
      |> to_string()

    [function | reversed_modules] =
      handler
      |> String.split(".", trim: true)
      |> Enum.reverse()

    module =
      reversed_modules
      |> Enum.reverse()
      |> Enum.join(".")
      |> String.to_atom()

    response =
      apply(module, String.to_atom(function), [
        reserved_environment_variable,
        body,
        lambda_runtime_aws_request_id,
        lambda_runtime_deadline_ms
      ])

    {:ok, x} =
      :httpc.request(
        :post,
        {'http://#{aws_lambda_runtime_api}/2018-06-01/runtime/invocation/#{
           lambda_runtime_aws_request_id
         }/response', [], [], response},
        [],
        []
      )

    send(self(), :poll)
    {:noreply, reserved_environment_variable}
  end
end
