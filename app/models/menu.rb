# coding: utf-8 
class Menu < ActiveRecord::Base
  validates_presence_of :name,:url, :message => "Can not be empty"
  validates_uniqueness_of :name,:case_sensitive => false, :message => "The same name already exists."
  
  
  def self.find_all
    Rails.cache.fetch("data/menus") { 
      find(:all,:order => "sort desc") 
    }    
  end
  
end
