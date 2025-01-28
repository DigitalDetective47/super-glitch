SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34,
})

local suit = {
    apply_glitched = function(self, card, func)
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, pseudoseed(self.key)).key
    end,
}

SMODS.Joker:take_ownership('j_greedy_joker', suit, true)
SMODS.Joker:take_ownership('j_lusty_joker', suit, true)
SMODS.Joker:take_ownership('j_wrathful_joker', suit, true)
SMODS.Joker:take_ownership('j_gluttenous_joker', suit, true)

local poker_hand = {
    apply_glitched = function(self, card, func)
        card.ability.type = pseudorandom_element(SMODS.PokerHands, pseudoseed(self.key)).key
    end
}

SMODS.Joker:take_ownership('j_jolly', poker_hand, true)
SMODS.Joker:take_ownership('j_zany', poker_hand, true)
SMODS.Joker:take_ownership('j_mad', poker_hand, true)
SMODS.Joker:take_ownership('j_crazy', poker_hand, true)
SMODS.Joker:take_ownership('j_droll', poker_hand, true)
SMODS.Joker:take_ownership('j_sly', poker_hand, true)
SMODS.Joker:take_ownership('j_wily', poker_hand, true)
SMODS.Joker:take_ownership('j_clever', poker_hand, true)
SMODS.Joker:take_ownership('j_devious', poker_hand, true)
SMODS.Joker:take_ownership('j_crafty', poker_hand, true)
