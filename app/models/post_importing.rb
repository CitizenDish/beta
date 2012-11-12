module PostImporting
  def self.from_datasift

  end

  private

  module DataSiftImport
    def self.parse raw_post
      begin
        json_post = JSON.parse
        post_type = json_post['interaction']['type']
        parse_method = method("parse_#{post_type}")
        parsed_post = parse_method.call json_post
        parsed_post.identify_client!
        parsed_post.original_post = json_post
        parsed_post.save
        return parsed_post
      rescue
        puts "======"
        puts "Error occured while parsing the following post:"
        puts raw_post
        puts "======"
      end
      return nil
    end

    def self.parse_tweet json_tweet
      interaction = json_tweet['interaction']
      post = Post.create :channel => PostChannel.Twitter,
        :source => PostSource.from_string(interaction['source']),
        :type => 'twitter',
        :author => PostAuthor.from_string(interaction['author']['username'] || interaction['author']['name'] rescue 'anonymous'),
        :posted_date => interaction['created_at'],
        :content => interaction['content'],
        :rating => json_tweet['salience']['content']['sentiment'].to_i,
        :klout => json_tweet['klout']
      post.title = "Tweet from #{post.author}"
    end

    def self.parse_facebook json_facebook

    end

    def self.parse_blog json_blog

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