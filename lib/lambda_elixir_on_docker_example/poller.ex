defmodule LambdaElixirOnDockerExample.Poller do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end

  def init([]) do
    send(self(), :poll)
    {:ok, []}
  end

  def handle_info(:poll, []) do
    aws_lambda_runtime_api =
      LambdaElixirOnDockerExample.DefinedEnvironmentVariable.get_aws_lambda_runtime_api()

    handler = LambdaElixirOnDockerExample.DefinedEnvironmentVariable.get__handler()

    {:ok, {_, headers, body}} =
      :httpc.request(
        :get,
        {'http://#{aws_lambda_runtime_api}/2018-06-01/runtime/invocation/next', []},
        [timeout: :infinity],
        []
      )

    lambda_runtime_aws_request_id =
      LambdaElixirOnDockerExample.InvocationData.get_lambda_runtime_aws_request_id(headers)

    [function_name | reversed_module_name] =
      handler
      |> String.split(".", trim: true)
      |> Enum.reverse()
      |> Enum.map(&String.to_atom/1)

    module =
      reversed_module_name
      |> Enum.reverse()
      |> Module.concat()

    response =
      Task.Supervisor.async(
        LambdaElixirOnDockerExample.TaskSupervisor,
        module,
        function_name,
        [
          to_string(body),
          headers
        ]
      )
      |> Task.await()

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
    {:noreply, []}
  end
end
