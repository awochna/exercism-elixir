defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(&rotate_char(&1, shift))
    |> List.to_string
  end

  defp rotate_char(char, shift) when char in 65..90 do
    char = char + shift
    if (char > 90) do
      char - 26
    else
      char
    end
  end
  defp rotate_char(char, shift) when char in 97..122 do
    char = char + shift
    if (char > 122) do
      char - 26
    else
      char
    end
  end
  defp rotate_char(char, _shift) do
    char
  end
end

