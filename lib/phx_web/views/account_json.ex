defmodule PhxWeb.AccountJSON do
  def render("account.json", %{content: content}) do
    %{is_success: true, 
    content: %{
      user_created: %{
        user_id: content.user_id,
        first_name: content.first_name,
        last_name: content.last_name,
        email: content.email,
        document: content.document,
        # code_reset_password: content.code_reset_password,
        inserted_at: content.inserted_at,
        updated_at: content.updated_at
      }
    }}
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
