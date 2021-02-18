defmodule HergettoWeb.RoomHelper do
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Hergetto.PubSub, @topic)
  end

  def subscribe(id) do
    Phoenix.PubSub.subscribe(Hergetto.PubSub, "#{@topic}:#{id}")
  end

  def broadcast(message) do
    Phoenix.PubSub.broadcast(Hergetto.PubSub, @topic, message)
  end

  def broadcast(id, message) do
    Phoenix.PubSub.broadcast(Hergetto.PubSub, "#{@topic}:#{id}", message)
  end

  def broadcast(id, broadcast_id, event_type) do
    Phoenix.PubSub.broadcast(Hergetto.PubSub, "#{@topic}:#{id}", %{event_type: event_type, broadcast_id: broadcast_id})
  end
end
