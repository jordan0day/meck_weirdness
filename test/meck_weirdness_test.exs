defmodule MeckWeirdnessTest do
  use ExUnit.Case

  setup do
    on_exit fn -> :meck.unload end
  end

  test "With no mocked functions" do
    :meck.new MeckWeirdness, [:passthrough]
    assert MeckWeirdness.do_it == :not_mocked
  end

  test "With a mocked function" do
    :meck.new MeckWeirdness, [:passthrough]
    :meck.expect MeckWeirdness, :some_function, 2, :mocked

    assert MeckWeirdness.do_it == :mocked
  end

  test "With a mocked function, no passthrough" do
    :meck.new MeckWeirdness

    :meck.expect MeckWeirdness, :do_it, fn() ->
      IO.puts "Calling MeckWeirdness.do_it via :meck.passthrough([])"
      :meck.passthrough([])
    end
    :meck.expect MeckWeirdness, :some_function, 2, :mocked

    assert MeckWeirdness.do_it == :mocked
  end

  test "With both functions mocked, no passthrough" do
    :meck.new MeckWeirdness

    :meck.expect MeckWeirdness, :do_it, fn() ->
      IO.puts "In the mocked MeckWeirdness.do_it"
      MeckWeirdness.some_function("a", "b")
    end
    :meck.expect MeckWeirdness, :some_function, 2, :mocked

    assert MeckWeirdness.do_it == :mocked
  end
end
