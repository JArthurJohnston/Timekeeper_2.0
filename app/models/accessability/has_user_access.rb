module HasUserAccess

  def accessable_by? user
    user.send('can_access_' + self.class.name + '?', self)
  end

end