defmodule Context.Repo do
  use Ecto.Repo,
    otp_app: :context,
    adapter: Ecto.Adapters.Postgres
end
