class BaseDataModel
  include Mongoid::Document
  include Mongoid::TimeStamps
  include Mongoid::Paranoia


end