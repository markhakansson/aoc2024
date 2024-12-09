defmodule MullItOver do
  @moduledoc """
  Usage `cat <input> | elixir day3.exs`.
  """

  def run do
    input =
      read_stdin()
      |> regex_match_mul

    input
    |> solve1
    |> IO.inspect()
  end

  def read_stdin() do
    IO.read(:stdio, :eof)
  end

  def regex_match_mul(input) do
    Regex.scan(~r/mul\([0-9]+\,[0-9]+\)/, input)
    |> List.flatten()
  end

  def solve1(input) do
    input
    |> Enum.map(&MullItOver.parse_factors/1)
    |> sum_products
  end

  def parse_factors(mul) do
    Regex.scan(~r/([0-9]+)\,([0-9]+)/, mul)
    |> List.flatten()
    # we only care about the values in the capture groups
    |> Enum.take(-2)
    |> Enum.map(&String.to_integer/1)
  end

  def sum_products(expressions) do
    expressions
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end
end

MullItOver.run()
