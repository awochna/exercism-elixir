defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist(a, b) -> :sublist
      sublist(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist(a, b) do
    index = Enum.find_index(b, &(&1 == List.first(a)))
    if (index == nil) do
      false
    else
      potential = Enum.slice(b, index, length(a))
      potential === a || sublist(a, tl(b))
    end
  end
end
