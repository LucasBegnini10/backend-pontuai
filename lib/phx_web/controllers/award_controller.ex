defmodule PhxWeb.AwardController do
  use PhxWeb, :controller
  use PhoenixSwagger

  alias Phx.Service.AwardService
  alias Phx.Schema.AwardSchema
  alias Phx.Config.CommonParameters

  def swagger_definitions do
    %{
      Award:
        swagger_schema do
          title("Award Model")
          description("An award in the system")

          properties do
            award_id(:string, "Award ID", required: false)
            name(:string, "Name", required: true)
            points(:integer, "Points", required: true)
            description(:integer, "Description", required: false)
            status(:boolean, "Status", required: false)
          end
        end
    }
  end

  swagger_path :create do
    post("/api/v1/awards")
    summary("Create a new award")

    parameters do
      award(:body, Schema.ref(:Award), "Award attributes")
    end

    response(201, "Award created")
    response(400, "Bad request - Any field invalid")
    response(500, "Internal Error")
    CommonParameters.authorization()
    tag("Awards")
  end

  def create(conn, params) do
    case AwardService.create(params) do
      {:created, content} ->
        conn |> put_status(:created) |> render("award-created.json", award: content)

      {:error_changeset, content} ->
        conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)

      {:error, _err} ->
        conn
        |> put_status(:internal_server_error)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("500.json")
        |> halt()
    end
  end

  swagger_path :get_award_by_id do
    get("/api/v1/awards/{award_id}")
    summary("Get an award")
    description("Get an award by filtering with the award ID")
    produces("application/json")

    parameters do
      award_id(:path, :string, "Award ID")
    end

    CommonParameters.authorization()
    response(200, "OK")
    response(404, "Award not found")
    tag("Awards")
  end

  def get_award_by_id(conn, params) do
    award_id = params["award_id"]

    case AwardService.get(award_id) do
      %AwardSchema{} = award ->
        conn |> put_status(:ok) |> render("award-found.json", award: award)

      _ ->
        conn
        |> put_status(:not_found)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("404.json")
        |> halt()
    end
  end

  swagger_path :update_award do
    put("/api/v1/awards/{award_id}")
    summary("Update an award")
    description("Update an award by specifying the award ID")

    parameters do
      award_id(:path, :string, "Award ID")
      award(:body, Schema.ref(:Award), "Updated award attributes")
    end

    CommonParameters.authorization()
    response(200, "OK")
    response(400, "Bad request - Any field invalid")
    response(404, "Award not found")
    response(500, "Internal Error")
    tag("Awards")
  end

  def update_award(conn, params) do
    award_id = params["award_id"]

    case AwardService.update(award_id, params) do
      {:updated, content} ->
        conn |> put_status(:ok) |> render("award-updated.json", award: content)

      {:error_changeset, content} ->
        conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)

      :error_not_found ->
        conn
        |> put_status(:not_found)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("404.json")
        |> halt()

      {:error, _err} ->
        conn
        |> put_status(:internal_server_error)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("500.json")
        |> halt()
    end
  end

  swagger_path :delete_award do
    delete("/api/v1/awards/{award_id}")
    summary("Delete an award")
    description("Delete an award by specifying the award ID")

    parameters do
      award_id(:path, :string, "Award ID")
    end

    CommonParameters.authorization()
    response(204, "No Content")
    response(404, "Award not found")
    response(500, "Internal Error")
    tag("Awards")
  end

  def delete_award(conn, params) do
    award_id = params["award_id"]

    case AwardService.delete(award_id) do
      :ok ->
        conn |> put_status(:ok) |> render("award-deleted.json", award_id: award_id)

      :error_not_found ->
        conn
        |> put_status(404)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("404.json")

      _ ->
        conn
        |> put_status(500)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("500.json")
    end
  end
end
