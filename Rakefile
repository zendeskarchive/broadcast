require 'rubygems'
require 'bundler/setup'

require 'bundler'

Bundler::GemHelper.install_tasks

import "lib/broadcast/tasks/broadcast.rake"

begin

  require 'rspec'
  require "rspec/core/rake_task"

  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_path = 'bin/rspec'
    t.rspec_opts = %w[--color]
    t.verbose = false
  end

  task :default => [:spec]

rescue
  puts 'Could not load Broadcast RSpec Rake tasks'
end

begin

  namespace :spec do

    task :cleanup do
      rm_rf 'coverage.data'
    end

    RSpec::Core::RakeTask.new :rcov do |t|
      t.rcov = true
      t.rcov_opts =  %[-Ilib -Ispec --exclude "gems/*,features"]
      t.verbose = false
    end

  end

rescue
  puts 'Could not load Broadcast RSpec Rcov Rake tasks'
end
