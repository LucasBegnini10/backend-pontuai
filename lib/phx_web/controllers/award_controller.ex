defmodule PhxWeb.AwardController do
  use PhxWeb, :controller
  use PhoenixSwagger

  alias Phx.Service.AwardService

  def swagger_definitions do
    %{
      Award:
        swagger_schema do
          title("Award Model")
          description("A award in system")

          properties do
            award_id(:string, "Award id", required: false)
            name(:string, "Name", required: true)
            points(:integer, "Points", required: true)
            description(:integer, "Description", required: false)
            status(:boolean, "status", required: false)
          end
        end
    }
  end

  swagger_path :create do
    post("/api/v1/awards")
    summary("Create a new award")

    parameters do
      user(:body, Schema.ref(:Award), "Award attributes")
    end

    response(201, "Award created")
    response(400, "Bad request - Any field invalid")
    response(500, "Internal Error")
    tag("Award")
  end

  def create(conn, params) do
    case AwardService.create(params) do
      {:created, content} ->
        conn |> put_status(:created) |> render("award-created.json", award: content)

      {:error_changeset, content} ->
        conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)

      {:error, err} ->
        conn
        |> put_status(:internal_server_error)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("500.json")
        |> halt()
    end
  end
end
