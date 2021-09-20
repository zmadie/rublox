# frozen_string_literal: true

require "rake"

desc "run rubocop"
task :rubocop do
  system "rubocop"
end

desc "run tests"
task :test do
  system "ruby -I ./lib ./tests/run_tests.rb"
end

desc "build docs"
task :docs do
  system "yardoc"
end

desc "build docs, showing private objects"
task :docs_priv do
  system "yardoc --private"
end

desc "open local server to live preview docs"
task :doc_server do
  system "yard server --reload"
end

desc "list all undocumented objects"
task :list_undoc do
  system "yard stats --list-undoc"
end
