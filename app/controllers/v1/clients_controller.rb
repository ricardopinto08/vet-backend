class V1::ClientsController < ApplicationController
  before_action :set_user, only: [:addVet, :update, :getHorses, :destroy]

  # GET /clients
  def index
    @clients = Client.all
    render json: @clients
  end

  # GET /clients/1
  def show
    @clients = Client.all
    render json: @clients, status: :ok
  end

  # POST /clients
  def create
    @client = Client.new(user_params)
    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(user_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  def addVet
    @vet = Vet.find_by_email(params[:emailVet])
    @client.vets << @vet
  end

  def getHorses
    sql = "SELECT * FROM horses INNER JOIN owners ON horses.id = owners.horse_id WHERE owners.end_date IS NULL AND owners.client_id = "+params[:id]
    @horses = ActiveRecord::Base.connection.execute(sql)
    render json: @horses, status: :created
  end

  def getVets
    sql = "SELECT a.end_date, v.id, v.email, v.name, v.lastname, h.name as horse_name FROM audits as a INNER JOIN owners as o ON a.horse_id = o.horse_id INNER JOIN users as v ON v.id=a.vet_id INNER JOIN horses as h ON h.id=a.horse_id WHERE a.end_date IS NULL AND o.end_date IS NULL AND o.client_id = "+params[:id]
    @vets = ActiveRecord::Base.connection.execute(sql)
    render json: @vets, status: :created
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @client = Client.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      return params.permit(:name, :lastname, :email, :password, :password_confirmation)
    end
end
