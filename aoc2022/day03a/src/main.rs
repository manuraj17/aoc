use std::collections::HashMap;

fn main() {
    println!("Hello, world!");

    let data = include_str!("../input.txt");
    // let data = include_str!("../inp2.txt");
    let mut current_total: i32 = 0;

    for (_i, line) in data.lines().enumerate() {
        let length = line.len();
        // let mut items_map = HashMap::new();
        let (first_container, second_container) = line.split_at(length / 2);
        let first_container_chars: Vec<char> = first_container.chars().collect();
        let mut duplicate_chars = Vec::new();

        // for c in first_container.chars() {
        //     *items_map.entry(c).or_insert(0) += 1
        // }

        for c in second_container.chars() {
            // *items_map.entry(c).or_insert(0) += 1
            if first_container_chars.contains(&c) {
                if !duplicate_chars.contains(&c) {
                    duplicate_chars.push(c);
                }
            }
        }

        // for (key, val) in items_map.iter() {
        //     if val > &1 {
        //         duplicates.push(key)
        //     }
        // }

        println!("{:?}", duplicate_chars);
        // current_total += duplicate_chars.iter().map(|&x| *x as u32).sum();
        let x = duplicate_chars
            .iter()
            .map(|&x| {
                let c = x as u32;
                // capital letter
                if c >= 65 && c <= 90 {
                    return 27 + c - 65;
                }

                // small letter
                if c >= 97 && c <= 122 {
                    return 1 + c - 97;
                }

                return c;
            })
            .collect::<Vec<u32>>();
        let sum: u32 = x.iter().sum();
        current_total += sum as i32;
        // println!("{:?}", x)
        println!("{}", sum)
    }

    println!("{}", current_total);
}
