defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l, sum \\ 0)
  def count([], sum), do: sum
  def count([_head | tail], sum) do
    count(tail, sum + 1)
  end

  @spec reverse(list) :: list
  def reverse(l, reversed \\ [])
  def reverse([], reversed), do: reversed
  def reverse([head | tail], reversed) do
    reverse(tail, [head | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([head | tail], f) do
    [apply(f, [head]) | map(tail, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([head | tail], f) do
    if (apply(f, [head])) do
      [head | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f) do
    reduce(tail, apply(f, [head, acc]), f)
  end

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], [head | tail]) do
    [head | append([], tail)]
  end
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll, new \\ [])
  def concat([], new), do: new
  def concat([head | tail], new) do
    concat(tail, append(new, head))
  end
end
