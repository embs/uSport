Rails.application.config.middleware.use OmniAuth::Builder do
  USport::Application.config.omniauth.each do |service, app_info|
    if app_info[:options]
      provider service, app_info[:app_id], app_info[:app_secret], app_info[:options]
    else
      provider service, app_info[:app_id], app_info[:app_secret]
    end
  end
end
