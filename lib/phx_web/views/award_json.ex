defmodule PhxWeb.AwardJSON do
  def render("award-created.json", %{award: award}) do
    %{
      is_success: true,
      content: %{
        created: true,
        award: show_award(award)
      }
    }
  end

  def render("error-changeset.json", %{content: content}) do
    %{
      is_success: false,
      errors: Enum.map(content, fn {key, {label, _}} -> %{key => label} end)
    }
  end

  def render("award-found.json", %{award: award}) do
    %{
      is_success: true,
      content: %{
        found: true,
        award: show_award(award)
      }
    }
  end

  defp show_award(award) do
    %{
      award_id: award.award_id,
      name: award.name,
      points: award.points,
      description: award.description,
      status: award.status,
      inserted_at: award.inserted_at,
      updated_at: award.updated_at
    }
  end
end
