defmodule Voxpop.NonTerminal do
  defstruct rule: nil

end

defimpl Voxpop.Production, for: Voxpop.NonTerminal do
  def evaluate(non_terminal, registry) do
    value = Map.get(registry.rules, non_terminal.rule)

    if value do
      Voxpop.Production.evaluate(value, registry)
    else
      raise "Invalid rule: `#{non_terminal.rule}`"
    end
  end
end
