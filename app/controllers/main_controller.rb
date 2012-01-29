class MainController < ApplicationController
  def index
    home_note = Note.find_by_name("home_info")
    @home_info = home_note ? home_note.descr : ""
  end
  def wine
    @tag = nil
    if(params[:tag] != nil && params[:tag][:id] != nil && params[:tag][:id] != "")
      @tag = Tag.find(params[:tag][:id])
    end
    if @tag == nil
      @tag = Tag.new()
      @tag.name = ""
    end
    @tags = Tag.find(:all).map {  |t| [t.name, t.id]}
    @products = Product.salable_items(@tag.name)
    wine_note = Note.find_by_name("wine_info")
    @wine_info = wine_note ? wine_note.descr : ""
  end
  def location
    flickr_user = FlickrUser.find(FLICKR_USER_NAME)
    photosets = Photoset.by_user(flickr_user)
    # find the "Aerial View" photoset
    aerials = photosets.select {|ph| ph.title=="Aerial View"}
    @aerial_set = aerials[0] if aerials.size > 0
    @api_key = GMAP_API_KEY
  end
  def story
    story_note = Note.find_by_name("story_info")
    @story_info = story_note ? story_note.descr : ""
  end
  def events
    @events = Event.event_list
    event_note = Note.find_by_name("event_info")
    @event_info = event_note ? event_note.descr : ""
  end
  def gallery 
    @photos = nil
    @flickr_user = FlickrUser.find(FLICKR_USER_NAME)
    if params[:id]
      @photos = Photo.by_set(params[:id])
      render :template => "main/photos.rhtml"
    end
    if @photos == nil and params[:search_text]
      @photos = Photo.by_user_search(@flickr_user.id, params[:search_text])
      render :template => "main/photos.rhtml"
    end
    if @photos == nil
      @photosets = Photoset.by_user(@flickr_user)[0..50]
    end
  end
end
