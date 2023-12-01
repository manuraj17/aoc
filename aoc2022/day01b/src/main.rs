// https://stackoverflow.com/questions/60916194/how-to-sort-a-vector-in-descending-order-in-rust

fn main() {
    let data = include_str!("../input.txt");
    // let data = include_str!("../inp2.txt");
    let mut calories : Vec<i32> = Vec::new();
    let mut temp_result: i32 = 0;

    for (_i, line) in data.lines().enumerate() {
        if line == "" {
            calories.push(temp_result);
            temp_result = 0;
        } else {
            temp_result += line.parse::<i32>().unwrap();
        }
    }

    println!("{:?}", calories);
    calories.sort();
    calories.reverse();
    println!("{:?}", calories);
    let total: i32 = calories.iter().take(3).into_iter().sum();

    println!("{}", total)
}


