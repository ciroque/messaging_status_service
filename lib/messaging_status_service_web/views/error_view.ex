defmodule MessagingStatusServiceWeb.ErrorView do
  use MessagingStatusServiceWeb, :view

  def render("500.json", _assigns) do
    %{
      errors: [
        %{
          status: 500,
          title: "Internal server error",
          detail: "Something bad happened"
        }
      ]
    }
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
