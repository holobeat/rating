defmodule RatingWeb.AppComponents do
  use Phoenix.Component

  def svg_star(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xml:space="preserve"
      width="20.077"
      height="20.05"
      viewBox="0 0 5.312 5.305"
      class="absolute left-0 top-0 h-full w-full"
    >
      <path
        d="M4.199 5.145 2.656 4.128 1.113 5.145l.445-1.855L.16 2.064l1.817-.13.68-1.774.678 1.775 1.817.13L3.754 3.29Z"
        style="fill:#ffa41c;stroke:#e17d20;stroke-width:.319808;stroke-linejoin:round"
      />
    </svg>
    """
  end

  def svg_star_outline(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xml:space="preserve"
      width="20.077"
      height="20.05"
      viewBox="0 0 5.312 5.305"
      class="absolute left-0 top-0 h-full w-full"
    >
      <path
        d="M4.199 5.145 2.656 4.128 1.113 5.145l.445-1.855L.16 2.064l1.817-.13.68-1.774.678 1.775 1.817.13L3.754 3.29Z"
        style="fill:#fff;stroke:#e17d20;stroke-width:.319808;stroke-linejoin:round;fill-opacity:1"
      />
    </svg>
    """
  end

  def svg_star_half(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xml:space="preserve"
      width="20.077"
      height="20.05"
      viewBox="0 0 5.312 5.305"
      class="absolute left-0 top-0 h-full w-full"
    >
      <path
        d="M2.656 4.128 1.113 5.145l.445-1.855L.16 2.064l1.817-.13.68-1.774Z"
        style="fill:#ffa41c;stroke:none;stroke-width:.319808;stroke-linejoin:round"
      /><path
        d="M2.656 4.128 4.2 5.145 3.754 3.29l1.398-1.226-1.817-.13L2.656.16Z"
        style="fill:#fff;stroke:none;stroke-width:.319808;stroke-linejoin:round;fill-opacity:1"
      /><path
        d="M4.199 5.145 2.656 4.128 1.113 5.145l.445-1.855L.16 2.064l1.817-.13.68-1.774.678 1.775 1.817.13L3.754 3.29Z"
        style="fill:none;stroke:#e17d20;stroke-width:.319808;stroke-linejoin:round;stroke-opacity:1"
      />
    </svg>
    """
  end

  def svg_star_off(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      xml:space="preserve"
      width="20.077"
      height="20.05"
      viewBox="0 0 5.312 5.305"
      class="absolute left-0 top-0 h-full w-full"
    >
      <path
        d="M4.199 5.145 2.656 4.128 1.113 5.145l.445-1.855L.16 2.064l1.817-.13.68-1.774.678 1.775 1.817.13L3.754 3.29Z"
        style="fill:#d9d9d9;fill-opacity:1;stroke:#bdbdbc;stroke-width:.319808;stroke-linejoin:round;stroke-opacity:1"
      />
    </svg>
    """
  end

  attr :id, :string, required: false
  attr :max, :integer, default: 5
  attr :value, :float, default: 0.0
  attr :class, :string, default: "w-5 h-5"
  attr :rest, :global

  def rating(assigns) do
    IO.inspect(assigns.rest)

    ~H"""
    <%= if Map.has_key?(assigns.rest, :"phx-click") do %>
      <div class="flex" id={@id}>
        <div
          :for={{i, t} <- get_rating_fragments(@max, @value)}
          name={"#{@id}-#{i}"}
          id={"#{@id}-#{i}"}
          class={["inline-block relative", @class]}
          phx-value-value={i}
          phx-value-id={"#{@id}-#{i}"}
          {@rest}
        >
          <.svg_star :if={t == :full} /> <.svg_star_half :if={t == :half} />
          <.svg_star_outline :if={t == :empty} />
        </div>
      </div>
    <% else %>
      <div class="flex">
        <div
          :for={{_, t} <- get_rating_fragments(@max, @value)}
          class={["inline-block relative", @class]}
          {@rest}
        >
          <.svg_star :if={t == :full} /> <.svg_star_half :if={t == :half} />
          <.svg_star_outline :if={t == :empty} />
        </div>
      </div>
    <% end %>
    """
  end

  defp get_rating_fragments(max, value) do
    Enum.map(1..max, fn i ->
      cond do
        i <= value ->
          {i, :full}

        floor(value) != i && value < ceil(value) && floor(value) + 1 == i ->
          n = value - floor(value)

          cond do
            n <= 0.25 -> {i, :empty}
            n > 0.75 -> {i, :full}
            true -> {i, :half}
          end

        true ->
          {i, :empty}
      end
    end)
  end
end
