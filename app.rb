enable :sessions

helpers do
  # TODO: Put helpers here.
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/my.db")

class Text
  include DataMapper::Resource

  property :id, Serial
  property :content, Text
  property :hidden_content, Text
  property :step, Integer
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_presence_of :content

  before :update do
    updated_at = DateTime.now
  end

end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
  @texts = Text.all
  haml :index
end

get '/new' do
  haml :new
end

post '/create' do
  Text.create(params)
  redirect "/new"
end
