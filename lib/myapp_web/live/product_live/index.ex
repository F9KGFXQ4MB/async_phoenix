defmodule MyappWeb.ProductLive.Index do
  use MyappWeb, :live_view

  alias Myapp.Products
  alias Myapp.Products.Product
  alias MyappWeb.ProductLive.FormComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :products, fetch_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Products.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Products.get_product!(id)
    {:ok, _} = Products.delete_product(product)

    {:noreply, assign(socket, :products, fetch_products())}
  end

  def handle_info({_, {:result, component_id, _http_result}}, socket) do
    require Logger
    Logger.error("Received")

    send_update(FormComponent, id: component_id, refreshing: false)

    {:noreply, socket}
  end

  def handle_info({:DOWN, _, :process, _, :normal}, socket) do
    {:noreply, socket}
  end

  defp fetch_products do
    Products.list_products()
  end
end
