defmodule RatingWeb.ErrorJSONTest do
  use RatingWeb.ConnCase, async: true

  test "renders 404" do
    assert RatingWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RatingWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
