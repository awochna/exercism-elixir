defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.to_charlist
    |> Enum.filter(&(Enum.member?(97..122, &1) || Enum.member?(48..57, &1)))
    |> Enum.map(&exchange/1)
    |> Enum.chunk(5, 5, [])
    |> Enum.intersperse(' ')
    |> List.flatten
    |> List.to_string
  end

  defp exchange(letter) do
    cond do
      letter <= 57 && letter >= 48 ->
        letter
      letter > 109 ->
        diff = letter - 109
        letter - 2 * diff + 1
      letter < 110 ->
        diff = 109 - letter
        letter + 2 * diff + 1
    end
  end
end
