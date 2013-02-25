class PostChannel < BaseDataModel

  def method_missing name, *args
    channel = PostChannel.where(:name => name.downcase).first
    if channel.nil? then super
    else
      PostChannel.class_eval do
        define_method name do
        end
      end
    end
  end


end