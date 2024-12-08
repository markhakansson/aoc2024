defmodule RedNosedReports do
  @moduledoc """
  Usage `cat <input> | elixir day2.exs`.
  """

  def run do
    input =
      read_stdin()
      |> split

    input
    |> solve1
    |> IO.puts()
  end

  def read_stdin do
    IO.read(:stdio, :eof)
  end

  def split(input) do
    input
    |> String.split(["\n"], trim: true)
    |> Enum.map(&RedNosedReports.split_line/1)
  end

  def split_line(input) do
    input
    |> String.split([" "], trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def solve1(input) do
    input
    |> Enum.map(&RedNosedReports.solve_report/1)
    |> Enum.count(fn x -> x == true end)
  end

  def solve_report(report) do
    d = diff(report)

    # check level change is ok
    level_change_ok = is_level_change_ok(d)

    # check direction does not change
    direction_ok = is_direction_ok(d)

    level_change_ok && direction_ok
  end

  def diff(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> y - x end)
  end

  # Check if direction never changes
  def is_direction_ok(diff) do
    sum =
      diff
      |> Enum.map(fn x ->
        case x do
          z when z < 0 -> -1
          z when z > 0 -> 1
          _ -> 0
        end
      end)
      |> Enum.sum()

    Kernel.abs(sum) == length(diff)
  end

  def is_level_change_ok(diff) do
    diff
    |> Enum.map(&Kernel.abs/1)
    |> Enum.map(fn x ->
      case x do
        z when z in 1..3 -> true
        _ -> false
      end
    end)
    |> Enum.reduce(fn x, acc -> x && acc end)
  end
end

RedNosedReports.run()
