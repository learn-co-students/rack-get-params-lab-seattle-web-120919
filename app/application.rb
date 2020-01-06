class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
  
    elsif req.path.match(/add/)
        search_item = req.params["item"]
        resp.write search_cart(search_item)
    elsif req.path.match(/cart/)
      if !@@cart.empty? 
        @@cart.each do |item|
        resp.write "#{item}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    else 
      resp.write "Path Not Found"
    end

  # Create a new route called /cart to show the items in your cart
  # Create a new route called /add that takes in a GET param with the key item. 
  # This should check to see if that item is in @@items and then 
  # add it to the cart if it is. Otherwise give an error
    # if req.path.match(/add/)
    #   search_item = req.params["item"]
    #   resp.write search_cart(search_item)

    # elsif req.path.match(/cart/)
    #   @@cart.each do |item|
    #   resp.write "#{item}\n"
    #   end
    # elsif @@cart.empty?
    #   resp.write "Your cart is empty"
    # end

    resp.finish
  end

  def search_cart(search_item)
    if @@items.include?(search_item)
      @@cart << search_item
      return "added #{search_item}"
    else 
      return "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
