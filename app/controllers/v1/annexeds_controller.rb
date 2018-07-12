class V1::AnnexedsController < ApplicationController
  before_action :set_annexed, only: [:show, :destroy]

  def index
    @annexeds = Annexed.all
    render json: @annexeds, status: :ok
  end

  def show
    render json: @annexed, status: :ok
  end

  def create
    puts annexed_params[:examination_id]
    sql = "SELECT * FROM audits INNER JOIN examinations ON audits.id = examinations.audit_id  WHERE examinations.id = "+annexed_params[:examination_id]+" AND audits.end_date IS NULL"
    @audit = ActiveRecord::Base.connection.execute(sql).first
    @annexed = Annexed.new(annexed_params)
    @examination = Examination.find(params[:examination_id])
    @examination.annexeds << @annexed
    @examination.save
    @horse = Horse.find(@audit["horse_id"])
    @horse.current_weight = @annexed.current_weight
    @horse.current_chest = @annexed.current_chest
    @horse.current_umbilical = @annexed.current_umbilical
    @horse.current_shoulder = @annexed.current_shoulder
    @horse.current_olecranon = @annexed.current_olecranon
    @horse.current_height = @annexed.current_height
    @horse.save

    if @annexed.save
      render json: @annexed, status: :created
    else
      render json: @annexed.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @annexed.destroy
  end

private
  def set_annexed
    @annexed = Annexed.find(params[:id])
  end

  def all_params
    params.permit(:title, :description, :city, :address, :start_date, :end_date, :idVet, :idHorse)
  end

  def annexed_params
    params.permit(:examination_id, :date, :image, :title, :description, :city, :address, :start_hour, :end_hour, :current_weight, :current_chest, :current_umbilical, :current_shoulder, :current_olecranon, :current_height)
  end

end
