# frozen_string_literal: true

require "rake"
require "rubocop/rake_task"
require "yard"

RuboCop::RakeTask.new

desc "build docs"
YARD::Rake::YardocTask.new do |task|
	task.name = "build_docs"
end

desc "open local server to live preview docs"
task :server do
	puts "go to http://localhost:8808 to view the docs"
	server = YARD::CLI::Server.new
	server.options.update(incremental: true)
	server.run
end

desc "list all undocumented objects"
task :list_undoc do
	YARD::CLI::Stats.new.run("--list-undoc")
end
