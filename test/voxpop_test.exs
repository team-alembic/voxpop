defmodule VoxpopTest do
  use ExUnit.Case
  doctest Voxpop

  test "start is evaluated" do
    grammar = %Voxpop.Grammar.Definition{start: "You have to start somewhere"}
    assert Voxpop.generate(grammar) == "You have to start somewhere"
  end

  test "start supports nested rules" do
    grammar = %Voxpop.Grammar.Definition{start: :a_rule, rules: %{a_rule: "Not Ja-rule"}}
    assert Voxpop.generate(grammar) == "Not Ja-rule"
  end

  test "start can be a list" do
    list_grammar = %Voxpop.Grammar.Definition{start: ["Hello", "Yo"]}
    assert ["Hello", "Yo"] |> Enum.member?(Voxpop.generate(list_grammar))
  end

  test "concatenates string rules" do
    concat_grammar = %Voxpop.Grammar.Definition{start: "{greeting} world", rules: %{greeting: "Hello"}}
    assert Voxpop.generate(concat_grammar) == "Hello world"
  end

  test "gracefully handles missing rules" do
    concat_grammar = %Voxpop.Grammar.Definition{start: "{greeting} world", rules: %{greeting: "Hello {invalid}"}}
    assert Voxpop.generate(concat_grammar) == "Hello "
  end
end
