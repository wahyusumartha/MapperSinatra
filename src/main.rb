require 'rubygems'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'dm'


begin
  @category = Category.create(
      :name => "Sumpe Loh"
  )

  @post = Post.create(
      :title => "My first DataMapper post",
      :body => "A lot of text ...",
      :created_at => Time.now,
      :category => @category
  )
  printf 'save Success'
rescue DataMapper::SaveFailureError
  printf 'save Failed '
end

