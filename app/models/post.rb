class Post < BaseDataModel

  belongs_to :channel, :class_name => 'PostChannel'
  belongs_to :source, :class_name => 'PostSource'
  belongs_to :type, :class_name => 'PostType'
  belongs_to :client

  belongs_to :author, :class_name => 'PostAuthor'

  # Tagging Engine
  has_and_belongs_to_many :classifications, :class_name => 'ClassificationRule'
  has_and_belongs_to_many :tags, :class_name => 'TagRule'

  # Static fields
  # ( Included through TimeStamps )field :created_at, :type => Date, :default => Date.today
  field :posted_date, :type => Date
  field :title, :type => String
  field :content, :type => String

  # Edited
  field :sentiment, :type => String, :default => 'neutral'
  field :status, :type => String, :default => 'untagged'

  # Optional
  field :product_name, :type => String, :default => nil
  field :rating, :type => Integer, :default => nil
  field :demographics, :type => String, :default => nil
  field :klout, :type => String, :default => nil

  # Redundant ( for unforseen analytics )
  field :original_post, :type => Object, :default => nil

  # Uniqueness
  field :custom_hash, :type => String

  ## Validations

  validates_presence_of :content, :sentiment, :posted_date
  validates_associated :author, :channel, :source, :type, :client
  validates_uniqueness_of :custom_hash

  before_save :assign_custom_hash

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
end