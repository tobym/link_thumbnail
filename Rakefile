require 'bundler'
Bundler::GemHelper.install_tasks

desc "Run tests"
task :test do
  $: << "test" << "lib"
  Dir.glob("test/*_test.rb").each{|file| load file}
end
