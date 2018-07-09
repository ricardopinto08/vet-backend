class V1::HorsesController < ApplicationController
  before_action :set_user, only: [:deleteVet, :addVet, :changeVet, :sell, :getCurrentOwner, :getVets, :getClients, :show, :destroy]

  def index
    @horses =Horse.all
    render json: @horses, status: :ok
  end

  def show
    @horse = Horse.find(params[:id])
    render json: @horse, status: :ok
  end

  def create
    @horse = Horse.new(horse_attr)
    @vet = Vet.find_by_email(horse_params[:emailVet])
    puts "-------------"
    puts horse_params
    @client = Client.find_by_email(horse_params[:emailClient])
    @horse.vets << @vet
    @horse.clients << @client
    @horse.save
    render json: @horse, status: :created
  end

  def getCurrentOwner
    @owners = Owner.where(horse_id:params[:id])
    @owner = @owners.sort_by &:created_at
    @client = Client.find(@owner.last.client_id)
    render json: @client, status: :created
  end

  def getCurrentVet
    @audits = Audit.where(horse_id:params[:id])
    @audit = @audits.sort_by &:created_at
    @vet = Vet.find(@audit.last.vet_id)
    render json: @vet, status: :created
  end

  def sell
    @owners = Owner.where(horse_id:params[:id])
    @sorted = @owners.sort_by &:created_at
    @owner = @sorted.last
    @client = Client.find_by_email(params[:emailClient])
    if !@client.nil? && @owner.client_id != params[:emailClient]
      @owner.end_date=Time.now
      @owner.save
      @horse.clients << @client
      render json: @client, status: :created
    else
      render json: { error: "Este correo no existe" }, status: :unauthorized
    end
  end

  def changeVet
    @audits = Audit.where(horse_id:params[:id])
    @sorted = @audits.sort_by &:created_at
    @audit = @sorted.last
    @vet = Vet.find_by_email(params[:emailVet])
    if !@vet.nil? && @audit.vet_id != params[:emailVet]
      @audit.end_date=Time.now
      @audit.save
      @horse.vets << @vet
      render json: @vet, status: :created
    else
      render json: { error: "Este correo no existe" }, status: :unauthorized
    end
  end

  def deleteVet
    @vet = Vet.find_by_email(params[:emailVet])
    @audits = Audit.where(horse_id:params[:id]).where(vet_id:@vet.id)
    @sorted = @audits.sort_by &:created_at
    @audit = @sorted.last
    @audit.vet_id != params[:emailVet]
    @audit.end_date=Time.now
    @audit.save
    render json: @vet, status: :created
  end

  def destroy
    if @horse.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def getVets
    sql = "SELECT users.id, users.email, users.name, users.lastname, audits.created_at FROM users INNER JOIN audits ON users.id = audits.vet_id WHERE audits.end_date IS NULL AND audits.horse_id = "+params[:id]
    @vets = ActiveRecord::Base.connection.execute(sql)
    render json: @vets, status: :created
  end

  def getClients
    sql = "SELECT users.id, users.email, users.name, users.lastname, owners.created_at FROM users INNER JOIN owners ON users.id = owners.client_id WHERE owners.end_date IS NULL AND owners.horse_id = "+params[:id]
    @clients = ActiveRecord::Base.connection.execute(sql)
    render json: @clients, status: :created
  end

  def addVet
    @vet = Vet.find_by_email(params[:emailVet])
    if !@vet.nil?
      @horse.vets << @vet
      render json: @horse, status: :created
    end
  end

  def historyOfOwners
    sql = "SELECT users.id, users.email, users.phone, users.name, users.lastname, owners.created_at, owners.end_date FROM users INNER JOIN owners ON users.id = owners.client_id WHERE owners.horse_id = "+params[:id]
    @clients = ActiveRecord::Base.connection.execute(sql)
    render json: @clients, status: :created
  end

  def getMedicalHistory
    sql = "SELECT audits.id as audit_id, examinations.id, examinations.title, examinations.description, examinations.city, examinations.address, examinations.start_hour, examinations.end_hour, users.name as vet_name, users.lastname as vet_lastname, users.email as vet_email FROM horses INNER JOIN audits ON horses.id = audits.horse_id INNER JOIN examinations ON audits.id = examinations.audit_id INNER JOIN users ON users.id = audits.vet_id  WHERE audits.horse_id = "+params[:id]
    @history = ActiveRecord::Base.connection.execute(sql)
    render json: @history, status: :created
  end

  def historyOfVets
    sql = "SELECT users.id, users.email, users.phone, users.name, users.lastname, audits.created_at, audits.end_date FROM users INNER JOIN audits ON users.id = audits.vet_id WHERE audits.horse_id = "+params[:id]
    @clients = ActiveRecord::Base.connection.execute(sql)
    render json: @clients, status: :created
  end

  def set_user
    @horse = Horse.find(params[:id])
  end

private
  def horse_params
    params.permit(:name, :breed, :mom, :dad, :gender, :color, :born_date, :current_weight, :current_chest, :current_umbilical, :current_shoulder, :current_olecranon, :current_height, :born_weight, :born_chest, :born_umbilical, :born_shoulder, :born_olecranon, :born_height, :emailVet, :emailClient)
  end

  def horse_attr
    params.permit(:name, :breed, :mom, :dad, :gender, :color, :born_date, :current_weight, :current_chest, :current_umbilical, :current_shoulder, :current_olecranon, :current_height, :born_weight, :born_chest, :born_umbilical, :born_shoulder, :born_olecranon, :born_height)
  end


end
