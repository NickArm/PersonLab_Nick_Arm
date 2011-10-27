# coding: utf-8 
# ----------------------------------------------------
# name: pages_controller.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 
# summary:
#   CPanel Pages Controller
# ----------------------------------------------------
class Cpanel::PagesController < Cpanel::ApplicationController
  before_filter :require_login
  
  cache_sweeper :page_sweeper,:only => [:create,:update,:destory]
  
  # Page list
  def index
    @pages = Page.find_list(1)
  end  
  
  # Create a page
  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @page }
    end
  end

  
  # Modify the page
  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # Submit information page
  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        save_notice("Page created successfully,Can <a href=\"#{page_path(@page.slug)}\" target=\"_blank\">Click here</a> View.")
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Update page
  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        save_notice("Successfully modified the page,Can <a href=\"#{page_path(@page.slug)}\" target=\"_blank\">Click here</a> View.")
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deleting a page
  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      save_notice("Page has been deleted.")
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
end
