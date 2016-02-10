defmodule Voxpop.Concat do
  defstruct parts: []


  def parse(rule, matches) do
    %Voxpop.Concat{parts: do_parse(rule, List.flatten(matches), 0)}
  end

  defp do_parse(rule, [], offset) do
    [wrap_text(binary_part(rule, offset, byte_size(rule) - offset))]
  end

  defp do_parse(rule, [{pos, length} | matches], offset) do
    keep = pos - offset
    new_offset = pos + length

    << _ :: binary-size(offset), part::binary-size(keep), token::binary-size(length), _::binary>> = rule
    [wrap_text(part) | [extract_key(token) | do_parse(rule, matches, new_offset)]]
  end

  defp extract_key(token) do
    key = token |> String.slice(1..-2) |> String.to_atom
    %Voxpop.NonTerminal{rule: key}
  end

  defp wrap_text(part) do
    %Voxpop.Terminal{atom: part}
  end

end

defimpl Voxpop.Production, for: Voxpop.Concat do
  def evaluate(concat, registry) do
    concat.parts |> Enum.map(&Voxpop.Production.evaluate(&1, registry)) |> Enum.join
  end
end
