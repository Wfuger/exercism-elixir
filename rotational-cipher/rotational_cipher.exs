defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @lowCase ?a..?z
  @upCase ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    {_, cList} = text <> <<0>> 
    |> :binary.bin_to_list 
    |> List.pop_at(-1) 

    cList
    |> Enum.map(&_to_str(&1, shift))
    |> Enum.join("")
  end
  
  defp _to_str(b, shift) do
    upOrLow = %{
      :up => Enum.member?(@upCase, b),
      :low => Enum.member?(@lowCase, b)
    }
    case upOrLow do
      %{ :up => true } -> to_string [_rotate(@upCase, b + shift)]
      %{ :low => true } -> to_string [_rotate(@lowCase, b + shift)]
      _ -> to_string [b]
    end
  end

  defp _rotate(_..last, byte) do
    if byte > last do
      times = div(byte - last, 26) + 1
      byte - times * 26
    else
      byte
    end
  end
end

