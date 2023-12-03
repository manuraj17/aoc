
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

let map_number = map_numbers

let regex_pattern_1 = Str.regexp "[1-9]"

let regex_pattern_2 = 
  let number_word_pattern = String.concat "\\|" number_words in
  Str.regexp ("[1-9]\\|" ^ number_word_pattern)

let get_first_number line regex = 
  match Str.search_forward regex line 0 with 
  | _ -> map_number (Str.matched_string line)
  | exception Not_found -> ""

let get_last_number line regex = 
  match Str.search_backward regex line (String.length line - 1) with 
  | _ -> map_number (Str.matched_string line)
  | exception Not_found -> ""

let get_first_and_last line =
  let first = get_first_number line regex_pattern_2 in
  let last = get_last_number line regex_pattern_2 in
  first ^ last

let sum_by_lines file =
  In_channel.with_open_text file (fun in_channel ->
      let rec aux acc =
        match In_channel.input_line in_channel with
        | Some line ->
          aux (get_first_and_last line :: acc)
        | None -> acc
      in
      aux [])

let process_file filename =
  let result = sum_by_lines filename in
  let sum = List.fold_left ( + ) 0 in
  let mapped = List.map (fun i -> int_of_string i) result in
  sum mapped
