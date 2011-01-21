# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yes_no(bool)
    if bool == true
      "tak"
    else
      "nie"
    end
  end
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def wydarzenia_partial
     render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Wydarzenia') and published=#{true} order by published_at DESC limit 10 offset 1")) 
  end
  def wydarzenia_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Wydarzenia') and published=#{true} order by published_at DESC limit 1")) 
  end
  def polityka_partial
     render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Polityka') and published=#{true} order by published_at DESC limit 10 offset 1"))
  end
  def polityka_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Polityka') and published=#{true} order by published_at DESC limit 1"))
  end
  def kultura_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kultura') and published=#{true} order by published_at DESC limit 10 offset 1"))
  end
  def kultura_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kultura') and published=#{true} order by published_at DESC limit 1"))
  end
  def sport_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Sport') and published=#{true} order by published_at DESC limit 10 offset 1"))
  end
  def sport_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Sport') and published=#{true} order by published_at DESC limit 1"))
  end
  def gospodarka_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Gospodarka') order by published_at DESC limit 10 offset 1"))
  end
  def gospodarka_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Gospodarka') and published=#{true} order by published_at DESC limit 1"))
  end
  def co_gdzie_kiedy_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Co? Gdzie? Kiedy?') and published=#{true} order by published_at DESC limit 10 offset 1"))
  end
  def co_gdzie_kiedy_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Co? Gdzie? Kiedy?') and published=#{true} order by published_at DESC limit 1"))
  end
  def oswiata_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Oświata') and published=#{true} order by published_at DESC limit 10 offset 1"))
  end
  def oswiata_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Oświata') and published=#{true} order by published_at DESC limit 1"))
  end
  def kategorie_partial
     render(:partial => "layouts/category", :collection => Category.find(:all, :conditions => ["parent_id is null"]))
  end
  
  def kategorie_partial_main
     render(:partial => "layouts/category_main", :collection => Category.find(:all, :conditions => ["parent_id is null"]))
  end
  
  def articles_scroll_partial
    render(:partial => "articles/articles_scroll", :collection => Article.find(:all,:conditions => ['published=?', true],:order => "published_at DESC", :limit => 6))
  end
  
  def articles_scroll_partial_thumbnails_first
    render(:partial => "articles/articles_scroll_thumbnails_first", :collection => Article.find(:all, :conditions => ['published=?', true], :order => "published_at DESC", :limit => 1))
  end
  
  def articles_scroll_partial_thumbnails
    render(:partial => "articles/articles_scroll_thumbnails", :collection => Article.find_by_sql("select * from articles where published = true AND id != (select id from articles ORDER BY published_at DESC LIMIT 1) ORDER BY published_at DESC LIMIT 5;"))
  end
  
#  def articles_display_partial
#    render(:partial => "articles/articles_display", :collection => Article.find_by_sql("select * from articles where published = true AND id != (select id from articles ORDER BY published_at DESC LIMIT 1) ORDER BY published_at DESC LIMIT 10;"))
#  end
#  
end
