defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    if (Regex.match?(~r/^[01]+$/, string)) do
      string
      |> String.graphemes
      |> Enum.map(&String.to_integer/1)
      |> reduce_to_decimal
    else
      0
    end
  end

  defp reduce_to_decimal(digits, acc \\ 0)
  defp reduce_to_decimal([], acc), do: acc
  defp reduce_to_decimal([digit | rest], acc) do
    reduce_to_decimal(rest, acc + (digit * pwr(2, length(rest))))
  end

  defp pwr(_base, 0), do: 1
  defp pwr(base, exp) do
    base * pwr(base, exp - 1)
  end
end
