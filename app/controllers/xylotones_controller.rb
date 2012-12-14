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

  def show #Get this in the dot_gen module!!!!
    @xylotone = Xylotone.find(params[:id])
    @dots = []
    data = open(@xylotone.dot_file.url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    CSV.foreach(data, 'r') do |row|
      dot = []
      (0..3).each do |index|
        dot << row[index].to_i
      end
      dot << row[4]
      puts dot.inspect
      if dot[4] == "false"
        @dots << dot
      end
    end
  end

  def update
    deleted_dot_ids = params[:deleted_ids].map(&:to_i)
    delete_dots(deleted_dot_ids, params[:id])
    render :json => { :success => true }
  end
end
