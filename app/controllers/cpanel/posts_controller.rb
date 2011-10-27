# coding: utf-8 
class Cpanel::PostsController < Cpanel::ApplicationController
  cache_sweeper :post_sweeper,:only => [:create,:update,:destroy]
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.paginate(:page => params[:page], :include => [:category])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        save_notice("Article to create a successful,Can <a href=\"#{blog_path(@post.slug)}\" target=\"_blank\">Click here</a> View")
        format.html { redirect_to :controller => "posts", :action => "index" }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        logger.debug { "post_update" }
        save_notice("Successfully modified the article,Can <a href=\"#{blog_path(@post.slug)}\" target=\"_blank\">Click here</a> View")
        format.html { redirect_to :controller => "posts", :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      save_notice("Posts deleted successfully.")
      format.html { redirect_to(cpanel_posts_url) }
      format.xml  { head :ok }
    end
  end
end
