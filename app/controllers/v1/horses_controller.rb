class V1::HorsesController < ApplicationController
  before_action :set_user, only: [:getCurrentOwner, :getVets, :getClients, :show, :destroy]

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
    puts "----------------"
    @owner = Owner.where(horse_id => params[:id])
    puts @owner.client_id
  end

  def getCurrentVet
  end

  def sell
  end

  def changeVet
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
