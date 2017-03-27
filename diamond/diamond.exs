defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    chars = Enum.into(65..letter, [])
    build_rows(chars, length(chars) * 2 - 1)
  end

  defp build_rows([char | []], max) do
    build_row(char, 0, max)
  end
  defp build_rows([char | rest], max) do
    pad = length(rest)
    build_row(char, pad, max) <> build_rows(rest, max) <> build_row(char, pad, max)
  end

  defp build_row(char, pad, max) do
    outer = String.duplicate(" ", pad)
    letter = List.to_string([char])
    if (letter == "A") do
      outer <> letter <> outer <> "\n"
    else
      inner = String.duplicate(" ", max - (pad + 1) * 2)
      outer <> letter <> inner <> letter <> outer <> "\n"
    end
  end
end
