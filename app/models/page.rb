# coding: utf-8 
class Page < ActiveRecord::Base
  validates_uniqueness_of :title, :slug, :case_sensitive => false , :message => "The same name already exists,Please check re-issued a."
  before_validation :safe_slug_for_validation
  
  # status
  STATUS = [
    ["Please select the state",-1],
    ["Release",1],
    ["Draft",2],
    ].freeze
  
  private
  # before validation
  def safe_slug_for_validation
    self.slug = self.slug.safe_slug
  end
    
  # custom methods
  public
  # find list
  def self.find_list(page = 1, per_page = 20,options = {})
    with_scope :find => options do
      paginate :page => page,:per_page => per_page, :order => 'created_at desc'
    end
  end

  def self.find_show(slug)
    find_by_slug_and_status(slug,1)
  end
 
end
