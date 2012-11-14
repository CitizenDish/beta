class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :channel, :class_name => 'PostChannel'
  belongs_to :source, :class_name => 'PostSource'
  belongs_to :type, :class_name => 'PostType'
  belongs_to :client

  belongs_to :author, :class_name => 'PostAuthor'

  # Tagging Engine
  has_and_belongs_to_many :tags, :class_name => 'TagRule'

  # Static fields
  # ( Included through TimeStamps )field :created_at, :type => Date, :default => Date.today
  field :posted_date, :type => Date
  field :title, :type => String
  field :content, :type => String
  field :web_address, :type => String

  # Edited
  field :status, :type => String, :default => 'untagged'
  has_and_belongs_to_many :classifications, :class_name => 'ClassificationRule'

  # Optional
  field :product_name, :type => String, :default => nil
  field :rating, :type => Integer, :default => 0
  field :demographics, :type => String, :default => nil
  field :klout, :type => String, :default => nil

  # Redundant ( for unforseen analytics )
  field :original_post, :type => Object, :default => nil

  # Uniqueness
  field :custom_hash, :type => String

  ## Validations

  validates_presence_of :content, :sentiment, :posted_date, :web_address
  validates_numericality_of :rating
  validates_associated :author, :channel, :source, :type, :client
  validates_uniqueness_of :custom_hash

  before_save :downcase_fields!, :assign_custom_hash

  def downcase_fields!
    @content = content.downcase
    @title = title.downcase
    @product_name = title.downcase
  end

  def identify_client!
    clients = Client.all
    clients.each do |c|
      name = c[:name].downcase
      self.client = c if content_or_title_includes?(name)
    end
  end

  def sentiment
    sentiment_value = if rating < 0 then 'negative'
    elsif rating > 0 then 'positive'
    else 'neutral' end
  end

  def assign_custom_hash
    @custom_hash = generate_custom_hash
  end

  def generate_custom_hash
    hash_object = Hash.new
    hash_object[:author] = author
    hash_object[:title] = title
    hash_object[:content] = content
    hash_object[:date] = posted_date
  end

  private
  def content_or_title_includes? value
    content_inlcudes?(value) || title_includes?(value)
  end

  def content_includes? value
    content.include? value
  end

  def title_includes? value
    title.include? value
  end

end