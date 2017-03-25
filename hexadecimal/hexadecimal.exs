defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    if (Regex.match?(~r/^[0-9A-Fa-f]+$/, hex)) do
      hex
      |> String.downcase
      |> String.graphemes
      |> accumulate
    else
      0
    end
  end

  defp accumulate(hex, acc \\ 0)
  defp accumulate([], acc), do: acc
  defp accumulate([head | hex], acc) do
    num = convert(head) * pwr(16, length(hex))
    accumulate(hex, acc + num)
  end

  defp convert(hex) do
    case hex do
      "a" -> 10
      "b" -> 11
      "c" -> 12
      "d" -> 13
      "e" -> 14
      "f" -> 15
      _ -> String.to_integer(hex)
    end
  end

  defp pwr(_, 0), do: 1
  defp pwr(base, 1), do: base
  defp pwr(base, exp) do
    base * pwr(base, exp - 1)
  end
end
