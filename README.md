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
iex> Voxpop.generate %Voxpop.Grammar.Definition{start: "Hello {greeting}!", rules: %{greeting: "world"}}
"Hello World"
```

Your rules can have multiple options which will be randomly chosen:

```elixir
%Voxpop.Grammar.Definition{start: "Hello {group}!", rules: %{group: ["comrades", "folks", "friends"]}}
```

There is also a DSL, if you'd prefer to define your grammar as part of a module:

```elixir
defmodule MyGrammar do
  use Voxpop.Grammar

  start "{greeting} {group}!"
  rule :greeting, "Hello"
  rule :group, "World"
end

MyGrammar.evaluate
```

## Plans
The plan is to make Voxpop powerful enough that it can generate text for
sophisticated applications like chat user interfaces. That is going to take a
few steps:

 - [ ] [Weighted Choices][weighted choices]
 - [ ] [Dynamic generation with generation-time context][dynamic generation]
 - [ ] [Per-generation repetition avoidance in choices][repetition avoidance]
 - [ ] [Loading grammars from JSON or other format][load grammars]
 - [ ] Visualising evaluated AST
 - [ ] OTP application to reduce the requirement to rebuild grammars loaded at runtime

 [dynamic generation]: https://github.com/zovafit/voxpop/issues/4
 [repetition avoidance]: https://github.com/zovafit/voxpop/issues/5
 [load grammars]: https://github.com/zovafit/voxpop/issues/6
