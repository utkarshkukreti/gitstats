require 'bundler'
Bundler::GemHelper.install_tasks

namespace :spec do
  task :prepare do
    require 'fileutils'
    destination = File.expand_path(File.join(File.dirname(__FILE__), 'spec', 'fixtures', 'repository'))
    url = "https://github.com/jquery/jquery.git"
    FileUtils.mkdir_p(destination)
    puts "Fetching jQuery repository into spec/fixtures/repository"
    system "cd #{destination} && git clone #{url} . && git checkout 1.6.1"
  end
end
