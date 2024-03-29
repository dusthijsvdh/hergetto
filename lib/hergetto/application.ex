defmodule Hergetto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Hergetto.Repo,
      # Start the Telemetry supervisor
      HergettoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Hergetto.PubSub},
      # Start the Endpoint (http/https)
      HergettoWeb.Endpoint,
      # Start a worker by calling: Hergetto.Worker.start_link(arg)
      # {Hergetto.Worker, arg}
      HergettoWeb.Presence,
      {DynamicSupervisor, strategy: :one_for_one, name: Hergetto.Rooms.RoomSupervisor},
      {DynamicSupervisor, strategy: :one_for_one, name: Hergetto.Videos.VideoSupervisor},
      {DynamicSupervisor, strategy: :one_for_one, name: Hergetto.Chats.ChatSupervisor},
      Hergetto.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hergetto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HergettoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
