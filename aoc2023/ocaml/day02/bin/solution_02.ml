let get_game_id line =
  let re = Re2.create_exn "Game (\\d+)" in
  Re2.find_first_exn ~sub:(`Index 1) re line

 let min_color regex line =
  let re = Re2.create_exn regex in
  let matches = Re2.get_matches_exn re line in
  let mapped = List.map (fun x -> int_of_string(Re2.Match.get_exn ~sub:(`Index 1) x)) matches in
  let m = let rec max acc list = match list with
  | [] -> acc
  | h :: t -> if acc > h then max acc t else max h t
 in
 max 0 mapped in
 m

 let min_blue line = min_color "(\\d+) blue" line
 let min_red line = min_color "(\\d+) red" line
 let min_green line = min_color "(\\d+) green" line
 let game_score line = min_blue line * min_green line * min_red line
 let solve line = game_score line
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
