require 'data_mapper'
require 'logger'

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup(:default, {
    :adapter => 'mysql',
    :host => 'localhost',
    :username => 'root',
    :password => 'localhost',
    :database => 'dmtest'})


class Post
  include DataMapper::Resource

  belongs_to :category
  has n, :comment
  property :id, Serial # An auto-increment integer key
  property :title, String # A varchar type string, for short strings
  property :body, Text # A text block, for longer string data.
  property :created_at, DateTime # A DateTime, for any date you might like.
end

class Comment
  include DataMapper::Resource

  belongs_to :post
  property :id, Serial
  property :posted_by, String
  property :email, String
  property :url, String
  property :body, Text
end

class Category
  include DataMapper::Resource

  has n, :post
  property :id, Serial
  property :name, String, :required => true
end

DataMapper::Model.raise_on_save_failure = true
DataMapper.finalize

Category.auto_migrate! unless Category.storage_exists?
Post.auto_migrate! unless Post.storage_exists?
Comment.auto_migrate! unless Comment.storage_exists?
