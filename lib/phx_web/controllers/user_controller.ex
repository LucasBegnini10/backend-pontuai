defmodule PhxWeb.UserController do 
  use PhxWeb, :controller
  use PhoenixSwagger
  alias Phx.Config.CommonParameters
  alias Phx.Service.{SessionService, UserService}
  alias Phx.Schema.UserSchema

  def swagger_definitions do
    %{
      UserCreate: swagger_schema do
        title "User Create"
        description "A user of the application"
        properties do
          user_id :string, "User id", required: false
          first_name :string, "First name of user", required: true
          last_name :string, "Last name of user", required: false
          email :string, "Email of user", required: true
          document :string, "Document of user", required: true
          password :string, "Password of user", required: true
        end
      end,
      UserUpdate: swagger_schema do
        title "User Update"
        description "User editable fields"
        properties do
          first_name :string, "First name of user", required: true
          last_name :string, "Last name of user", required: false
          email :string, "Email of user", required: true
          password :string, "Password of user", required: true
        end
      end,
      Auth: swagger_schema do
        title "User Auth"
        description "Fields to authenticate user"
        properties do
          identifier :string, "User document or email", required: true
          password :string, "Password of user", required: true
        end
      end
    }
  end

  swagger_path :get_user do
    get "/api/v1/users/{user_id}"
    summary "Get user"
    description "Get user filtering by user id"
    produces "application/json"
    parameters do
      user_id :path, :string, "User id"
    end
    CommonParameters.authorization
    response(200, "OK")
    response(404, "User not found")
    tag "Users"
  end
  def get_user(conn, params) do
    case UserService.get(params["user_id"]) do 
      %UserSchema{} = user -> 
        conn |> put_status(:ok) |> render("user-found.json", user: user)
      _ -> 
        conn
        |> put_status(:not_found)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("404.json")
        |> halt()
    end
  end

  swagger_path :create do
    post "/api/v1/users"
    summary "Create a new user"
    parameters do
      user :body, Schema.ref(:UserCreate), "user attributes"
    end
    response(201, "User created")
    response(400, "Bad request - Any field invalid")
    response(500, "Internal Error")
    tag "Users"
  end
  def create(conn, params) do 
    {status, content} = UserService.create(params)
    
    case status do 
      :created -> conn |> put_status(:created) |> render("user-created.json", user: content)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :error -> 
         conn
          |> put_status(:internal_server_error)
          |> put_view(PhxWeb.ErrorJSON)
          |> render("500.json")
          |> halt()
    end
  end 

  swagger_path :update do
    patch "/api/v1/users/{user_id}"
    summary "Update user"
    description "Update a user filtered by id"
    produces "application/json"
    parameters do
      user_id :path, :string, "User id"
      user :body, Schema.ref(:UserUpdate), "user attributes"
    end
    CommonParameters.authorization
    response(200, "OK")
    response(404, "User not found")
    response(400, "Bad Request - any field invalid")
    response(500, "Internal Error")
    tag "Users"
  end
  def update(conn, params) do 
    user_id = params["user_id"]

    {status, content} = UserService.update(user_id, params)

    case status do 
      :updated -> 
        {user, token} = content 
        conn |> put_status(:ok) |> render("user-updated.json", user: user, token: token)
      :error_changeset -> conn |> put_status(:bad_request) |> render("error-changeset.json", content: content)
      :no_result -> conn |> put_status(:not_found) |> render("user-not-found.json", user_id: user_id)
      :error -> 
        conn
        |> put_status(:internal_server_error)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("500.json")
        |> halt()
    end
  end

  swagger_path :delete_user do
    delete "/api/v1/users/{user_id}"
    summary "Delete user"
    description "Delete a user filtered by id"
    produces "application/json"
    parameters do
      user_id :path, :string, "User id"
    end
    CommonParameters.authorization
    response(200, "OK")
    response(404, "User not found")
    response(500, "Internal Error")
    tag "Users"
  end
  def delete_user(conn, params) do 
    user_id = params["user_id"]
    res = UserService.delete(user_id)

    case res do 
      {:deleted, _schema} ->  conn |> put_status(:ok) |> render("user-deleted.json", user_id: user_id)
      {:not_found, %Ecto.NoResultsError{}} -> conn |> put_status(:not_found) |> render("user-not-found.json", user_id: user_id)
      {:error, _error} ->  
        conn
          |> put_status(:internal_server_error)
          |> put_view(PhxWeb.ErrorJSON)
          |> render("500.json")
          |> halt()
    end
  end
  
  swagger_path :get_points do
    get "/api/v1/users/{user_id}/points"
    summary "Get user points"
    description "Get user points filtered by user_id"
    produces "application/json"
    parameters do
      user_id :path, :string, "User id"
    end
    CommonParameters.authorization
    response(200, "OK")
    response(404, "User not found")
    tag "Users"
  end
  def get_points(conn, params) do 
    user_id = params["user_id"]
    points = UserService.get_points(user_id)
    case points do 
      nil -> 
        conn
        |> put_status(:not_found)
        |> put_view(PhxWeb.ErrorJSON)
        |> render("404.json")
        |> halt()
      _ -> conn |> put_status(:ok) |> render("user-points.json", user_id: user_id, points: points)
    end
  end

  swagger_path :auth do
    post "/api/v1/users/auth"
    summary "Auth user"
    description "Authentication user with identifier and password. Identifier can be document or email"
    produces "application/json"
    parameters do
      auth :body, Schema.ref(:Auth), "Auth attributes"
    end
    response(200, "Authenticated")
    response(401, "Unauthorized")
    tag "Users"
  end
  def auth(conn, %{"identifier" => identifier, "password" => password}) do
    case SessionService.new(%{"identifier" => identifier, "password" => password}) do 
      {:ok, token, user} -> conn |> put_status(:ok) |> render("authenticated.json", token: token, user: user)
      {:error, _message} ->  
        conn
          |> put_status(:unauthorized)
          |> put_view(PhxWeb.ErrorJSON)
          |> render("401.json")
          |> halt()
    end
  end
end