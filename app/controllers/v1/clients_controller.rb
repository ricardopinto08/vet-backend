class V1::ClientsController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

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