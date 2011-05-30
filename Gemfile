source "http://rubygems.org"

gemspec

group :development, :test do
  gem 'rake', '0.8.7'
  gem 'rspec'
  gem 'rcov'

  platforms :mri_18 do
    gem "ruby-debug"
  end

  platforms :mri_19 do
    gem "ruby-debug19"
  end
end
