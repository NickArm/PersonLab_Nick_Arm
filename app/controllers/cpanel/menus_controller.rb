# coding: utf-8 
# ----------------------------------------------------
# name: menus_controller.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 2009-04-16
# summary:
#   cpanel menu controller
# ----------------------------------------------------

class Cpanel::MenusController < Cpanel::ApplicationController
  before_filter :require_login
  
  cache_sweeper :menu_sweeper, :only => [:create,:update,:destroy]
  
  # GET /menus
  # GET /menus.xml
  def index
    @menus = Menu.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menus }
    end
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @menu = Menu.new

    render :action => "edit"
  end

  # GET /posts/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.xml
  def create
    @menu = Menu.new(params[:menu])

    if @menu.save
      flash[:notice] = 'Menu to create a successful.'
      redirect_to(cpanel_menus_path) 
    else
      render "edit"
    end
  end

  # PUT /menus/1
  # PUT /menus/1.xml
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        flash[:notice] = 'Successfully modified the menu.'
        format.html { redirect_to(cpanel_menus_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.xml
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to(cpanel_menus_url) }
      format.xml  { head :ok }
    end
  end
end
