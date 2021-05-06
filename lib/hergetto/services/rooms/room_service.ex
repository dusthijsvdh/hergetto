defmodule Hergetto.Rooms.RoomService do
  use GenServer
  require Logger

  alias Hergetto.Structs.SessionRoom

  # Client

  @doc false
  def start_link(room_id) do
    Logger.info("Roomservice with id: #{room_id} starting.")
    GenServer.start_link(__MODULE__, %{room_id: room_id, participants: []}, name: :"roomservice:#{room_id}")
  end

  # Server

  @doc false
  @impl true
  def init(state) do
    {:ok, state}
  end

  @doc false
  @impl true
  def handle_cast({:join, %SessionRoom{session: session}}, state) do
    Logger.info("Session #{session} joined room #{state.room_id}")
    {:noreply, %{state | participants: [session | state.participants]}}
  end

  @doc false
  @impl true
  def handle_cast({:leave, %SessionRoom{session: session}}, state) do
    Logger.info("Session #{session} left room #{state.room_id}")
    {:noreply, %{state | participants: Enum.filter(state.participants, fn p -> p != session end)}}
  end

  @doc false
  @impl true
  def handle_call(:get, _, state) do
    {:reply, state, state}
  end
end