$:.push File.expand_path("../lib", __FILE__)

require "rails_admin_become_user/version"

Gem::Specification.new do |s|
  s.name        = "rails_admin_become_user"
  s.version     = RailsAdminBecomeUser::VERSION
  s.authors     = ["Julien Vanier"]
  s.email       = ["jvanier@gmail.com"]
  s.homepage    = "https://github.com/monkbroc/rails_admin_become_user"
  s.summary     = "Rails Admin plug to sign in as a Devise user"
  s.description = "Adds a custom action to Rails Admin to because a selected user in the application."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '>= 3.2'
  s.add_dependency 'rails_admin', '>= 0.4'
end
