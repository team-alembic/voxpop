defmodule Voxpop.Registry do
  alias Voxpop.Rule
  defstruct rules: %{}

  def evaluate(registry) do
    registry.rules[:start] |> Voxpop.Production.evaluate(registry)
  end

  def parse(definition) do
    add_rules(definition.rules)
    |> add_rule(:start, definition.start)
  end

  def add_rules(rules) do
    add_rules(%Voxpop.Registry{}, rules)
  end

  def add_rules(registry, %{}=rules) do
    add_rules(registry, Map.to_list(rules))
  end

  def add_rules(registry, []) do
    registry
  end

  def add_rules(registry, [{key, rule} | []]) do
    add_rule(registry, key, rule)
  end

  def add_rules(registry, [{key, rule} | rules]) do
    add_rule(registry, key, rule) |> add_rules(rules)
  end

  def add_rule(registry, key, rule) do
    registry |> Map.merge(%{rules: Map.put(registry.rules, key, Rule.parse(rule))})
  end
end
