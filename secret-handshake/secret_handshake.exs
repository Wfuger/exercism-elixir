defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    hs = Integer.digits(code, 2)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce([], fn (x, accu) -> 
      case x do
        {1,0} -> accu ++ ["wink"]
        {1,1} -> accu ++ ["double blink"]
        {1,2} -> accu ++ ["close your eyes"]
        {1,3} -> accu ++ ["jump"]
        {_,_} -> accu
      end
    end)

    if Enum.count(Integer.digits(code, 2)) >= 5 do
      Enum.reverse(hs)
    else 
      hs
    end
  end
end

