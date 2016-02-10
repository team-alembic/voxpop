defmodule Voxpop.Grammar.Generator do
  alias Voxpop.Registry

  def generate(definition, _context \\ %{}) do
    case definition.registry do
      nil -> Registry.parse(definition) |> Registry.evaluate
      %Registry{} -> Registry.evaluate(definition.registry)
    end
  end

end

defmodule Voxpop.Grammar do
  alias Voxpop.Grammar.Generator

  defmacro __using__(_opts) do
    quote do
      import Voxpop.Grammar

      @registry %Voxpop.Registry{}
 
      @before_compile unquote(__MODULE__)

    end
  end

  defmacro rule(key, rule) do
    quote do
      @registry Voxpop.Registry.add_rule(@registry, unquote(key), unquote(rule))
    end
  end

  defmacro start(rule) do
    quote do
      @registry Voxpop.Registry.add_rule(@registry, :start, unquote(rule))
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def generate do
        Generator.generate %Voxpop.Grammar.Definition{registry: @registry}
      end
    end
  end

end

defmodule Voxpop.Grammar.Definition do
  defstruct rules: %{}, start: "", registry: nil
end

