class SubsidiaryDataController < ApplicationController

  def index
    @purchases = Purchase.all
    accounting = Accounting.new(@purchases)
    @revenue = accounting.display_revenue
    @subsidiary_data = SubsidiaryData.all
  end

  def new
    @subsidiary_data = SubsidiaryData.new
  end

  def create
    @subsidiary_data = SubsidiaryData.new(params[:subsidiary_data])
    if @subsidiary_data.save
      @subsidiary_data.async_process_import_data
      redirect_to subsidiary_data_path
    else
      render :new
    end
  end

  def destroy
    @subsidiary_data = SubsidiaryData.find(params[:id])
    @subsidiary_data.destroy
    redirect_to subsidiary_data_path
  end
end
