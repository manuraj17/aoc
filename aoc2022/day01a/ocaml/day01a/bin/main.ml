let find_max lst =
        match lst with
        | [] -> None
        | hd :: tl -> Some(List.fold_left max hd tl)

(* Not expecting this to fail *)
(*let sum_of_numbers_in_line line = int_of_string line*)

(*let sum_of_numbers_in_line line =
  try
    int_of_string line
 with Failure _ -> 0  (* Skip lines that are not valid integers *) *)


let sum_by_lines file =
  In_channel.with_open_text file (fun in_channel ->
    let rec aux acc current =
      match In_channel.input_line in_channel with
      | Some line when line = "" -> aux (current :: acc) 0  (* New group on empty line *)
      | Some line -> aux acc (current + sum_of_numbers_in_line line)  (* Summing numbers *)
      | None -> List.rev (current :: acc)  (* End of file reached *)
    in
    aux [] 0
  )

let process_file filename =
        let summed_groups = sum_by_lines filename in
        find_max summed_groups

let () = 
        let filename = "input.txt" in
        match process_file filename with
        | Some sum -> Printf.printf "%d\n" sum
        | None -> Printf.printf "List was empty"







