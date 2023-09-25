defmodule PasgenProWeb.PageController do
  use PasgenProWeb, :controller

  alias PasgenPro.Pasgen.PasGen

  @number_chars "0123456789"
  @symbol_chars "!@#$%^&*()_+-=[]{}|;:'\",.<>/?"
  @uppercase_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  def home(conn, _params) do
    changeset = PasGen.changeset(%PasGen{}, %{})
    list = %{"password_field" => "120358yi", "length_field" => 1}
    render(conn, :home, list: list, changeset: changeset)
  end


  def create(conn, %{"pas_gen" => list}) do
    changeset =  PasGen.changeset( %PasGen{}, list)

    if changeset.valid? do
    length = Map.get(list, "length_field") |> String.to_integer()
    number = if list["number_field"]=="true", do: "true", else: ""
    uppercase = if list["uppercase_field"]=="true", do: "true", else: ""
    symbol = if list["symbol_field"]=="true", do: "true", else: ""
  {:ok, password} = generate_password(length, symbol, uppercase, number)
      conn |> render(:home, list: %{"password_field" => password, "symbol_field" => symbol, "length_field" => length,"number_field" => number, "uppercase_field" => uppercase}, changeset: changeset)
    else
      conn
      |> render(:home, changeset: changeset)
    end
  end

  def generate_password(length, use_symbols, use_uppercase, use_numbers) do
    charset =
      String.trim_trailing(
        (if use_symbols, do: @symbol_chars, else: "") <>
        (if use_uppercase, do: @uppercase_chars, else: "") <>
        (if use_numbers, do: @number_chars, else: "")
      )

      if length <= String.length(charset) do
        password = generate_password_recursive(charset, length, "")
        {:ok, password}
      else
        {:error, "Invalid parameter types. Please ensure that number, uppercase, and symbol are booleans, and length is an integer."}
      end

  end

  defp generate_password_recursive(_, 0, password) do
    password
  end
  defp generate_password_recursive(alphabet, length, password) do
    random_index = :rand.uniform(String.length(alphabet))
    random_char = String.at(alphabet, random_index)
    generate_password_recursive(alphabet, length - 1, password <> random_char)
  end
end
