# Voxpop

Voxpop generates text from declarative grammars.

It is roughly a version of [Calyx](https://github.com/maetl/calyx) ported to Elixir.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add voxpop to your list of dependencies in `mix.exs`:

        def deps do
          [{:voxpop, "~> 0.0.1"}]
        end

## Usage

The API is still currently in flux while I work some things out, but in the general
case, you do things like this:

```elixir
iex> Voxpop.generate %Voxpop.Grammar{start: "Hello {greeting}!", rules: %{greeting: "world"}}
"Hello World"
```

Your rules can have multiple options which will be randomly chosen:

```elixir
%Voxpop.Grammar{start: "Hello {group}!", rules: %{group: ["comrades", "folks", "friends"]}}
```
