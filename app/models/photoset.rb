require 'net/http'
require 'rexml/document'
require 'flickr_helper'

class Photoset
  include FlickrAware
  
  attr_accessor :id, :photos_num, :title, :description
  attr_accessor :primary, :farm, :server, :secret # required to create the thumbnails id
  
  def Photoset.find(photoset_id)
    d = FlickrAware.invoke("flickr.photosets.getInfo", :photoset_id => photoset_id)
    if d
      p = self.from_xml(d.root.get_elements("//photoset")[0])
      return p
    end
    return nil
  end
  
  def Photoset.by_user(user)
    d = FlickrAware.invoke("flickr.photosets.getList", :user_id => user.id)
    if d
      user.photosets = []
      d.root.get_elements("//photoset").each do |photoset|
        p = self.from_xml(photoset)        
        user.photosets << p
      end
      
      return user.photosets
    end
    return nil
  end
  
  def Photoset.from_xml(photoset_element)
    p = Photoset.new
    p.id = photoset_element.attributes["id"]
    p.photos_num = photoset_element.attributes["photos"]
    
    p.primary = photoset_element.attributes["primary"]
    p.farm = photoset_element.attributes["farm"]
    p.server = photoset_element.attributes["server"]
    p.secret = photoset_element.attributes["secret"]
    
    titles = photoset_element.get_elements("title")
    if titles && titles.length > 0
      p.title = titles[0].get_text
    end
    
    descriptions = photoset_element.get_elements("description")
    if descriptions && descriptions.length > 0
      p.description = descriptions[0].get_text
    end   
    
    return p 
  end
    
  # To render the links properly
  def to_s
    @id
  end
  
  def thumb_link
    "http://farm#{farm}.static.flickr.com/#{server}/#{primary}_#{secret}_s.jpg"
  end
  
  def thumb_link_medium
    "http://farm#{farm}.static.flickr.com/#{server}/#{primary}_#{secret}_m.jpg"
  end
end
