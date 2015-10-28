class PurchasesController < ApplicationController
  # This are the actions in the controller or method
  def show
    # This variable is accessible in the view as well
    # this will find it based on an id that is passed in
    @purchase = Purchase.find(params[:id])
  end
end
