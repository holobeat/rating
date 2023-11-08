defmodule RatingWeb.RatingListLive do
  use RatingWeb, :live_view

  import RatingWeb.AppComponents

  def mount(_params, _session, socket) do
    socket =
      assign(socket, items: 1..5 |> Enum.map(fn x -> %{name: "Item #{x}", rating: x * 1.0} end))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div :for={{item, i} <- Enum.with_index(@items, 1)} class="flex flex-col">
      <div class="flex p-3 border rounded-md mb-2 bg-white shadow-md">
        <div class="grow"><%= item.name %></div>
        
        <div class="flex">
          <div class="text-sm pr-2"><%= item.rating %></div>
           <.rating id={"rating-#{i}"} max={5} value={item.rating} />
        </div>
      </div>
    </div>
    """
  end
end
