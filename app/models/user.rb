# coding: utf-8 
require "digest/md5"
class User < ActiveRecord::Base
  validates_presence_of :uname, :pwd, :name,:message => "Can not be empty."
  
  def self.encode(pwd)
    Digest::MD5.hexdigest("--@*&^!*987-!^!*--#{pwd}")
  end
  
  def self.check_login(uname,pwd)
    find(:first, :conditions => ['uname = ? and pwd = ?', uname, pwd])
  end

  # Update Password
  def update_pwd(old_pwd,new_pwd,confirm_pwd)
    if old_pwd.blank?
      self.errors.add("Old Password","Not yet complete。")
      return false
    end

    if new_pwd.blank?
      self.errors.add("New password","Not yet complete。")
      return false
    end

    if User.encode(old_pwd) != self.pwd
      self.errors.add("Old Password","Incorrect。")
      return false
    end

    if new_pwd != confirm_pwd
      self.errors.add("New Password and Confirm Password","Different to。")
      return false
    end

    self.pwd = User.encode(new_pwd)
    if self.save
      return true
    end
  end
end
