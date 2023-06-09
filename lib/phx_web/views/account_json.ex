defmodule PhxWeb.AccountJSON do
  def render("user-created.json", %{user: user} = assings) do
    %{
    is_success: true, 
    created: true,
    user: show_user(user)
    }
  end

  def render("user-updated.json", %{user: user} = assings) do
    %{
    is_success: true, 
    updated: true,
    user: show_user(user)
    }
  end

  def render("error-changeset.json", %{content: content} = assings) do
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

  def render("authenticated.json", %{token: token} = assings) do
    %{
      is_success: true,
      token: token
    }
  end

  def render("user-not-found.json", %{user_id: user_id} = assings) do 
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
