defmodule Allergies do
  @allergies [:eggs, :peanuts, :shellfish, :strawberries, :tomatoes, :chocolate, :pollen, :cats]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse
    |> construct_list
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    flags
    |> list
    |> Enum.member?(item)
  end

  defp construct_list(bits) do
    [@allergies, bits]
    |> Enum.zip
    |> Enum.reject(fn({_k, v}) -> v == 0 end)
    |> Enum.map(fn({k, _v}) -> Atom.to_string(k) end)
  end
end
