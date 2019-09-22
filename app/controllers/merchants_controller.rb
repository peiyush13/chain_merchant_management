class MerchantsController < ApplicationController
  before_action :load_merchant, methods: [:show, :update]
  skip_before_action :verify_authenticity_token, only: [:remove_from_chain, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: { chains: Merchant.all.as_json } }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { chain: @merchant.as_json } }
    end
  end

  def new;end

  def create
    @merchant = Merchant.new(merchant_params)
    respond_to do |format|
      if @merchant.save
        format.json { render json: { message: 'Merchant created Successfully' }, status: :ok }
      else
        format.json { render json: { message: @merchant.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @merchant.active = params[:active]
    respond_to do |format|
      if @merchant.save
        format.json { render json: { message: 'Merchant updated Successfully' }, status: :ok }
      else
        format.json { render json: { message: @merchant.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  def remove_from_chain
    respond_to do |format|
      if @merchant.remove_from_chain
        format.json { render json: { message: 'Merchant Removed from chain Successfully' }, status: :ok }
      else
        format.json { render json: { message: @merchant.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_merchant
    @merchant = Merchant.where(_id: params[:id]).first
  end

  def merchant_params
    params.require(:merchant).permit(:latitude, :longitude, :location, :chain_id)
  end
end
