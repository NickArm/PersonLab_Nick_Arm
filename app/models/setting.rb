# coding: utf-8 
class Setting < ActiveRecord::Base
  
  def self.find_create
    @setting = Rails.cache.read("models/setting1")
    if @setting.blank?
      @setting = first
      if not @setting
        @setting = new(:site_name => "PersonLab Demo", :sub_title => "This is an person website build by Ruby on Rails.", 
          :meta_keywords => "personlab,ruby on rails", 
          :email => "armenisnick@hotmail.com",
          :meta_description => "This is an person website build by Ruby on Rails.",
          :twitter_id => "Nick_Arm",
          :google_reader_id => "0222555585204047777",
          :home_show => '')
        @setting.save
      end
      Rails.cache.write("models/setting",@setting)
    end
    return @setting
  end
end
