class PostSource < BaseDataModel

  field :name, :type => String


  def self.from_string value
    PostSource.create :name => value
  end
end