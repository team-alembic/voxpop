defmodule Voxpop.Grammar.Generator do
  alias Voxpop.Registry

  def generate(definition, _context \\ %{}) do
    case definition.registry do
      nil -> Registry.add_rules(definition.rules) |> Registry.add_rule(:start, definition.start)
    end |> Registry.evaluate

  end
end

defmodule Voxpop.Grammar do
  import Voxpop.Grammar.Generator

  defmacro __using__(_opts) do
    quote do
      import Voxpop.Grammar

      @rules %{}
      @start ""

      @before_compile unquote(__MODULE__)

    end
  end

  defmacro rule(key, rule) do
    quote do
      @rules Map.put(@rules, unquote(key), unquote(rule))
    end
  end

  defmacro start(rule) do
    quote do
      @start unquote(rule)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def generate do
        Voxpop.Grammar.Generator.generate %Voxpop.Grammar.Definition{start: @start, rules: @rules}
      end
    end
  end

end

defmodule Voxpop.Grammar.Definition do
  defstruct rules: %{}, start: "", registry: nil
end

