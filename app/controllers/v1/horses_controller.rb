class V1::HorsesController < ApplicationController
  def index
    @horses =Horse.all

    render json: @horses, status: :ok
  end

  def show
    @horses =Horse.all

    render json: @horses, status: :ok
  end

  def create
    @horse = Horse.new(horse_params)

    @horse.save
    render json: @horse, status: :created
  end

  def destroy
    @horse = Horse.where(id:params[:id]).first
    if @horse.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def horse_params
    params.permit(:name,:born_date)
  end
end
