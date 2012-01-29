class Tag < ActiveRecord::Base

        has_and_belongs_to_many :products,
                                :order => "price"

        def find_by_name(name)
                find(:all,
                     :conditions => "name = " + name)
        end

        def find_all_names()
                names = []
                for tag in find(:all)
                        names << tag.name
                end
                names
        end
end
