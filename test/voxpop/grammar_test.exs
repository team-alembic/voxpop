defmodule Voxpop.GrammarTest do
  use ExUnit.Case, async: true

  defmodule MyGrammar do
    use Voxpop.Grammar

    start "{greeting} {group}!"
    rule :greeting, "Hello"
    rule :group, "World"
  end

  test "basic DSL support" do

    assert MyGrammar.generate == "Hello World!"
  end

  test "generating from runtime string" do 
    assert MyGrammar.generate("{group}, {greeting}!") == "World, Hello!"
  end

  test "generating with runtime contest" do
    assert "Hello Friends!" == MyGrammar.generate(group: "Friends")
  end
end
