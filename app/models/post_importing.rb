module PostImporting
  def self.import raw_post, type
    import_module = if type == 'datasift' then DataSiftImport
                    elsif type == 'customer review' then CustomerReviewImport
                    else raise UndefinedTaskError end
    begin
      parsed_post = import_module.parse raw_post
      parsed_post.identify_client!
      parsed_post.original_post = raw_post
      parsed_post.save
      parsed_post
    rescue
      puts "====== Error ======"
      puts "Error occured while parsing the following post:"
      puts raw_post
      puts "====== ----- ======="
    end
  end

  private

  module DataSiftImport
    def self.parse raw_post
      json_post = JSON.parse raw_post
      post_type = json_post['interaction']['type']
      parse_method = method("parse_#{post_type}")
      parsed_post = parse_method.call json_post
      parsed_post.demographics = json_post['demographics'] unless json_post['demographics'].nil?
      return parsed_post
    end

    def self.parse_tweet json_tweet
      interaction = json_tweet['interaction']
      post = Post.create :channel => PostChannel.Twitter,
        :source => PostSource.from_string(interaction['source']),
        :type => 'twitter',
        :author => PostAuthor.from_string(interaction['author']['username'] || interaction['author']['name']),
        :posted_date => interaction['created_at'],
        :content => interaction['content'],
        :rating => json_tweet['salience']['content']['sentiment'].to_i,
        :link => interaction['link'] || interaction['author']['link'],
        :klout => json_tweet['klout']
      post.title = "Tweet from #{post.author.name}"
    end


    "{'interaction': { 'source': 'facebook', 'type': 'facebook', 'author': { 'username': 'test_user' }, 'created_at': "
    def self.parse_facebook json_facebook
      interaction = json_facebook['interaction']
      post = Post.create :channel => PostChannel.Twitter,
                         :source => PostSource.from_string(interaction['source']),
                         :type => 'facebook',
                         :author => PostAuthor.from_string(interaction['author']['username'] || interaction['author']['name']),
                         :posted_date => interaction['created_at'],
                         :content => interaction['content'],
                         :rating => (json_facebook['salience']['content']['sentiment'] || json_facebook['salience']['title']['sentiment']).to_i,
                         :link => interaction['link'] || interaction['author']['link']
      post.title = interaction['title'] || "Facebook post from #{post.author.name}"
    end

    def self.parse_blog json_blog
      interaction = json_blog['interaction']
      post = Post.create :channel => PostChannel.Twitter,
                         :source => PostSource.from_string(interaction['source']),
                         :type => 'blog',
                         :author => PostAuthor.from_string(interaction['author']['username'] || interaction['author']['name']),
                         :posted_date => interaction['created_at'],
                         :content => interaction['content'],
                         :rating => (json_blog['salience']['content']['sentiment'] || json_blog['salience']['title']['sentiment']).to_i,
                         :link => interaction['link'] || interaction['domain']
      post.title = interaction['title'] || "Blog post from #{post.author.name}"
    end

    def self.parse_news json_news
      raise UndefinedTaskError
    end
  end

  module CustomerReviewImport
    def self.parse review
      host = review['host']
      product_name = review['product_name']
      rating = review['rating']
      converted_rating = rating == 3? 0 : rating < 3 ? -10 : 10

      Post.create :channel => PostChannel.CustomerReview,
                  :source => PostSource.from_string(host['name']),
                  :type => 'customer review',
                  :author => PostAuthor.from_string(review['author'] || 'anonymous'),
                  :posted_date => review['date'].to_date,
                  :content => review['content'],
                  :rating => converted_rating,
                  :title => product_name,
                  :link => review['web_address']
    end
  end
end