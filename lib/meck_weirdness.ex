defmodule MeckWeirdness do
  def do_it do
    IO.puts "In do_it"
    result = some_function("a", "b")
    IO.puts "result: #{inspect result}\n"

    result
  end

  def some_function(param1, param2) do
    IO.puts "In some_function's real implementation"
    IO.puts "param1: #{inspect param1}"
    IO.puts "param2: #{inspect param2}"
    :not_mocked
  end
end
