class XylotonesController < ApplicationController
  def new
    @xylotone = Xylotone.new
  end

  def create
    @xylotone = Xylotone.new(params[:xylotone])
    if @xylotone.save
      redirect_to xylotone_path(@xylotone.id)
    else
      render 'xylotones/new'
    end
  end

  def show
    @xylotone = Xylotone.find(params[:id])
  end
end