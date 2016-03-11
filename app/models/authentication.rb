class Authentication < ActiveRecord::Base
  belongs_to :user, autosave: true

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  def as_json(options = {})
    { provider: provider, uid: uid }.merge(access_token_for_instagram)
  end

  private

  def access_token_for_instagram
    provider == 'instagram' ? {access_token: access_token} : {}
  end
end
