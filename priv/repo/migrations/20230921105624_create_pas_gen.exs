defmodule PasgenPro.Repo.Migrations.CreatePasGen do
  use Ecto.Migration

  def change do
    create table(:pas_gen) do
      add :number_field, :boolean, default: false, null: false
      add :uppercase_field, :boolean, default: false, null: false
      add :symbol_field, :boolean, default: false, null: false
      add :length_field, :integer

      timestamps()
    end
  end
end
