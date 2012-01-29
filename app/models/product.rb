class Product < ActiveRecord::Base

  has_and_belongs_to_many :tags,
  :order => "name"

  #if tag_name is not nil, return the list of products
  #associated with the tag.  Otherwise return 'em all
  def self.salable_items(tag_name)
    if tag_name == nil or tag_name == ""
      find(:all)
    else
      tag = Tag.find_by_name(tag_name)
      if(tag != nil)
        tag.products
      end
    end
  end

  def validate
    if tags.blank?
      errors.add_to_base("You must specify a tag")
    end
  end

end
