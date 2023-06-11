defmodule PhxWeb.UserJSON do
  def render("user-created.json", %{user: user}) do
    %{
      is_success: true, 
      content: %{
        created: true,
        user: show_user(user)
      }
    }
  end

  def render("user-updated.json", %{user: user, token: token}) do
    %{
      is_success: true, 
      content: %{
        updated: true,
        user: show_user(user),
        token: token
      }
    }
  end

  def render("user-deleted.json", %{user_id: user_id}) do
    %{
      is_success: true, 
      content: %{
        deleted: true,
        user_id: user_id
      }
    }
  end

  def render("user-found.json", %{user: user}) do
    %{
      is_success: true, 
      content: %{
        found: true,
        user: show_user(user)
      }
    }
  end

  def render("error-changeset.json", %{content: content}) do
    %{
      is_success: false, 
      errors: Enum.map(content, fn {key, {label, _}} ->  %{key => label} end) 
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

  def render("user-points.json", %{user_id: user_id, points: points}) do 
    %{
      is_success: true,
      content: %{
        user_id: user_id,
        points: points
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
      points: user.points,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
  
end
