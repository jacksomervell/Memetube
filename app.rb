require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'

# db setup
before do
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do
  @db.close
end

# HOME
get '/' do
  redirect to '/videos'
end

# INDEX
get '/videos' do
  sql = 'select * from videos'
  @videos = @db.exec(sql)

  erb :index
end

# NEW
get '/videos/new' do
  erb :new
end

# CREATE
post '/videos' do
  sql = "insert into videos (title, description, link) values ('#{params[:title]}', '#{params[:description]}', '#{params[:link]}' ) returning *"
  video = @db.exec(sql).first
  
  redirect to "/videos/#{video['id']}"
end

# SHOW
get '/videos/:id' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = @db.exec(sql).first

  erb :show
end

# EDIT
get '/videos/:id/edit' do
  sql = "select * from videos where id = #{params[:id]}"
  @video = @db.exec(sql).first

  erb :edit
end

# UPDATE
post '/videos/:id' do
  sql = "update videos set title = '#{params[:title]}', description = '#{params[:description]}', link = '#{params[:link]}' where id = #{params[:id]}"
  @db.exec(sql)

  redirect to "/videos/#{params['id']}"
end

# DELETE
post '/videos/:id/delete' do
  sql = "delete from videos where id = #{params[:id]}"
  @db.exec(sql)

  redirect to '/videos'
end