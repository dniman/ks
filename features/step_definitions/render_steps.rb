Given("I am inside working_directory") do
  run_simple "ks new working_directory"
  cd "working_directory"
  run_simple "ks g migration create_procedure_new_proc"
end