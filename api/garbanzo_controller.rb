# six.rb

class GarbanzoController < ApplicationController
  def index
    @garbanzos = Garbanzo.all
  end
  
  def show
    @garbanzo = Garbanzo.find(params[:id])
  end
  
  def new
    @garbanzo = Garbanzo.new
  end
  
  def create
    @garbanzo = Garbanzo.new(garbanzo_params)
    if @garbanzo.save
      redirect_to @garbanzo
    else
      render 'new'
    end
  end
  
  def edit
    @garbanzo = Garbanzo.find(params[:id])
  end
  
  def update
    @garbanzo = Garbanzo.find(params[:id])
    if @garbanzo.update(garbanzo_params)
      redirect_to @garbanzo
    else
      render 'edit'
    end
  end
  
  def destroy
    @garbanzo = Garbanzo.find(params[:id])
    @garbanzo.destroy
    redirect_to garbanzos_path
  end
  
  private
  
  def garbanzo_params
    params.require(:garbanzo).permit(:name, :description, :price)
  end
end
