defmodule Garden do
  @students [alice: {}, bob: {}, charlie: {}, david: {}, eve: {}, fred: {},
    ginny: {}, harriet: {}, ileana: {}, joseph: {}, kincaid: {}, larry: {}]
  @students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet,
    :ileana, :joseph, :kincaid, :larry]
  @plants %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    info_string
    |> String.split
    |> Enum.map(&String.graphemes/1)
    |> chunk_plants
    |> assign_plant_sets(Enum.sort(student_names))
    |> Enum.into(%{})
  end

  defp chunk_plants([row1, row2]) do
    Enum.zip(Enum.chunk(row1, 2), Enum.chunk(row2, 2))
    |> Enum.map(fn({[p1, p2], [p3, p4]}) ->
      {p1, p2, p3, p4}
    end)
  end

  defp assign_plant_sets(plants, students, assigned \\ [])
  defp assign_plant_sets([], [], assigned), do: assigned
  defp assign_plant_sets([], [student | rest], assigned) do
    assign_plant_sets([], rest, assigned ++ [{student, {}}])
  end
  defp assign_plant_sets([plant_set | rest], [student | tail], assigned) do
    student = {student, translate_plants(plant_set)}
    assign_plant_sets(rest, tail, [student | assigned])
  end

  defp translate_plants({p1, p2, p3, p4}) do
    {@plants[p1], @plants[p2], @plants[p3], @plants[p4]}
  end
end
