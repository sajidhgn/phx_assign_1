defmodule PasgenPro.Pasgen.PasGen do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pas_gen" do
    field :number_field, :boolean, default: false
    field :uppercase_field, :boolean, default: false
    field :symbol_field, :boolean, default: false
    field :length_field, :integer

    timestamps()
  end

  @doc false
  def changeset(pas_gen, attrs) do
    pas_gen
    |> cast(attrs, [:number_field, :uppercase_field, :symbol_field, :length_field])
    |> validate_required([:number_field, :uppercase_field, :symbol_field, :length_field])
  end
end
