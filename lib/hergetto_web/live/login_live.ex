defmodule HergettoWeb.LoginLive do
  @moduledoc false
  use HergettoWeb, :live_view
  alias Surface.Components.Link
  alias Hergetto.Helpers.AuthHelper
  alias HergettoWeb.Components.LogoIcon

  @impl true
  def mount(_params, session, socket) do
    {:ok, fetch(socket, session) |> assign(page_title: "Login")}
  end

  def fetch(socket, session) do
    socket
    |> AuthHelper.assign_user(session)
  end
end
