use std::collections::HashMap;

fn main() {
    let stone = "STONE";
    let paper = "PAPER";
    let scissors = "SCISSORS";
    let win = "W";
    let lose = "L";
    let draw = "D";

    let mut symbol_to_char: HashMap<&str, &str> = HashMap::new();
    symbol_to_char.insert("A", stone);
    symbol_to_char.insert("B", paper);
    symbol_to_char.insert("C", scissors);
    symbol_to_char.insert("X", stone);
    symbol_to_char.insert("Y", paper);
    symbol_to_char.insert("Z", scissors);

    let mut symbols_to_game: HashMap<&str, &str> = HashMap::new();
    symbols_to_game.insert("X", lose);
    symbols_to_game.insert("Y", draw);
    symbols_to_game.insert("Z", win);

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
        let my_game = symbols_to_game.get(words[1]).unwrap().to_string();
        let mut my_token = "";

        if opponent_token.eq(stone) {
            if my_game.eq(win) {
                my_token = paper;
            } else if my_game.eq(lose) {
                my_token = scissors
            } else if my_game.eq(draw) {
                my_token = stone
            }
        } else if opponent_token.eq(paper) {
            if my_game.eq(win) {
                my_token = scissors;
            } else if my_game.eq(lose) {
                my_token = stone
            } else if my_game.eq(draw) {
                my_token = paper
            }
        } else if opponent_token.eq(scissors) {
            if my_game.eq(win) {
                my_token = stone;
            } else if my_game.eq(lose) {
                my_token = paper
            } else if my_game.eq(draw) {
                my_token = scissors
            }
        }

        let token_point = points.get(my_token).unwrap();

        if my_game.eq(win) {
            round_point = 6
        } else if my_game.eq(draw) {
            round_point = 3
        }

        current_total += round_point + token_point;
        round_point = 0;
    }

    println!("{}", current_total)
}

// 12091
