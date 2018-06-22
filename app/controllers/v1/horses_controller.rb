class V1::HorsesController < ApplicationController
  before_action :set_user, only: [:changeVet, :sell, :getCurrentOwner, :getVets, :getClients, :show, :destroy]

  def index
    @horses =Horse.all
    render json: @horses, status: :ok
  end

  def show
    @horse = Horse.find(params[:id])
    render json: @horse, status: :ok
  end

  def create
    @horse = Horse.new(horse_params)
    @vet = Vet.find_by_email(params[:emailVet])
    @client = Client.find_by_email(params[:emailClient])
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
    @owner.end_date=Time.now
    @owner.save
    @client = Client.find_by_email(params[:emailClient])
    @horse.clients << @client
    render json: @client, status: :created
  end

  def changeVet
    @audits = Audit.where(horse_id:params[:id])
    @sorted = @audits.sort_by &:created_at
    @audit = @sorted.last
    @audit.end_date=Time.now
    @audit.save
    @vet = Vet.find_by_email(params[:emailVet])
    @horse.vets << @vet
    render json: @vet, status: :created
  end

  def destroy
    @horse = Horse.where(id:params[:id]).first
    if @horse.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end
  end

  def getVets
    @vets = @horse.vets
    render json: @vets, status: :ok
  end

  def getClients
    @clients = @horse.clients
    render json: @clients, status: :ok
  end


  def set_user
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.permit(:name, :born_date)
  end

end
