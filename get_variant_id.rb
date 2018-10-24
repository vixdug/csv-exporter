require 'shopify_api'
require 'dotenv'
require 'json'
require 'csv'
require 'pry'
Dotenv.load

API_KEY = ENV['API_KEY']
PASSWORD = ENV['API_SECRET']
SHOP_NAME = ENC['STORE_NAME']
SHOP_URL = "https://#{API_KEY}:#{PASSWORD}@#{SHOP_NAME}.myshopify.com/admin"
ShopifyAPI::Base.site = SHOP_URL



def get_variant_ids
  products = ShopifyAPI::Product.find(:all,params: {limit: 250})
  @rows = []
  if products
    products.each do |p|
    @handle = p.handle
    @id = []    
      p.variants.each do |v|
        @id.push(v.id)
        end 
        row = [@handle, @id]
        @rows.push(row)
      end
    end 
  end 

  get_variant_ids

  CSV.open("example.csv", "wb") do | csv |
    csv << ["Handle", "Variant_id"]
   @rows.each do |r|
    csv << [r[0], r[1]]
    end 
   end 
  


# If looking for more than 250 products
# count = ShopifyAPI::Product.count
#        page = 1
#        products = []
#        while count > 0 do
#          products << ShopifyAPI::Product.find(:all, :params => {:page => page})
#          count = count - 50
#          page = page + 1
#        end
#        puts products.id



