ARG container_version=al2.2021.01.06.10
FROM public.ecr.aws/lambda/provided:${container_version}

ENV LANG C.UTF-8
ENV ERLANG_VERSION OTP-23.2.3
ENV ELIXIR_VERSION v1.11.3

WORKDIR /tmp

RUN yum -y groupinstall "Development Tools" && \
  yum -y install ncurses-devel openssl-devel && \
  git clone https://github.com/erlang/otp.git -b ${ERLANG_VERSION} && \
  cd otp && \
  ./otp_build autoconf && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  git clone https://github.com/elixir-lang/elixir.git -b ${ELIXIR_VERSION} && \
  cd elixir && \
  make && \
  make install

COPY . /app

RUN cd /app && \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix clean && \
  mix deps.get --only prod && \
  MIX_ENV=prod mix release --path /release && \
  chmod -R a=rX /release

FROM public.ecr.aws/lambda/provided:${container_version}

ENV LANG C.UTF-8

COPY --from=0 /release .
COPY --chmod=755 priv/bootstrap ${LAMBDA_RUNTIME_DIR}/bootstrap
CMD ["Elixir.LambdaElixirOnDockerExample.handle"]
