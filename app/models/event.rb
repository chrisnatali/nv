class Event < ActiveRecord::Base
        validates_presence_of :name, :descr
        validates_uniqueness_of :name

        def self.event_list
                find(:all,
                     :conditions => ["date >= ?", Date.today],
                     :order => "date asc")
        end
end
