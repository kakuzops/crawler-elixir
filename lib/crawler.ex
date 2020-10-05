defmodule Crawler do
  def get_names() do
    case HTTPoison.get("https://www.superherodb.com/naruto-characters/800-498/") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        urls =
          body
          |> Floki.find("div.shdbcard.class-0.icon-character")
          |> Floki.find("a")
          |> Enum.map(fn title -> Floki.attribute(title, "title") end)

        {:ok, urls}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
