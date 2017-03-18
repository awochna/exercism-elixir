defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split([" ", "-", ","])
    |> Enum.map(fn(word) ->
      {first, remaining} = String.split_at(word, 1)
      extras = Regex.run(~r/[A-Z]/, remaining)
      if (extras) do
        Enum.join([first] ++ extras)
      else
        first
      end
    end)
    |> Enum.join
    |> String.upcase
  end
end
