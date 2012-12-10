require 'csv'

class XylotonesController < ApplicationController
  def new
    @xylotone = Xylotone.new
  end

  def create
    logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    logger.info params.inspect
    @xylotone = Xylotone.new(params[:xylotone])
    if @xylotone.save
      redirect_to xylotone_path(@xylotone.id)
    else
      render 'xylotones/new'
    end
  end

  def show
    @xylotone = Xylotone.find(params[:id])
    @dots = []
    CSV.foreach(File.join(Rails.public_path, "bob.csv"), 'r') do |row|
      dot = []
      row.each do |string|
        dot << string.to_i
      end
      @dots << dot
    end
    puts "HEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEYHEY"
    puts @dots.inspect
  end

  def update
    @dots = Dot.find params[:deleted_ids]
    @dots.each(&:hide)
    render :json => { :success => true }
  end
end