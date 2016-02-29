class FindOrCreateUser
  def self.call(data)
    if email = (data || {})['email']
      user = User.find_or_initialize_by(email: email)
      user.login = data['login']
      user.save
      user
    end
  end
end
