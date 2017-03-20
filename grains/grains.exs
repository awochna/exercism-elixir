defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number > 64 or number < 1 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end
  def square(number) do
    {:ok, pow(2, number - 1)}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, add(64)}
  end

  defp pow(_, 0), do: 1
  defp pow(base, exp) when exp > 0 do
    base * pow(base, exp - 1)
  end

  defp add(num) when num == 0, do: 0
  defp add(num) do
    pow(2, num - 1) + add(num - 1)
  end
end
