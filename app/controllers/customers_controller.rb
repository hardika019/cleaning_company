class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @cities = @customer.try(:cities)
    @cleaners = @cities.present? && @cities.map(&:cleaners).flatten.present? ? @cities.map(&:cleaners).flatten.map(&:first_name).join(',') : 'No cleaners are available in your area'
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @cities   = City.all
    booking = @customer.bookings.build
  end

  # GET /customers/1/edit
  def edit
    @cities   = City.all
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.find_by(phone_number: params[:customer][:phone_number])
    if @customer.present?
      @customer.update_attributes(customer_params)
    else
      @customer = Customer.new(customer_params)
    end
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        @cities   = City.all
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :phone_number, bookings_attributes: [:id, :customer_id, :city_id, :date, :_destroy])
    end
end
