defmodule Voxpop.Grammar do
  alias Voxpop.Registry
  defstruct rules: %{}, start: "", registry: nil

  def generate(grammar, _context) do
    case grammar.registry do
      nil -> Registry.add_rules(grammar.rules) |> Registry.add_rule(:start, grammar.start)
    end |> Registry.evaluate

  end
end
