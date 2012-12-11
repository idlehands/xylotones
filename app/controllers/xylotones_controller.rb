require 'csv'
require 'net/http'
require 'open-uri'

class XylotonesController < ApplicationController
  def new
    @xylotone = Xylotone.new
  end

  def create
    @xylotone = Xylotone.new(params[:xylotone])
    puts @xylotone.inspect
    if @xylotone.save
      redirect_to xylotone_path(@xylotone.id)
    else
      render 'xylotones/new'
    end
  end

  def show
    @xylotone = Xylotone.find(params[:id])
    @dots = []
    data = open(@xylotone.dot_file.url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    CSV.foreach(data, 'r') do |row|
      dot = []
      puts row
      row.each do |string|
        dot << string.to_i
      end
    @dots << dot
    end
  end

  def update
    @dots = Dot.find params[:deleted_ids]
    @dots.each(&:hide)
    render :json => { :success => true }
  end
end