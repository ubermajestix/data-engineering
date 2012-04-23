class SubsidiaryDataController < ApplicationController

  def index
    @subsidiary_data = SubsidiaryData.all
  end

  def new
    @subsidiary_data = SubsidiaryData.new
  end

  def create
    @subsidiary_data = SubsidiaryData.new(params[:subsidiary_data])
    if @subsidiary_data.save
      redirect_to :index
    else
      render :new
    end
  end
end
