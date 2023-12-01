fn get_ends(inp: &str) -> Vec<u32> {
    let mut result: Vec<u32> = Vec::new();

    let digits: Vec<&str> = inp.split('-').collect();

    result.push(digits[0].parse().unwrap());
    result.push(digits[1].parse().unwrap());

    return result;
}

fn main() {
    let data = include_str!("../input.txt");
    // let data = include_str!("../inp2.txt");
    let mut counter = 0;

    for (_i, line) in data.lines().enumerate() {
        let sections: Vec<&str> = line.split(',').collect();
        let first = get_ends(sections[0]);
        let second = get_ends(sections[1]);

        if first[0] <= second[0] && first[1] >= second[1] {
            counter += 1
        } else if second[0] <= first[0] && second[1] >= first[1] {
            counter += 1
        }
    }

    println!("{}", counter);
}
