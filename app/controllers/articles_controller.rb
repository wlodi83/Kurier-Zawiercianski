class ArticlesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show, :search, :pdf, :display_big_photo, :rss]
  layout :choose_layout
  def rss
    @articles = Article.find(:all, :conditions => ["published = ?", true], :order => "id DESC", :limit => 10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  uses_tiny_mce :options => {
                              :theme => 'advanced',
                              :relative_urls => false,
                              :theme_advanced_resizing => true,
                              :mode => "textareas",
                              :theme_advanced_resize_horizontal => false,
                              :theme_advanced_buttons2 => %w{formatselect fontselect fontsizeselect bold italic underline strikethrough separator justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink image undo redo code},
                              :width => "482",
                              :height  => "600",
                              :plugins => %w{ contextmenu paste table fullscreen }
  }                         

  def index
    if params[:category_id]
      @articles_pages, @articles = paginate(:articles,
      :include => :user,
      :order => 'published_at DESC',
      :conditions => ["category_id = ? AND published = ?", params[:category_id].to_i, true])
    else
      @articles = Article.find_all_by_published(true)
      @articles_pages, @articles = paginate(:articles,
       :include => :user,
       :order => 'published_at DESC',
       :conditions => ["published = ?", true])
    end
    respond_to do |wants|
      wants.html
      wants.xml  {render :xml => @articles.to_xml }
      wants.rss { render :action => 'rss.xml', :layout => false }
      wants.atom { render :action => 'atom.rxml', :layout => false }
    end
  end
  
  def show
    if is_logged_in? && @logged_in_user.has_role?('Editor')
      @article = Article.find(params[:id])
    else
      @article = Article.find_by_id_and_published(params[:id], true)
    end
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @article.to_xml }
    end
  end
  
  def search
    params[:q] = params[:q].gsub(/--{2,}/, '-')
    page  = params[:page] || 1 
    @search = Ultrasphinx::Search.new(:query => params[:q],
                                      :page => page,
                                      :per_page => 25)
    @search.run
    @articles = @search.results
    respond_to do |format|
      format.html # search.html.erb
    end
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article])
    @logged_in_user.articles << @article 
    if @article.save 
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :xml => @articles.to_xml }
    end
    else
      render :action => :new    
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :xml => @article.to_xml }  
    end
    else
      redirect_to admin_articles_url
      flash[:error] = "Do not save this article!"
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :nothing => true }
    end
  end

  def admin
    @articles_pages, @articles = paginate(:articles, :order => 'published_at DESC')
  end
  
private
def choose_layout
  if['show'].include? action_name
    'article_layout'
  else
    'application'
  end
end  

end