class FacebookPolicy

  def initialize auth
    @auth = auth
  end

  def first_name
    @auth.info.first_name
  end

  def last_name
    @auth.info.last_name
  end

  def email
    @auth.info.email
  end

  def username
    @auth.info.nickname
  end

  def location
    @auth.info.location
  end

  def image_url
    "http://graph.facebook.com/#{@auth.info.nickname}/picture?type=large"
  end

  def uid
    @auth.uid
  end

  def oauth_token
    @auth.credentials.token
  end

  def oauth_expires
    Time.at(@auth.credentials.expires_at)
  end

  def oauth_secret
    nil
  end

  def create_callback account
    # Place any methods you want to trigger on Facebook OAuth creation here.
  end

  def refresh_callback account
    puts '--------'
    puts account.user.id
    puts account.user.location
    puts location
    puts '--------'
    # Update user's location
    account.user.update(location:location)
  end

end