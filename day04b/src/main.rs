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

        let first_range: Vec<u32> = (first[0]..=first[1]).collect();

        if first_range.contains(&second[0]) || first_range.contains(&second[1]) {
            println!("{:?}", first_range);
            counter += 1;
            continue;
        }

        let second_range: Vec<u32> = (second[0]..=second[1]).collect();
        if second_range.contains(&first[0]) || second_range.contains(&first[1]) {
            println!("{:?}", second_range);
            counter += 1;
            continue;
        }
    }

    println!("{}", counter);
}
