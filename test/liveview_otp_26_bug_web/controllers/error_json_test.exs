defmodule LiveviewOtp26BugWeb.ErrorJSONTest do
  use LiveviewOtp26BugWeb.ConnCase, async: true

  test "renders 404" do
    assert LiveviewOtp26BugWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LiveviewOtp26BugWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
