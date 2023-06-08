defmodule PhxWeb.AccountJSON do
  def render("account.json", %{content: content}) do
    %{is_success: true, content: content}
  end

  def render("error-changeset.json", %{content: content}) do
    errors = Enum.map(content, fn {key, {label, _}} -> 
      %{key => label}
    end)
    %{is_success: false, errors: errors }
  end

    def render("500.json", _assigns) do
      %{is_success: false, errors: %{detail: "Internal Server Error"}}
    end

  
end
