require 'open-uri'
class ProductsController < ApplicationController
    def index
      @products = Product.all
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: @products #, except: :image
    end

    def create
      @product = Product.create!(title: params[:title], description: params[:description], price: params[:price])
      response.headers['Access-Control-Allow-Origin'] = '*'
      render json: @product.id
    end    

    def options
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'GET,HEAD,OPTIONS,POST,PUT,DELETE'
      response.headers["Access-Control-Allow-Headers"] =   "Access-Control-Allow-Origin, Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
      render status: 200
    end

    def destroy
      response.headers['Access-Control-Allow-Origin'] = '*'
      Product.find(params[:id]).destroy
      head :no_content
    end

    def update
      response.headers['Access-Control-Allow-Origin'] = '*'
      Product.update(params[:id], title: params[:title], description: params[:description], price: params[:price])
      head :no_content
    end

    def upload
      response.headers['Access-Control-Allow-Origin'] = '*'
      @product = Product.find(params[:id])
      @product.image.attach(io: URI.open(params[:image]), filename: '#{params[id]}.jpg')
    end

    def show
      response.headers['Access-Control-Allow-Origin'] = '*'
      @product = Product.find(params[:id])
      render json: Rails.application.routes.url_helpers.rails_blob_path(@product.image, only_path: true)
    end

    private

    def product_params
      params.permit(:id, :title, :description, :price, :image)
    end
    
    def set_product
      @product = Product.find(params[:id])
    end

end
