defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) -> "Sure."
      all_caps?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp question?(input) do
    String.last(input) == "?"
  end

  defp all_caps?(input) do
    input == String.upcase(input) && String.match?(input, ~r/[^\d, ]+/)
  end
end
