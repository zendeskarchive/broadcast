source "http://rubygems.org"

gemspec :name => 'broadcast'

group :development, :test do
  gem 'rake', '0.8.7'
  gem 'rspec'

  platforms :mri_18 do
    gem 'rcov'
    gem "ruby-debug"
  end

  platforms :mri_19 do
    gem 'rcov'
    gem "ruby-debug19"
  end
end
