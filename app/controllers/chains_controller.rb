class ChainsController < ApplicationController

  before_action :load_chain, only: [:show, :update, :remove_merchant]

  skip_before_action :verify_authenticity_token, only: [:remove_merchant, :create]

  # get all chains
  #
  #
  def index
    respond_to do |format|
      format.html
      format.json { render json: { chains: Chain.all.as_json } }
    end
  end

  # get chain with all merchants
  #
  #
  def show
    respond_to do |format|
      format.html
      format.json { render json: { chain: @chain.as_json(methods: [:merchants]) } }
    end
  end

  def new;end

  def create
    @chain = Chain.new(chain_params)
    @chain.merchants << Merchant.new(params[:chain][:merchant])
    respond_to do |format|
      if @chain.save
        format.json { render json: { message: 'Chain created Successfully' }, status: :ok }
      else
        format.json { render json: { message: @chain.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @chain.active = params[:active]
    respond_to do |format|
      if @chain.save
        format.json { render json: { message: 'Chain updated Successfully' }, status: :ok }
      else
        format.json { render json: { message: @chain.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  def remove_merchant
    merchant  = @chain.merchants.find(params[:merchant_id])
    respond_to do |format|
      if merchant.remove_from_chain
        format.json { render json: { message: 'Merchant Removed from chain Successfully' }, status: :ok }
      else
        format.json { render json: { message: merchant.errors.full_messages.join(',') }, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_chain
    @chain = Chain.where(_id: params[:id]).first
  end

  def chain_params
    params.require(:chain).permit(:name, merchant_attributes: %i[latitude longitude location])
  end
end
