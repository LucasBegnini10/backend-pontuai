defmodule PhxWeb.ErrorJSON do
   def render(template, _assigns) do
    %{
      is_success: false, 
      errors: %{
        detail: Phoenix.Controller.status_message_from_template(template)
      }
    }
  end
end
