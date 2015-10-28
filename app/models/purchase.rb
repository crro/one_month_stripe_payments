class Purchase < ActiveRecord::Base
  #Override to_param. This method is used when we
  # go and get a particular purchase and we try to get
  # that as a value, usually the to_param will return
  # the id. We are going to ask it to return a uuid instead.
  def to_param
    uuid
  end
end
