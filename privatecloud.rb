require 'sinatra'
require 'sinatra/reloader'
require 'systemu'



get '/' do  
  @title = 'top'  
  @msg = 'hello!'  
  @list = `virsh list --all`
  @iplist = `bash bin/iplist.sh`

  erb :index  
end  


get '/start/:name' do | name |
  `virsh start #{name}`
   redirect '/'
end

get '/stop/:name' do | name |
  `virsh shutdown #{name}`
   redirect '/'
end

get '/forcestop/:name' do | name |
  `virsh destroy #{name}`
   redirect '/'
end

get '/create/:name' do | name |
  system("bash bin/create.sh #{name}")
   redirect '/'
end

get '/delete/:name' do | name |
  system("bash bin/trash.sh #{name}")
  redirect '/'
end
