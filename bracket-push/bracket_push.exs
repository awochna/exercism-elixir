defmodule BracketPush do
  @brackets ~w/{ [ ( ) ] }/
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes
    |> check
  end

  defp check([]), do: true
  defp check(list, opens \\ [])
  defp check([], []), do: true
  defp check([], _), do: false
  defp check([open | tail], []) when open in @brackets do
    check(tail, [open])
  end
  defp check([next | tail], opens) when next in @brackets do
    if (matches?(hd(opens), next)) do
      check(tail, tl(opens))
    else
      check(tail, [next | opens])
    end
  end
  defp check([_next | tail], opens), do: check(tail, opens)

  defp matches?("{", "}"), do: true
  defp matches?("[", "]"), do: true
  defp matches?("(", ")"), do: true
  defp matches?(_, _), do: false
end
