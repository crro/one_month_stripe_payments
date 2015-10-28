class ChargesController < ApplicationController
  def create

    customer = Stripe::Customer.create(
      #We want to get the email from the form
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => params[:amount],
      :description => 'Growth Hacking Crash Course',
      :currency    => 'usd'
    )

    #Now we want to show the purchase
    purchase = Purchase.create(email: params[:stripeEmail],
      card: params[:stripeToken], amount: params[:amount],
      description: charge.description, currency: charge.currency,
      customer_id: customer.id, product_id: 1, uuid: SecureRandom.uuid)

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
