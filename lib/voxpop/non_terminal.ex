defmodule Voxpop.NonTerminal do
  defstruct rule: nil

end

defimpl Voxpop.Production, for: Voxpop.NonTerminal do
  def evaluate(non_terminal, registry) do
    registry.rules |> Map.get(non_terminal.rule) |> Voxpop.Production.evaluate(registry)
  end
end
