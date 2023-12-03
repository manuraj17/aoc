let get_game_id line =
 let re = Re2.create_exn "Game (\\d+)" in
 Re2.find_first_exn ~sub:(`Index 1) re line

let is_color_valid regex line max =
 let re = Re2.create_exn regex in
 let matches = Re2.get_matches_exn re line in
 let mapped = List.map (fun x -> int_of_string(Re2.Match.get_exn ~sub:(`Index 1) x)) matches in
 let m = let rec max acc list = match list with
 | [] -> acc
 | h :: t -> if acc > h then max acc t else max h t
in
max 0 mapped in
m <= max

let is_blue_valid line max = is_color_valid "(\\d+) blue" line max
let is_red_valid line max = is_color_valid "(\\d+) red" line max
let is_green_valid line max = is_color_valid "(\\d+) green" line max

let is_game_valid line =
  is_blue_valid line 14 && is_green_valid line 13 && is_red_valid line 12

let solve line =
  let v = is_game_valid line in
  if v then int_of_string (get_game_id line) else 0

let sum = List.fold_left (+) 0

let process_file filename =
  let result = In_channel.with_open_text filename (fun ic ->
      let rec aux acc =
        match In_channel.input_line ic with
        | Some line -> aux (solve line :: acc)
        | None -> acc
      in
      aux []) in
      sum result
