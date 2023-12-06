input =
  '''Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11'''

input = File.read("input.txt")
lines = input.split("\n")

h = {}
total_cards = Hash.new(0)

lines.each do |line|
  game, cards = line.split(":")
  wn, n = cards.split("|")

  current_card = game.split(" ")[1].to_i

  total_cards[current_card] += 1

  n = n.split(" ")
  wn = wn.split(" ")

  cards_won = 0

  n.each do |i|
    if wn.include?(i)
      cards_won += 1
    end
  end

  # pp "Cardno #{current_card} : cards won: #{cards_won}"

  new_cards = 
    if cards_won > 0
      (1..cards_won).map do |i|
        current_card + i  
      end
    else
      []
    end

  # pp new_cards

  existing_copies = total_cards[current_card]

  existing_copies.times do
    new_cards.each do |c|
      total_cards[c] += 1
    end
  end

  h[current_card] = new_cards
end


# pp h
pp total_cards.values.reduce(&:+)
# pp result.reduce(&:+)
