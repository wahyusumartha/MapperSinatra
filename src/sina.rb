$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'partials'
require 'dm'

include Sinatra::Partials

get '/' do
  erb :index
end

get '/categories/new' do
  @title = "New Category"
  erb :'categories/new'
end

get '/categories/:id' do |n|
  @title = "Categories Detail"
  @category = Category.get(n)
  erb :'categories/show'
end

get '/categories' do
  @title = "Categories Index"
  @categories = Category.all
  erb :'categories/index'
end

post '/categories' do
  name = params[:name]
  begin
    @category = Category.create(
        :name => name
    )
    redirect to('/categories')
  rescue DataMapper::SaveFailureError => e
    @message = "Save Failed, Please Try Again :D " + e.to_s
    erb :'categories/new'
  end
end