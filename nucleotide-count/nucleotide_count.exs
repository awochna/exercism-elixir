defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide, total \\ 0)
  def count([head | strand], nucleotide, total) do
    if (head == nucleotide) do
      count(strand, nucleotide, total + 1)
    else
      count(strand, nucleotide, total)
    end
  end
  def count([], _nucleotide, total) do
    total
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.new(@nucleotides, fn(nucleotide) ->
      {nucleotide, count(strand, nucleotide)}
    end)
  end
end
