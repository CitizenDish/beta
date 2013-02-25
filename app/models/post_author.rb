class PostAuthor < BaseDataModel

  field :name, :type => String


  def self.from_string value
    PostAuthor.create :name => value
  end
end