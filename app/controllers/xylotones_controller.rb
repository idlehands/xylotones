require 'csv'
require 'net/http'
require 'open-uri'

class XylotonesController < ApplicationController
  include DotGen

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
    @dots = dots_from_url(@xylotone.dot_file.url)
    # @dots = JSON.parse(data)
  end

  def update
    xylotone = Xylotone.find(params[:id])
    deleted_dot_ids = params[:deleted_ids].map(&:to_i)
    delete_dots(deleted_dot_ids, xylotone)
    render :json => { :success => true }
  end
end
