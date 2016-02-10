defmodule Voxpop.Choice do
  defstruct choices: []
end

defimpl Voxpop.Production, for: Voxpop.Choice do
  def evaluate(choice, registry) do
    choice.choices |> Enum.random |> Voxpop.Production.evaluate(registry)
  end
end
