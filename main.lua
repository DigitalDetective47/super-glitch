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

SMODS.Joker:take_ownership('j_ceremonial', {
    config = { mult = 0, ratio = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult, card.ability.ratio == 2 and "double" or tostring(card.ability.ratio) .. "X" } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.mult }
        elseif context.setting_blind and not self.getting_sliced and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not self.getting_sliced and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.mult = card.ability.mult + sliced_card.sell_cost * card.ability.ratio
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    {
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.mult + 2 * sliced_card.sell_cost } },
                        colour =
                            G.C.RED,
                        no_juice = true
                    })
            end
        end
    end,
}, true)
