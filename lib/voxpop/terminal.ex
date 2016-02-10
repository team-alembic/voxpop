defmodule Voxpop.Terminal do
  defstruct atom: ""

  defimpl Voxpop.Production do
    def evaluate(terminal, _registry) do
      terminal.atom
    end
  end
end
