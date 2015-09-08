require 'sinatra'
require 'sinatra/contrib/all'
require 'json'
require 'pg'
require 'pry'

#HOME
get '/' do
  redirect to('/videos')
end

#INDEX
get '/videos' do
  #send back all items in the DB
  sql = "select * from memetube_ajax"
  @videos = run_sql(sql)

  if request.xhr?
    json @videos.entries
    #entries  is same as json @items.to_a
  else
    erb :index
  end
end

post '/videos' do
  #the values will be the value of link input box and the value of title input box
  sql = "INSERT INTO memetube_ajax (link, title) VALUES ('#{params[:link]}', '#{params[:title]}') "
  video = run_sql(sql)
  if request.xhr?
    json video.entries.first
  end
end










private
def run_sql(sql)
  conn = PG.connect(:dbname =>'memetube_ajax', :host => 'localhost')
  begin
    result = conn.exec(sql)
  ensure
    conn.close
  end

  result
end