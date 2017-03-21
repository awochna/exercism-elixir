defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(white, black) when white == black, do: raise ArgumentError
  def new(white, black) do
    %Queens{black: black, white: white}
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board = Enum.map(1..8, fn(y) ->
      Enum.map(1..8, fn(x) -> "_" end)
    end)
    board = List.update_at(board, elem(queens.white, 0), fn(y) ->
      List.update_at(y, elem(queens.white, 1), fn(_) -> "W" end)
    end)
    board = List.update_at(board, elem(queens.black, 0), fn(y) ->
      List.update_at(y, elem(queens.black, 1), fn(_) -> "B" end)
    end)
    board = Enum.map(board, fn(y) -> Enum.join(y, " ") end)
    Enum.join(board, "\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    cond do
      elem(queens.black, 0) == elem(queens.white, 0) ->
        true
      elem(queens.black, 1) == elem(queens.white, 1) ->
        true
      on_diagonal?(queens.black, queens.white) ->
        true
      true ->
        false
    end
  end

  defp on_diagonal?({bx, by}, {wx, wy}) do
    wx - bx == wy - by || wx + bx == wy + by
  end
end
