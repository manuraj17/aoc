let () =
  let filename = "input.txt" in
  let result = Correct.process_file filename in
  print_endline (string_of_int result)
