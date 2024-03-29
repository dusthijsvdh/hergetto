defmodule HergettoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :hergetto

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_hergetto_key",
    signing_salt: "CmlX+Kmh"
  ]

  socket "/socket", HergettoWeb.UserSocket,
    websocket: true,
    longpoll: false

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  plug Plug.Static,
    at: "/",
    from: :hergetto,
    gzip: false,
    only: ~w(assets uploads fonts favicon.ico robots.txt manifest.json sitemap.xml)

  if Application.get_env(:hergetto, :environment) == :prod do
    plug Plug.Static,
      at: "/",
      from: :hergetto,
      gzip: true,
      only: ~w(assets uploads fonts favicon.ico robots.txt manifest.json sitemap.xml),
      headers: %{"cache-control" => "max-age=86400, private, must-revalidate"}
  end

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :hergetto
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug HergettoWeb.Router
end
