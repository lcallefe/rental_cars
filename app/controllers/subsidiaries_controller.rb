class SubsidiariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def new
    @subsidiary = Subsidiary.new
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(subsidiary_params)
      redirect_to subsidiaries_path
    else
      render :edit
    end
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      redirect_to subsidiary_path(id: @subsidiary.id)
    else
      render :new
    end
  end

  private
  def subsidiary_params
    subsidiary_params = params.require(:subsidiary).permit(:name, :address, :cnpj)
  end
end