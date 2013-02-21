def set_omniauth
  user_hash = {
    :nickname => 'mikemyers',
    :email => 'mike@villains.com',
    :name => 'Michael Myers',
    :first_name => 'Michael',
    :last_name => 'Myers',
    :gender => 'Male'
  }

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
    'uid' => '12345',
    'provider' => 'facebook',
    'info' => {
      'nickname' => user_hash[:nickname],
      'email' => user_hash[:email],
      'name' => "#{user_hash[:first_name]} #{user_hash[:last_name]}",
      'first_name' => user_hash[:first_name],
      'last_name' => user_hash[:last_name]
    },
    'extra' => {
      'raw_info' => {
        'email' => user_hash[:email],
        'first_name' => user_hash[:first_name],
        'last_name' => user_hash[:last_name],
        'gender' => user_hash[:gender]
      }
    }
  }
end

def set_invalid_omniauth(opts = {})
  credentials = { :provider => :facebook,
                  :invalid  => :invalid_crendentials
                 }.merge(opts)

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
end
