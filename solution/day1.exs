defmodule HistorianHysteria do
  @moduledoc """
  Usage `cat <input> | elixir day1.exs`.
  """

	def run do
    {first,  second} = read_stdin()
  	  |> split
  	
  	solve_1(first, second)
  	  |> IO.puts

  	solve_2(first, second)
  	  |> IO.puts
  end

  def read_stdin do 
  	IO.read(:stdio, :eof)
  end

  @doc """
  Split a list of strings into two lists of integers.
  """
  def split(input) do
    input
    	|> String.split([" ", "\n"], trim: true)
      |> Enum.map(&String.to_integer/1)
  	  |> Enum.reduce({[], []}, fn x, {curr, next} -> { next, [x | curr]} end)
  end

  @doc """
  Solution for the first puzzle.
  """
  def solve_1(l1, l2) do
    [Enum.sort(l1), Enum.sort(l2)]
      |> Enum.zip()
      |> Enum.map(fn {a, b} -> Kernel.abs(a - b) end)
      |> Enum.sum
  end

  @doc """
  Solution for the second puzzle.
  """
  def solve_2(l1, l2) do 
    frequencies = Enum.frequencies(l2)
    l1
      |> Enum.map(fn x -> 
           frequency = Map.get(frequencies, x)
           case frequency do
             nil -> 0
             _ -> x * frequency
           end
         end)
      |> Enum.sum
  end
end

HistorianHysteria.run()
