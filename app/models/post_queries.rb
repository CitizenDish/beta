module PostQueries

  DEFAULT_DATE_BEGIN = "#{Date.today.month}-01-#{Date.today.year}"
  DEFAULT_DATE_END = Date.today

  DEFAULT_DATE_RANGE = (DEFAULT_DATE_BEGIN..DEFAULT_DATE_END)

  def self.latest_posts
    criteria = latest_posts_criteria
    criteria
  end

  private
  def self.latest_posts_criteria
    Post.where(:created_at => (DEFAULT_DATE_RANGE)).where(:status => 'untagged')
  end


end