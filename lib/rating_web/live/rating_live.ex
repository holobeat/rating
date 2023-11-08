defmodule RatingWeb.RatingLive do
  use RatingWeb, :live_view

  import RatingWeb.AppComponents

  def render(assigns) do
    ~H"""
    <div class="p-6 bg-white rounded-md shadow-xl">
      <div class="mb-4">
        <div>Size 3:</div>
         <.rating value={3.5} max={5} class="w-3 h-3" />
      </div>
      
      <div class="my-4">
        <div>Size 4:</div>
         <.rating value={3.5} max={5} class="w-4 h-4" />
      </div>
      
      <div class="my-4">
        <div>Size 5:</div>
         <.rating value={3.5} max={5} class="w-5 h-5" />
      </div>
      
      <div class="my-4">
        <div>Size 6:</div>
         <.rating value={3.5} max={5} class="w-6 h-6" />
      </div>
      
      <div class="flex shrink my-6">
        <div class="p-4 border border-gray-300 rounded-md flex items-center">
          <div class="pr-3 text-xs font-bold">3.5</div>
           <.rating value={3.5} max={5} class="w-4 h-4" />
        </div>
      </div>
      
      <div class="flex shrink my-6">
        <div class="p-4 border border-gray-300 rounded-md flex items-center">
          <div class="pr-3 text-xs font-bold">3.5</div>
           <.rating value={3.5} max={5} class="w-5 h-5" />
        </div>
      </div>
      Interactive - click a star:
      <div class="flex shrink mb-6">
        <div class="p-4 border border-gray-300 rounded-md flex items-center">
          <div class="pr-3 text-xs font-bold w-6"><%= @rating %></div>
          
          <.rating
            id="rating"
            value={@rating}
            max={5}
            class="cursor-pointer w-5 h-5"
            phx-click="rating-click"
          />
          <div class="pl-3 text-xs italic underline cursor-pointer" phx-click="clear-rating">
            clear
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, rating: 2.0)
    {:ok, socket}
  end

  def handle_event("rating-click", %{"value" => value}, socket) do
    {v, _} = Float.parse(value)
    socket = assign(socket, rating: v)
    {:noreply, socket}
  end

  def handle_event("clear-rating", _, socket) do
    socket = assign(socket, rating: 0)
    {:noreply, socket}
  end
end
