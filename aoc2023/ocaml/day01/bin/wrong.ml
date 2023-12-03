let number_words =
  [ "one"; "two"; "three"; "four"; "five"; "six"; "seven"; "eight"; "nine" ]

let map_numbers = function
  | "one" -> "1"
  | "two" -> "2"
  | "three" -> "3"
  | "four" -> "4"
  | "five" -> "5"
  | "six" -> "6"
  | "seven" -> "7"
  | "eight" -> "8"
  | "nine" -> "9"
  | other -> other

let get_numbers_from_line line =
  let number_word_pattern = String.concat "|" number_words in
  let regex_pattern = "(" ^ "\\d" ^ "|" ^ number_word_pattern ^ ")" in
  let re = Re2.create_exn regex_pattern in
  let matches = Re2.find_all_exn re line in
  List.map (fun x -> map_numbers x) matches

let get_first_and_last_2 list =
  let first_char = List.nth list 0 in
  let result = first_char ^ List.nth list (List.length list - 1) in
  let _ = print_endline result in
  result

let sum_by_lines_2 file = 
  In_channel.with_open_text file (fun in_channel ->
      let rec aux acc =
        match In_channel.input_line in_channel with
        | Some line ->
          aux (get_first_and_last_2 (get_numbers_from_line line) :: acc)
        | None -> acc
      in
      aux [])

let process_file filename =
  let result = sum_by_lines_2 filename in
  let _ = List.iter (fun x -> Printf.printf "%s\n" x) result in
  let sum = List.fold_left ( + ) 0 in
  let mapped = List.map (fun i -> int_of_string i) result in
  sum mapped
