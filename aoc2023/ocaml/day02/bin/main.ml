let () =
    let filename = "input.txt" in
    let result_1 = Solution_01.process_file filename in
    let result_2 = Solution_02.process_file filename in
    let _ = Printf.printf "\nSol 1: %d\n" result_1 in
    Printf.printf "Sol 2: %d\n" result_2
