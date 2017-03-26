defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    regex = ~r/(-?\d+)\s(plus|minus|multiplied by|divided by)\s(-?\d+)\s?(plus|minus|multiplied by|divided by)?\s?(-?\d+)?/
    match = Regex.run(regex, question)
    if (match == nil) do
      raise ArgumentError
    else
      [_whole | parts] = Regex.run(regex, question)
      if (length(parts) == 3) do
        calculate(parts)
      else
        first = calculate(Enum.slice(parts, 0, 3))
        calculate([first | Enum.slice(parts, 3, 2)])
      end
    end
  end

  defp calculate([num1, "plus", num2]), do: int(num1) + int(num2)
  defp calculate([num1, "minus", num2]), do: int(num1) - int(num2)
  defp calculate([num1, "multiplied by", num2]), do: int(num1) * int(num2)
  defp calculate([num1, "divided by", num2]), do: div(int(num1), int(num2))

  defp int(num) when is_binary(num), do: String.to_integer(num)
  defp int(num) when is_integer(num), do: num
end
