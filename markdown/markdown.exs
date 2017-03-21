defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(fn(text) -> process(text) end)
    |> Enum.join
    |> patch
  end

  defp process(text) do
    cond do
      String.starts_with?(text, "#") ->
        text
        |> parse_header_md_level
        |> enclose_with_header_tag
      String.starts_with?(text, "*") ->
        parse_list_md_level(text)
      true ->
        enclose_with_paragraph_tag(String.split(text))
    end
  end

  defp parse_header_md_level(header_with_text) do
    [header | text] = String.split(header_with_text)
    {String.length(header), Enum.join(text, " ")}
  end

  defp parse_list_md_level(l) do
    text = l
    |> String.trim_leading("* ")
    |> String.split
    "<li>" <> join_words_with_tags(text) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(text) do
    text
    |> Enum.map((fn(word) -> replace_md_with_tag(word) end))
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^__{1}/ ->
        String.replace(word, ~r/^__{1}/, "<strong>", global: false)
      word =~ ~r/^_{1}/ ->
        String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/__{1}$/ ->
        String.replace(word, ~r/__{1}$/, "</strong>")
      word =~ ~r/[^_{1}]/ ->
        String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp patch(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
