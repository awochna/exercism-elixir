defmodule ProteinTranslation do
  @codons %{"UGU" => "Cysteine", "UGC" => "Cysteine", "UUA" => "Leucine",
    "UUG" => "Leucine", "AUG" => "Methionine", "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine", "UCU" => "Serine", "UCC" => "Serine",
    "UCA" => "Serine", "UCG" => "Serine", "UGG" => "Tryptophan",
    "UAU" => "Tyrosine", "UAC" => "Tyrosine", "UAA" => "STOP", "UAG" => "STOP",
    "UGA" => "STOP"}

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    case translate(rna) do
      {:ok, proteins} ->
        {:ok, proteins}
      :error ->
        {:error, "invalid RNA"}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case Map.fetch(@codons, codon) do
      {:ok, protein} ->
        {:ok, protein}
      :error ->
        {:error, "invalid codon"}
    end
  end

  defp translate(strand) do
    with {:ok, codons} <- split_into_codons(strand),
         proteins_list <- Enum.map(codons, fn(codon) ->
           {:ok, protein} = of_codon(codon)
           protein
         end),
         proteins <- trim_stop(proteins_list),
         do: {:ok, proteins}
  end

  defp split_into_codons(rna, codons \\ [])
  defp split_into_codons("", codons) do
    {:ok, codons}
  end
  defp split_into_codons(rna, codons) do
    {codon, remaining} = String.split_at(rna, 3)
    if (Map.has_key?(@codons, codon)) do
      split_into_codons(remaining, List.flatten([codons | [codon]]))
    else
      :error
    end
  end

  defp trim_stop(proteins) do
    stop_point = Enum.find_index(proteins, &(&1 == "STOP"))
    if (stop_point) do
      {proteins, _useless_tail} = Enum.split(proteins, stop_point)
      proteins
    else
      proteins
    end
  end
end

