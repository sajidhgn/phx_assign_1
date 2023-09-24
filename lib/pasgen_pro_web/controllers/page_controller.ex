defmodule PasgenProWeb.PageController do
  use PasgenProWeb, :controller

  alias PasgenPro.Pasgen.PasGen

  def home(conn, _params) do
    changeset = PasGen.changeset(%PasGen{}, %{})
    list = %{
      "length_field" => "1",
      "number_field" => "true",
      "symbol_field" => "true",
      "uppercase_field" => "true"
    }
    render(conn, :home, list: list, changeset: changeset)
  end

  
  def create(conn, %{"pas_gen" => list}) do
    changeset =  PasGen.changeset( %PasGen{}, list)
    if changeset.valid? do
      conn
      |> render(:home, list: list, changeset: changeset)
    else
      conn
      |> render(:home, list: list, changeset: changeset)
    end
  end
end
