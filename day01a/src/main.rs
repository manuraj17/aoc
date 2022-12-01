// https://doc.rust-lang.org/rust-by-example/flow_control/if_else.html
// https://stackoverflow.com/questions/27043268/convert-a-string-to-int
// https://nickb.dev/blog/a-quick-tour-of-trade-offs-embedding-data-in-rust/

fn main() {
    // println!(
    //     "{}",
    //     include_str!("../input.txt")
    //         .lines()
    //         .map(|n| n.parse().unwrap())
    //         .collect::<Vec<u16>>()
    //         .filter(|[a, b]| a < b)
    //         .count(),
    // );
    
    let data = include_str!("../input.txt");
    let mut current_max = 0;
    let mut temp_result: i32 = 0;

    for (_i, line) in data.lines().enumerate() {
        if line == "" {
            if temp_result > current_max {
                current_max = temp_result;
            } 
            temp_result = 0;
        } else {
            temp_result += line.parse::<i32>().unwrap();
        }
    }

    println!("{}", current_max)
}


