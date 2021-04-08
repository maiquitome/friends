defmodule Friends.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Friends.Worker.start_link(arg)
      # {Friends.Worker, arg}

      # iremos configurar o Friends.Repo como supervisor de nossa árvore de supervisão.
      # Isso irá iniciar o processo do Ecto assim que nossa aplicação iniciar.
      Friends.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Friends.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
