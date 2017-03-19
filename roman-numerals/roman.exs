defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    {number, []}
    |> get_m
    |> get_d
    |> get_c
    |> get_l
    |> get_x
    |> get_v
    |> get_i
    |> Enum.join
  end

  defp get_m({number, romans}) when number > 844 do
    get_m({number - 1000, romans ++ ["M"]})
  end
  defp get_m(tuple), do: tuple

  defp get_d({number, romans}) when number > 344 do
    get_d({number - 500, romans ++ ["D"]})
  end
  defp get_d({number, romans}) when number < -166 do
    get_d({number + 500, List.insert_at(romans, -2, "D")})
  end
  defp get_d(tuple), do: tuple

  defp get_c({number, romans}) when number > 84 do
    get_c({number - 100, romans ++ ["C"]})
  end
  defp get_c({number, romans}) when number < -16 do
    get_c({number + 100, List.insert_at(romans, -2, "C")})
  end
  defp get_c(tuple), do: tuple

  defp get_l({number, romans}) when number > 39 do
    get_l({number - 50, romans ++ ["L"]})
  end
  defp get_l({number, romans}) when number < -11 do
    get_l({number + 50, List.insert_at(romans, -2, "L")})
  end
  defp get_l(tuple), do: tuple

  defp get_x({number, romans}) when number > 8 do
    get_x({number - 10, romans ++ ["X"]})
  end
  defp get_x({number, romans}) when number < -1 do
    get_x({number + 10, List.insert_at(romans, -2, "X")})
  end
  defp get_x(tuple), do: tuple

  defp get_v({number, romans}) when number > 3 do
    get_v({number - 5, romans ++ ["V"]})
  end
  defp get_v({number, romans}) when number < -1 do
    get_v({number + 5, List.insert_at(romans, -2, "V")})
  end
  defp get_v(tuple), do: tuple

  defp get_i({number, romans}) when number > 0 do
    get_i({number - 1, romans ++ ["I"]})
  end
  defp get_i({number, romans}) when number == -1 do
    List.insert_at(romans, -2, "I")
  end
  defp get_i({_number, romans}), do: romans
end
