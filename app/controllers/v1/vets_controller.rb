class V1::VetsController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  # GET /vets
  def index
    @vets = Vet.all
    render json: @vets
  end

  # GET /vets/1
  def show
    @vets = Vet.all
    render json: @vets, status: :ok
  end

  # POST /vets
  def create
    @vet = Vet.new(user_params)
    if @vet.save
      render json: @vet, status: :created
    else
      render json: @vet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /vets/1
  def update
    if @vet.update(user_params)
      render json: @vet
    else
      render json: @vet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /vets/1
  def destroy
    @vet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @vet = Vet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      return params.permit(:name, :lastname, :email, :password, :password_confirmation)
    end
end
