use std::collections::HashMap;
use std::hash::Hash;

fn main() {
    let stone = "STONE";
    let paper = "PAPER";
    let scissors = "SCISSORS";

    let mut symbol_to_char: HashMap<&str, &str> = HashMap::new();
    symbol_to_char.insert("A", stone);
    symbol_to_char.insert("B", paper);
    symbol_to_char.insert("C", scissors);
    symbol_to_char.insert("X", stone);
    symbol_to_char.insert("Y", paper);
    symbol_to_char.insert("Z", scissors);

    let mut points: HashMap<&str, i32> = HashMap::new();
    points.insert(stone, 1);
    points.insert(paper, 2);
    points.insert(scissors, 3);

    let data = include_str!("../input.txt");
    // let data = include_str!("../inp2.txt");
    let mut current_total: i32 = 0;
    let mut round_point: i32 = 0;

    for (_i, line) in data.lines().enumerate() {
        let words = line.split_whitespace().collect::<Vec<&str>>();
        let opponent_token = symbol_to_char.get(words[0]).unwrap().to_string();
        let my_token = symbol_to_char.get(words[1]).unwrap().to_string();

        let token_point = points.get(my_token.as_str()).unwrap();
        if my_token.eq(stone) && opponent_token.eq(scissors) {
            round_point = 6
        } else if my_token.eq(stone) && opponent_token.eq(paper) {
            round_point = 0
        } else if my_token.eq(paper) && opponent_token.eq(stone) {
            round_point = 6
        } else if my_token.eq(paper) && opponent_token.eq(scissors) {
            round_point = 0
        } else if my_token.eq(scissors) && opponent_token.eq(stone) {
            round_point = 0
        } else if my_token.eq(scissors) && opponent_token.eq(paper) {
            round_point = 6
        } else if my_token.eq(opponent_token.as_str()) {
            round_point = 3
        }

        current_total += round_point + token_point;
        round_point = 0;
    }

    println!("{}", current_total)
}
