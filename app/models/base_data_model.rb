class BaseDataModel
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


end