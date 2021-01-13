# LambdaElixirOnDockerExample

An AWS Lambda example that is built by Elixir on Docker container

# Motivation

[mix_erllambda](https://github.com/alertlogic/mix_erllambda) already has a mix command `mix erllambda.release` that updates a function for AWS lambda.
However, it uses a 3rd party library [distillery](https://github.com/bitwalker/distillery).

To keep deploy simple, this repository uses only standard library.
(It uses docker container though :p)

# How to use

## Check it works on your local environment

```
$ git clone https://github.com/niku/lambda_elixir_on_docker_example
$ cd lambda_elixir_on_docker_example
$ docker build -t lambda_elixir_on_docker_example .
$ docker container run --rm -p 9000:8080 lambda_elixir_on_docker_example
time="2021-02-03T13:50:08.821" level=info msg="exec '/var/runtime/bootstrap' (cwd=/var/task, handler=)"
```

and then start an other new terminal

```
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{"hello": "world"}'
hello~
```

If you can see the response above, it has worked properly.

## Push container image to Amazon ECR to use from AWS Lambda function

```
$ docker build -t lambda_elixir_on_docker_example .
$ aws ecr create-repository --repository-name lambda-elixir-repo --region ap-northeast-1
"012345678901.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-repo"
$ aws ecr get-login-password | docker login --username AWS --password-stdin 012345678901.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-repo
$ docker tag lambda_elixir_on_docker_example 012345678901.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-repo
$ docker push 012345678901.dkr.ecr.ap-northeast-1.amazonaws.com/lambda-elixir-repo
```

## Create an AWS Lambda function

https://aws.amazon.com/blogs/aws/new-for-aws-lambda-container-image-support/
