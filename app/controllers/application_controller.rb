# coding: utf-8 
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :check_login, :init
  layout :detect_browser


  private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
   #detect browser
  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "mobile_application" if agent.match(m)
    end
    return "application"
  end



  # Initialization
  def init
    @menus = Menu.find_all
    
    @setting = Setting.find_create
    
    @guest = { :author => session[:guest_author].to_s,:email => session[:guest_email],:url=> session[:guest_url]}

    if session[:guest_author].blank?
      if @current_user
        @guest = { :author => @current_user.name, :email => @setting.email, :url => root_url }
      else
        set_guest
      end
    end
  end
  
  def check_login
    return if session[:user_id].blank?
    @current_user = User.find_by_id(session[:user_id])
  end

  # Output404Error
  def render_404
    render(:file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404)
    return
  end
  
  # Set the main menu of the active tab
  def set_nav_actived(name = "home")
    @nav_actived = name
  end
  
  # Setting SEO Meta- Value
  def set_seo_meta(title,keywords = '',desc = '')
    if title
      @page_title =  "#{title}"
      if params[:page]
        @page_title += " &raquo; (First#{params[:page]}Page)"
      end
      @page_title += " &raquo; #{@setting.site_name}"
    else
      @page_title = @setting.site_name
    end
    @meta_keywords = keywords
    @meta_description = desc
  end
  
  # Save Review Information
  def set_guest(author = "",url = "",email = "")
    session[:guest_author] = author 
    session[:guest_url] = url
    session[:guest_email] = email
 	end
  
end
