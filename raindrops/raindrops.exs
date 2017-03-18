defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    {number, ""}
    |> prime3
    |> prime5
    |> prime7
    |> pass_through
  end

  defp prime3({number, s}) when rem(number, 3) == 0 do
    {number, s <> "Pling"}
  end
  defp prime3({number, s}), do: {number, s}

  defp prime5({number, s}) when rem(number, 5) == 0 do
    {number, s <> "Plang"}
  end
  defp prime5({number, s}), do: {number, s}

  defp prime7({number, s}) when rem(number, 7) == 0 do
    {number, s <> "Plong"}
  end
  defp prime7({number, s}), do: {number, s}

  defp pass_through({number, ""}), do: Integer.to_string(number)
  defp pass_through({_number, s}), do: s
end
