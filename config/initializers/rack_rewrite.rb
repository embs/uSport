USport::Application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  if Rails.env.production?
    r301 /.*/,  
      Proc.new { |path, rack_env| "http://www.#{rack_env['SERVER_NAME']}#{path}" },
      if: Proc.new { |rack_env| ! (rack_env['SERVER_NAME'] =~ /www\./i)}
  end
end
