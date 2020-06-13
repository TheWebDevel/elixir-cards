defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling of decks
  """

  @doc """
    Returns a list of strings representing a list of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hears", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a handsize and the reminder of the deck
    The `hand_size` argument indicates how many cards should be in the
    hand.
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # Whenever calling erlang code, use :erlang
    # Encode the deck to binary
    binary = :erlang.term_to_binary(deck)

    # Save the binary to the file
    File.write!(filename, binary)
  end

  # Load a deck from a file
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "File does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
