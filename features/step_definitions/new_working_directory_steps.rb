Given("I am already inside some working directory") do
  run_simple "ks new working_directory"
  cd "working_directory"
end