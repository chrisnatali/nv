require "digest/sha1"

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :password, :descr, :role

  validates_uniqueness_of :name
  validates_presence_of :name, :password

  def before_create
    self.hashed_pwd = User.hash_pwd(self.password)
  end

  def after_create
    @password = nil
  end

  def before_update
    self.hashed_pwd = User.hash_pwd(self.password)
  end

  def after_update
    @password = nil
  end

  def self.hash_pwd(password)
    Digest::SHA1.hexdigest(password)
  end

  def self.login(name, password)
    hashed_password = hash_pwd(password || "")
    find(:first,
         :conditions => ["name = ? and hashed_pwd = ?",
                         name, hashed_password])
  end

  def try_to_login
    User.login(self.name, self.password)
  end
end
