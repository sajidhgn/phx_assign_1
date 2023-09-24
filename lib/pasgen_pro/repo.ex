defmodule PasgenPro.Repo do
  use Ecto.Repo,
    otp_app: :pasgen_pro,
    adapter: Ecto.Adapters.Postgres
end
