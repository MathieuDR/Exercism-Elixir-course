defmodule PaintByNumber do
  def palette_bit_size(colour_count) do
    :math.log2(colour_count)
    |> ceil()
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, colour_count, pixel_colour_index),
    do: <<pixel_colour_index::size(palette_bit_size(colour_count)), picture::bitstring>>

  def get_first_pixel(picture, colour_count) do
    bits = palette_bit_size(colour_count)

    case picture do
      <<first::size(bits), _rest::bitstring>> -> first
      _ -> nil
    end
  end

  def drop_first_pixel(picture, colour_count) do
    bits = palette_bit_size(colour_count)

    case picture do
      <<_first::size(bits), rest::bitstring>> -> rest
      _ -> empty_picture()
    end
  end

  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>
end
