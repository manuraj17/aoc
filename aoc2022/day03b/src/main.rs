use std::borrow::Borrow;
use std::collections::HashMap;

fn main() {
    println!("Hello, world!");

    let data = include_str!("../input.txt");
    // let data = include_str!("../inp2.txt");

    let lvec: Vec<&str> = data.lines().collect();

    let mut count = 0;
    let mut grouped_vec = Vec::new();
    let mut temp_vec = Vec::new();

    for lines in lvec {
        temp_vec.push(lines);
        count += 1;
        if count % 3 == 0 {
            grouped_vec.push(temp_vec.clone());
            temp_vec.clear();
        }
    }

    if !temp_vec.is_empty() {
        grouped_vec.push(temp_vec.clone());
    }

    println!("{:?}", grouped_vec);

    let mut duplicates = Vec::new();

    for group in grouped_vec {
        let mut current_duplicates = Vec::new();
        let group_1_vec: Vec<char> = group.get(0).unwrap().chars().collect();
        let group_2_vec: Vec<char> = group.get(1).unwrap().chars().collect();
        let group_3_vec: Vec<char> = group.get(2).unwrap().chars().collect();

        for c in group_1_vec {
            if group_2_vec.contains(&c) && group_3_vec.contains(&c) {
                if !current_duplicates.contains(&c) {
                    current_duplicates.push(c);
                }
            }
        }

        for c in current_duplicates {
            duplicates.push(c)
        }
    }

    println!("{:?}", duplicates);

    let x = duplicates
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
    println!("{}", sum);
}
