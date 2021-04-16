import Config

config :friends, Friends.Repo,
  database: "friends_repo",
  username: "postgres",
  password: "123456",
  hostname: "localhost"

# Isso irá permitir à nossa aplicação rodar tarefas mix do Ecto a partir da linha de comando.
config :friends, ecto_repos: [Friends.Repo]
