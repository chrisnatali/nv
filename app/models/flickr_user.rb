require 'net/http'
require 'rexml/document'
require 'flickr_helper'

class FlickrUser
  include FlickrAware
  
  attr_accessor :id, :username, :photosets
  
  def FlickrUser.find_by_nsid(nsid)
    f = FlickrUser.new(:id => nsid)
    if f.populate
      f
    else
      nil
    end
  end
  
  def FlickrUser.find(username)
    f = FlickrUser.new(:username => username)
    if f.populate
      f
    else
      nil
    end
  end
  
  def initialize(params = {})
    @photosets = []
    @username = params[:username]
    @id = params[:id]
  end
  
  def populate
    if @id
      d = FlickrAware.invoke("flickr.people.getInfo", :user_id => @id)
      if d
        flickr_user_name = d.root.get_elements("//username")[0].get_text
        @username = flickr_user_name
      else
        false
      end
    else
      d = FlickrAware.invoke("flickr.people.findByUsername", :username => @username)
      if d
        flickr_user_id = d.root.get_elements("//user")[0].attributes["id"]
        @id = flickr_user_id
        true
      else
        false
      end
    end    
  end
  
  # To render the links properly
  def to_s
    if( @username ) 
     @username
    else
     ""
    end
  end
end
