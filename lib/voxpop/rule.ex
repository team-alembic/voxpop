defmodule Voxpop.Rule do

  def parse(rule) when is_binary(rule) do
    case Regex.scan(~r/{\w+}/, rule, return: :index) do
      [] -> %Voxpop.Terminal{atom: rule}
      matches -> Voxpop.Concat.parse(rule, List.flatten(matches))
    end
  end

  def parse(rule) when is_atom(rule) do
    %Voxpop.NonTerminal{rule: rule}
  end

  def parse(rules) when is_list(rules) do
    %Voxpop.Choice{choices: Enum.map(rules, &parse/1)}
  end
end
