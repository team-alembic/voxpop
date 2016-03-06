defmodule Voxpop.GrammarTest do
  use ExUnit.Case, async: true

  test "basic DSL support" do
    defmodule MyGrammar do
      use Voxpop.Grammar

      start "{greeting} {group}!"
      rule :greeting, "Hello"
      rule :group, "World"
    end

    assert MyGrammar.generate == "Hello World!"
  end
end
