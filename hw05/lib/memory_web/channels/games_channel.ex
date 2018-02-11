defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Memory.GameBackup.load(name) || Game.memoryGame()

      socket =
        socket
        |> assign(:game, game)
        |> assign(:name, name)

      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("startGame", %{"card" => stateValue}, socket) do
    game = Game.startGame(socket.assigns[:game], stateValue)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)

    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("faceMatched", %{"faceMatched" => stateValue}, socket) do
    game = Game.isFaceMatch(socket.assigns[:game])
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)

    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("reset", %{"reset" => stateValue}, socket) do
    game = Game.memoryGame()
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)

    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
