class V1::ExaminationsController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

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
    if @audits.count >0
      @examination = Examination.new(examination_params)
      @examination.audit_id = @auditId
      if @examination.save
        @audit.examinations << @examination
        @audit.save
        render json: @examination, status: :created
      else
        render json: @examination.errors, status: :unprocessable_entity
      end
    end
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
    params.permit(:title, :description, :city, :address, :start_hour, :end_hour)
  end

end
