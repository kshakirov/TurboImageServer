require 'sinatra'
require_relative 'image_server_helper'

set :bind, '0.0.0.0'
set :port, 4570
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']

configure do
  set :image_syncer, ImageSync.new(ENV['METADATA_IMAGES_COLLECTION'])
end


get '/part/:partname/product/:sku/image/:resolution' do
    send_file(settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution]), :filename => 'image', :type => 'Application/octet-stream')
end

get '/part/:partname/product/image/:resolution' do
  send_file(settings.image_syncer.get_image(params[:partname], params[:sku], params[:resolution]), :filename => 'image', :type => 'Application/octet-stream')
end

not_found do
  send_file(settings.image_syncer.get_default_image)
end


get '*' do
  'uknown route'
end