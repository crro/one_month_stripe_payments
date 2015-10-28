class ChargesController < ApplicationController
  def create
    product = Product.find_by_sku("GROHACK1")

    customer = Stripe::Customer.create(
      #We want to get the email from the form
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => product.price_in_cents,
      :description => 'Growth Hacking Crash Course',
      :currency    => 'usd'
    )

    # Now we want to show the purchase
    # using amount is not a good idea. They could change the amount
    # Not good practice to pass the amount you are charging in a form field
    # This is saved in the database
    purchase = Purchase.create(email: params[:stripeEmail],
      card: params[:stripeToken], amount: product.price_in_cents,
      description: charge.description, currency: charge.currency,
      customer_id: customer.id, product_id: product.id, uuid: SecureRandom.uuid)

    # This is a little bit of Rails magic.
    # Redirect to show the purchase based upon
    # whatever the id of this new purchase we've created is.
    # I belive this is also the same as path_to(purchase)
    redirect_to purchase

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
