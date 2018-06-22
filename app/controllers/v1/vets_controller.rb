class V1::VetsController < ApplicationController
  before_action :set_user, only: [:getHorses, :show, :update, :destroy]

  # GET /vets
  def index
    @vets = Vet.all
    render json: @vets
  end

  # GET /vets/1
  def show
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


  def getHorses
    sql = "SELECT * FROM horses INNER JOIN audits ON horses.id = audits.horse_id WHERE audits.end_date IS NULL AND audits.vet_id = "+params[:id]
    @horses = ActiveRecord::Base.connection.execute(sql)
    render json: @horses, status: :created
  end

  # DELETE /vets/1
  def destroy
    @vet.destroy
  end

  def set_user
    @vet = Vet.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a trusted parameter "white list" through.
    def user_params
      return params.permit(:name, :lastname, :email, :password, :password_confirmation)
    end
end
