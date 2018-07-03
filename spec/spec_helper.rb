require "bundler/setup"
require "ks"
require "tmpdir"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.shared_examples "temp_directory" do
  before do
    @tmp = Dir.mktmpdir
    @cwd = Dir.pwd
    Dir.chdir(@tmp)
  end

  after do
    Dir.chdir(@cwd)
    FileUtils.rm_rf(@tmp)
  end
end

RSpec.shared_examples "test_files" do
  before do
    File.write(migration_file,"some content")
    File.write(src_file,"<%= File.read(\"#{File.expand_path(migration_file)}\") %>")
  end

end