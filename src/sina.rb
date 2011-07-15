$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'partials'
require 'dm'
require 'sinatra/url_for'

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
  erb :'categories/update'
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

post '/categories_update' do 
	@category = Category.get(params[:id])
	begin 
		@category.update :name => params[:name]
		redirect('/categories')
	rescue DataMapper::UpdateConflictError => e 
		@message = "Update Failed, " + e.to_s
		redirect('/categories')
	end
end

get '/delete_categories/:id' do |id|
	@category = Category.get(id)
	@category.destroy
	redirect('/categories')
end
