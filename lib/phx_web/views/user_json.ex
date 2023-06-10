defmodule PhxWeb.UserJSON do
  def render("user-created.json", %{user: user}) do
    %{
      is_success: true, 
      created: true,
      user: show_user(user)
    }
  end

  def render("user-updated.json", %{user: user}) do
    %{
      is_success: true, 
      updated: true,
      user: show_user(user)
    }
  end

  def render("user-found.json", %{user: user}) do
    %{
      is_success: true, 
      found: true,
      user: show_user(user)
    }
  end

  def render("error-changeset.json", %{content: content}) do
    errors = Enum.map(content, fn {key, {label, _}} -> 
      %{key => label}
    end)
    %{
      is_success: false, 
      errors: errors 
    }
  end

  def render("500.json", _assigns) do
    %{
      is_success: false, 
      errors: %{
        detail: "Internal Server Error"
      }
    }
  end

  def render("authenticated.json", %{token: token, user: user}) do
    %{
      is_success: true,
      content: %{
        token: token,
        user: show_user(user)
      }
    }
  end

  def render("user-not-found.json", %{user_id: user_id}) do 
    %{
      is_success: false,
      errors: %{
        detail: "User #{user_id} not found"
      }
    }
  end


  defp show_user(user) do 
    %{
      user_id: user.user_id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      document: user.document,
      # code_reset_password: user.code_reset_password,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
  
end
