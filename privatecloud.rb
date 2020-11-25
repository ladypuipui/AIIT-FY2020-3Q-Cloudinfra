require 'sinatra'
require 'sinatra/reloader'
require 'systemu'
require 'bundler'
Bundler.require
require 'rss'


ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Keylist < ActiveRecord::Base
 validates_uniqueness_of :name
end

class Vmlist < ActiveRecord::Base
 validates_uniqueness_of :name
end

get '/' do  
  @title = 'top'  
  @msg = 'hello!'  
  @list = `virsh list --all`
  @iplist = `bash bin/iplist.sh`

  erb :index  
end  

post '/keycreate/:name' do | name |
  system("bash bin/key.sh #{name}")

  s = ""

  File.open("./resource/key/#{name}/#{name}.pub"){|f|
   s = f.read
  }

  key = Keylist.new
  key.pubkey = s
  key.name = "#{name}"
  p key.pubkey
  key.save
end

delete '/keydelete/:name' do | name |
  system("rm -rf ./resource/key/#{name}/")
  Keylist
    .where('name like ?', "#{name}")
    .delete_all
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

get '/create/' do
  erb :create
end

post '/create/confirm' do
  @vname = params[:name]
  @key = params[:key]
  @vcpu = params[:vcpu]
  @mem = params[:mem]
  @disk = params[:disk]
  @os = params[:os]

  vm = Vmlist.new
  vm.name = @vname
  vm.vcpu = @vcpu
  vm.mem = @mem
  vm.disk = @disk
  vm.sshkey = @key
  vm.os = @os
  vm.save


  File.open("env.config","w") do |file|
    file.puts "NAME="+params[:name]
    file.puts "VCPU="+params[:vcpu]
    file.puts "MEM="+params[:mem]
    file.puts "DISK="+params[:disk]
    file.puts "KEY="+params[:key]
    file.puts "OS="+params[:os]
  end

  system("bash bin/create.sh")
  redirect '/'
end

delete '/delete/:name' do | name |
  system("bash bin/trash.sh #{name}")
  redirect '/'
end
