class V1::ExaminationsController < ApplicationController
  before_action :set_examination, only: [:getAnnexeds, :show, :destroy]

  def index
    @examinations = Examination.all
    render json: @examinations, status: :ok
  end

  def show
    render json: @examination, status: :ok
  end

  def create
    sql = "SELECT * FROM audits WHERE audits.vet_id = "+params[:idVet]+" AND audits.horse_id = "+params[:idHorse]+" AND audits.end_date IS NULL"
    @audits = ActiveRecord::Base.connection.execute(sql)
    @auditId = @audits.first["id"]
    @audit = Audit.find(@auditId)
    if @audits.count > 0
      @examination = Examination.new(examination_params)
      @examination.audit_id = @auditId
      if @examination.save
        @audit.examinations << @examination
        @audit.save
        @horse = Horse.find(@audit.horse_id)
        @horse.current_weight = @examination.current_weight
        @horse.current_chest = @examination.current_chest
        @horse.current_umbilical = @examination.current_umbilical
        @horse.current_shoulder = @examination.current_shoulder
        @horse.current_olecranon = @examination.current_olecranon
        @horse.current_height = @examination.current_height
        @horse.save
        render json: @examination, status: :created
      else
        render json: @examination.errors, status: :unprocessable_entity
      end
    end
  end

  def getAnnexeds
    render json: @examination.annexeds, status: :created
  end

  def getNumAnnexeds
    render json: @examination.annexeds.count, status: :created
  end


  def destroy
    @examination.destroy
  end

private
  def set_examination
    @examination = Examination.find(params[:id])
  end

  def all_params
    params.permit(:title, :description, :city, :address, :start_date, :end_date, :idVet, :idHorse)
  end

  def examination_params
    params.permit(:title, :description, :city, :address, :start_hour, :end_hour, :current_weight, :current_chest, :current_umbilical, :current_shoulder, :current_olecranon, :current_height)
  end

end
