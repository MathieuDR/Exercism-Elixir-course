defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna), do: encode(dna, <<>>)

  defp encode([], encoded), do: encoded
  defp encode([h|t], encoded), do: encode(t, <<encoded::bits, encode_nucleotide(h)::4>>)

  def decode(dna), do: decode(dna, [])
  defp decode(<<>>, decoded), do: Enum.reverse(decoded)
  defp decode(<<h::4, t::bits>>, decoded), do: decode(t, [ decode_nucleotide(h) | decoded])

end
