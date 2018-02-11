defmodule Memory.Game do

  def memoryGame do
    %{
      cards: newGame(),
      firstCard: 0,
      secondCard: 0,
      paired: false,
      clicks: 0
    }
  end

  def newGame() do
    ["A", "B", "C", "D", "E", "F", "G", "H", "A", "B", "C", "D", "E", "F", "G", "H"]
    |> Enum.shuffle()
    |> Enum.map(fn x -> %{value: x, flipped: false, row: 0, col: 0, done: false} end)
    |> Enum.chunk_every(4)
    |> updateCards()
  end

  def updateCards(new_list) do
    for i <- 0..3 do
      for j <- 0..3 do
        Map.replace!(Enum.at(Enum.at(new_list, i), j), :row, i)
        |> Map.replace!(:col, j)
      end
    end
  end

  def client_view(game) do
    %{
      initialGameState: game[:cards],
      count: game.clicks
    }
  end

  def startGame(game, card) do
    row = card["row"]
    col = card["col"]

    if Enum.at(Enum.at(game[:cards], row), col)[:flipped] == false do
      cond do
        game[:firstCard] == 0 ->
          newclicks = game[:clicks] + 1
          new_card = Map.replace!(Enum.at(Enum.at(game[:cards], row), col), :flipped, true)

          card2 =
            Enum.at(game[:cards], row)
            |> List.replace_at(col, new_card)

          game =
            Map.replace!(game, :cards, List.replace_at(game[:cards], row, card2))
            |> Map.replace!(:clicks, newclicks)
            |> Map.replace!(:firstCard, card)

        game[:secondCard] == 0 ->
          newclicks = game[:clicks] + 1
          new_card = Map.replace!(Enum.at(Enum.at(game[:cards], row), col), :flipped, true)

          card2 =
            Enum.at(game[:cards], row)
            |> List.replace_at(col, new_card)

          # cards = List.replace_at(game[:cards],row,card2)
          Map.replace!(game, :cards, List.replace_at(game[:cards], row, card2))
          |> Map.replace!(:clicks, newclicks)
          |> Map.replace!(:secondCard, card)

        # isFaceMatch(game)
        true -> game
      end
    end
  end

    def isFaceMatch(game) do
    first = game[:firstCard]
    second = game[:secondCard]

    game =
      if String.equivalent?(first["value"], second["value"]) do
        Map.replace!(game, :paired, true)
        :timer.sleep(500)
        completed?(game)
      else
        :timer.sleep(1000)
        cardFaceFlip(game)
      end

    cardsReset(game)
  end

  def completed?(game) do
    firstRow  = game[:firstCard]["row"]
    firstCol  = game[:firstCard]["col"]
    secondRow = game[:secondCard]["row"]
    secondCol = game[:secondCard]["col"]
    newCard1  = Map.replace!(Enum.at(Enum.at(game[:cards], firstRow), firstCol), :done, true)

    card1 =
      Enum.at(game[:cards], firstRow)
      |> List.replace_at(firstCol, newCard1)

    card1_list = List.replace_at(game[:cards], firstRow, card1)
    game = Map.replace!(game, :cards, card1_list)
    newCard2 = Map.replace!(Enum.at(Enum.at(game[:cards], secondRow), secondCol), :done, true)

    card2 =
      Enum.at(game[:cards], secondRow)
      |> List.replace_at(secondCol, newCard2)

    card2_list = List.replace_at(game[:cards], secondRow, card2)
    game = Map.replace!(game, :cards, card2_list)
    game
  end

  def cardFaceFlip(game) do
    firstRow  = game[:firstCard]["row"]
    firstCol  = game[:firstCard]["col"]
    secondRow = game[:secondCard]["row"]
    secondCol = game[:secondCard]["col"]
    newCard1  = Map.replace!(Enum.at(Enum.at(game[:cards], firstRow), firstCol), :flipped, false)

    card1 =
      Enum.at(game[:cards], firstRow)
      |> List.replace_at(firstCol, newCard1)

    card1_list = List.replace_at(game[:cards], firstRow, card1)
    game = Map.replace!(game, :cards, card1_list)
    newCard2 = Map.replace!(Enum.at(Enum.at(game[:cards], secondRow), secondCol), :flipped, false)

    card2 =
      Enum.at(game[:cards], secondRow)
      |> List.replace_at(secondCol, newCard2)

    card2_list = List.replace_at(game[:cards], secondRow, card2)
    game = Map.replace!(game, :cards, card2_list)
    game
  end

  def cardsReset(game) do
    Map.replace!(game, :firstCard, 0)
    |> Map.replace!(:secondCard, 0)
    |> Map.replace!(:paired, false)
  end

  def gameReset(game) do
    game.memoryGame()
  end
end
