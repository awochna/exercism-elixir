defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _base_a, _base_b), do: nil
  def convert(_, base_1, base_b) when base_1 < 2 or base_b < 2, do: nil
  def convert(digits, base_a, base_b) when base_b == 10 do
    number = convert_to_base_10(digits, base_a)
    if (number == nil) do
      nil
    else
      Integer.digits(number)
    end
  end
  def convert(digits, base_a, base_b) when base_a == 10 do
    digits
    |> positional_add
    |> convert_to_base(base_b)
  end
  def convert(digits, base_a, base_b) do
    digits
    |> convert_to_base_10(base_a)
    |> convert_to_base(base_b)
  end

  defp convert_to_base_10(digits, base, converted \\ [])
  defp convert_to_base_10([], _base, converted) do
    Enum.reduce(converted, &(&1 + &2))
  end
  defp convert_to_base_10([digit | _], base, _) when digit < 0 or digit >= base do
    nil
  end
  defp convert_to_base_10([digit | tail], base, converted) do
    convert_to_base_10(tail, base, converted ++ [digit * pwr(base, length(tail))])
  end

  defp convert_to_base(number, base, converted \\ [])
  defp convert_to_base(nil, _base, _), do: nil
  defp convert_to_base(0, _base, []), do: [0]
  defp convert_to_base(0, _base, converted), do: Enum.reverse(converted)
  defp convert_to_base(number, base, converted) do
    rest = Integer.floor_div(number, base)
    remainder = rem(number, base)
    convert_to_base(rest, base, converted ++ [remainder])
  end

  defp positional_add(digits, converted \\ [])
  defp positional_add([], converted) do
    Enum.reduce(converted, &(&1 + &2))
  end
  defp positional_add([digit | tail], converted) do
    positional_add(tail, converted ++ [digit * pwr(10, length(tail))])
  end

  defp pwr(_base, 0), do: 1
  defp pwr(base, exp) do
    base * pwr(base, exp - 1)
  end
end
