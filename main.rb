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
  sql = "INSERT INTO memetube_ajax (link, title, description) VALUES ('#{params[:link]}', '#{params[:title]}', '#{params[:description]}') "
  video = run_sql(sql)
  if request.xhr?
    json video.entries.first
  end
end


# put '/videos/:id' do
#   #sequel function all cool just need to figure out id ting
#   sql = "update memetube_ajax set (link, title, description) = ('#{params[:link]}', '#{params[:title]}', '#{params[:description]}') where id = #{params[:id]}"
#   run_sql(sql)
#   if request.xhr?
#     [200, {"Content-Type" => "application/json"}, {status: :ok}]
#   end
# end









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