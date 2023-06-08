defmodule Phx.Repository.VoucherRepository do 
  alias Phx.Repo
  alias Phx.Schema.VoucherSchema

  def create(attrs \\ %{}) do 
    try do
      %VoucherSchema{}
      |> VoucherSchema.changeset(attrs)
      |> Repo.insert()
    rescue e ->
      IO.inspect(e, label: "Create Voucher ===>")
      {:error, e}
    end 
  end

  def get(voucher_id) do 
    try do 
      Repo.get_by(VoucherSchema, voucher_id: voucher_id)
    rescue e -> 
      IO.inspect(e, label: "Get Voucher ===>")
      {:error, e}
    end
  end

  def update(voucher_id, attrs \\ %{}) do 
    try do 
      Repo.get_by!(VoucherSchema, voucher_id: voucher_id)
      |> VoucherSchema.changeset(attrs)
      |> Repo.update()
    rescue e -> 
      IO.inspect(e, label: "Update Voucher ===>")
      {:error, e}
    end
  end

  def delete(voucher_id) do 
    try do 
      Repo.get_by!(VoucherSchema, voucher_id: voucher_id)
      |> Repo.delete()
    rescue e ->
      IO.inspect(e, label: "Delete Voucher ==>")
      {:error, e}
    end
  end

  def get_by_user(user_id) do 
    try do 
      Repo.get_by(VoucherSchema, user_id: user_id)
    rescue e -> 
      IO.inspect(e, label: "Get Voucher by User ===>")
      {:error, e}
    end
  end


end