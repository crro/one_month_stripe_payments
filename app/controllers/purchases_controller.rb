class PurchasesController < ApplicationController
  # This are the actions in the controller or method
  def show
    # This variable is accessible in the view as well
    # this will find it based on an id that is passed in
    @purchase = Purchase.find_by_uuid(params[:id])
    # We are finding the product with that id
    @product = Product.find(@purchase.product_id)
  end
end
