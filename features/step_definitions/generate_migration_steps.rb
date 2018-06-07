Given("I am outside of working directory") do
  # We needn't here to do smth because we are outside by default
end

Given("I am inside working directory") do
  run_simple "ks new working_directory"
  cd "working_directory"
end