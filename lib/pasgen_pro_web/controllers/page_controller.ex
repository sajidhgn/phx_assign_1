defmodule PasgenProWeb.PageController do
  use PasgenProWeb, :controller

  alias PasgenPro.Pasgen.PasGen

  @number_chars "0123456789"
  @uppercase_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  @symbol_chars "!@#$%^&*()_+-=[]{}|;:'\",.<>/?\\"

  def home(conn, _params) do
    changeset = PasGen.changeset(%PasGen{}, %{})

    list = %{
      "password_field" => "A6*(9%",
      "symbol_field" => "true",
      "length_field" => 6,
      "number_field" => "true",
      "uppercase_field" => "true"
    }

    render(conn, :home, list: list, changeset: changeset)
  end

  def create(conn, %{"pas_gen" => list}) do
    changeset = PasGen.changeset(%PasGen{}, list)

    if changeset.valid? do
      length = Map.get(list, "length_field") |> String.to_integer()
      number = if list["number_field"] == "true", do: "true", else: ""
      uppercase = if list["uppercase_field"] == "true", do: "true", else: ""
      symbol = if list["symbol_field"] == "true", do: "true", else: ""

      password = password_gen(list)

      conn
      |> render(:home,
        list: %{
          "password_field" => password,
          "symbol_field" => symbol,
          "length_field" => length,
          "number_field" => number,
          "uppercase_field" => uppercase
        },
        changeset: changeset
      )
    else
      conn
      |> render(:home, changeset: changeset)
    end
  end

  def password_gen(attrs \\ %{}) do
    length = Map.get(attrs, "length_field") |> String.to_integer()
    number = if attrs["number_field"] == "true", do: "true", else: ""
    uppercase = if attrs["uppercase_field"] == "true", do: "true", else: ""
    symbol = if attrs["symbol_field"] == "true", do: "true", else: ""

    charset =
      [
        if(String.length(symbol) > 0, do: @symbol_chars, else: ""),
        if(String.length(uppercase) > 0, do: @uppercase_chars, else: ""),
        if(String.length(number) > 0, do: @number_chars, else: "")
      ]
      # Filter out empty strings
      |> Enum.filter(&(&1 != ""))
      |> Enum.join()

    char_list = String.graphemes(charset)

    #   password = Enum.reduce(1..length, "", fn _i, acc ->
      #   char = Enum.random(char_list)
      #   acc <> char
      # end)

      password = Enum.take_random(char_list, length)

    password
  end
end
