class CartsController < ApplicationController
  before_action :set_cart

  # POST /cart Payload:
  def add_product
    product = Product.find(params[:product_id])
    return render json: { error: 'Produto não encontrado' }, status: :not_found unless product

    cart_item = @cart.cart_items.find_by(product_id: product.id)

    if cart_item
      cart_item.update!(quantity: cart_item.quantity + 1)
    else
      @cart.cart_items.create!(product: product)
    end

    @cart.update_total_price
    render json: cart_payload(@cart)
  end

  # GET /cart
  def show
    render json: cart_payload(@cart)
  end

  # PATCH /cart/add_item
  def update_product_quantity
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    return render json: { error: 'Produto não está no carrinho' }, status: :not_found unless cart_item

    cart_item.update!(quantity: params[:quantity].to_i)
    @cart.update_total_price
    render json: cart_payload(@cart)
  end

  # DELETE /cart/:product_id
  def remove_product
    cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    return render json: { error: 'Produto não está no carrinho' }, status: :not_found unless cart_item

    cart_item.destroy
    @cart.update_total_price
    render json: cart_payload(@cart)
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def cart_payload(cart)
    {
      id: cart.id,
      products: cart.cart_items.map do |item|
        {
          id: item.product_id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.product.price,
          total_price: item.quantity * item.product.price
        }
      end,
      total_price: cart.total_price
    }
  end
end
