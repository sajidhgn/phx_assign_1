defmodule PasgenProWeb.PassGenLive do
  use PasgenProWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, brightness: 10)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h3>
    <%= @brightness %>
    </h3>
    <button phx-click="add">Add</button>
    <button  phx-click="minus">Minus</button>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("add", _, socket) do
    # brightness =  socket.assigns.brightness + 1
    brightness =  update(socket, :brightness, &(&1 + 1))
    {:noreply, brightness}
  end

  def handle_event("minus", _, socket) do
    brightness =  socket.assigns.brightness - 1
    {:noreply, assign(socket, brightness: brightness)}
  end

end
