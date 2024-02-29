--- STEAMODDED HEADER
--- MOD_NAME: Shicedregg's Joker Pack
--- MOD_ID: ShiceJokerPack
--- MOD_AUTHOR: [Shicedregg]
--- MOD_DESCRIPTION: Adds three handmade Jokers to enhance your enjoyment of this wonderful game!

----------------------------------------------
------------MOD CODE -------------------------

function table_length(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

food = {"Gros Michel", "Egg", "Ice Cream", "Cavendish", "Turtle Bean", "Diet Cola", "Popcorn", "Ramen", "Seltzer"}

function SMODS.INIT.JokerPack()
    local jokerTable = {
        -- Good Fortune blesses your soul with a considerate amount of chips!
        j_goodFortune = {
            order = 0,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
            rarity = 1,
            cost = 7,
            name = "Good Fortune",
            set = "Joker",
            config = { extra = 77 },
            pos = { x = 1, y = 16 }
        },
        -- H4ckerman doing elite stuff
        j_1337_h4x0r = {
            order = 0,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
            rarity = 3,
            cost = 9,
            name = "1337 h4x0r",
            set = "Joker",
            config = { extra = 1337 },
            pos = { x = 0, y = 16 },
        },
        -- Ace up the Sleeve coming in clutch
        j_Ace_up_the_Sleeve = {
            order = 0,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
            rarity = 2,
            cost = 5,
            name = "Ace up the Sleeve",
            set = "Joker",
            config = { extra = 11 },
            pos = { x = 2, y = 16 },
        },
        -- Can't win on an empty stomach
        j_restaurant = {
            order = 0,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true,
            rarity = 1,
            cost = 4,
            name = "Restaurant",
            set = "Joker",
            config = { extra = {mult = 15, x_mult = 25} },
            pos = { x = 3, y = 16 },
        }
    }

    -- Add Jokers to center
    for k, v in pairs(jokerTable) do
        v.key = k
        v.order = table_length(G.P_CENTER_POOLS['Joker']) + 1
        G.P_CENTERS[k] = v
        table.insert(G.P_CENTER_POOLS['Joker'], v)
        table.insert(G.P_JOKER_RARITY_POOLS[v.rarity], v)
    end

    table.sort(G.P_CENTER_POOLS["Joker"], function (a, b) return a.order < b.order end)

    -- Localization
    local jokerLocalization = {
        j_goodFortune = {
            name = "Good Fortune",
            text = {
                "{C:chips}+#1#{} Chips"
            }
        },
        j_1337_h4x0r = {
            name = "1337 h4x0r",
            text = {
                "{C:mult}+#1#{} Mult"
            }
        },
        j_Ace_up_the_Sleeve = {
            name = "Ace up the Sleeve",
            text = {
                "{X:mult,C:white} X#1# {} Mult if you",
                "have a single {C:attention}Ace{} on hand"
            }
        },
        j_restaurant = {
            name = "Restaurant",
            text = {
                "{C:mult}+#1#{} Mult for each other food",
                "Joker, {X:mult,C:white} X#2# {} Mult if all",
                "other Jokers are food"
            }
        }
    }
    for k, v in pairs(jokerLocalization) do
        G.localization.descriptions.Joker[k] = v
    end

    -- Update localization
    for g_k, group in pairs(G.localization) do
        if g_k == 'descriptions' then
            for _, set in pairs(group) do
                for _, center in pairs(set) do
                    center.text_parsed = {}
                    for _, line in ipairs(center.text) do
                        center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
                    end
                    center.name_parsed = {}
                    for _, line in ipairs(type(center.name) == 'table' and center.name or { center.name }) do
                        center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
                    end
                    if center.unlock then
                        center.unlock_parsed = {}
                        for _, line in ipairs(center.unlock) do
                            center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
                        end
                    end
                end
            end
        end
    end

    -- Add sprites
    local jokerpack_mod = SMODS.findModByID("ShiceJokerPack")
    local sprite_jokerpack = SMODS.Sprite:new("Joker", jokerpack_mod.path, "Jokers.png", 71, 95, "asset_atli")

    sprite_jokerpack:register()
end

local calculate_jokerref = Card.calculate_joker
function Card.calculate_joker(self, context)
    local calc_ref = calculate_jokerref(self, context)
    if self.ability.set == "Joker" and not self.debuff then
        if context.open_booster then
        elseif context.buying_card then
        elseif context.selling_self then
        elseif context.selling_card then
        elseif context.reroll_shop then
        elseif context.ending_shop then
        elseif context.skip_blind then
        elseif context.skipping_booster then
        elseif context.playing_card_added and not self.getting_sliced then
        elseif context.first_hand_drawn then
        elseif context.setting_blind and not self.getting_sliced then
        elseif context.destroying_card and not context.blueprint then
        elseif context.cards_destroyed then
        elseif context.remove_playing_cards then
        elseif context.using_consumeable then
        elseif context.debuffed_hand then
        elseif context.pre_discard then
        elseif context.discard then
        elseif context.end_of_round then
        elseif context.individual then
            if context.cardarea == G.play then
            end
            if context.cardarea == G.hand then
            end
        elseif context.repetition then
            if context.cardarea == G.play then
            end
            if context.cardarea == G.hand then
            end
        elseif context.other_joker then
            if self.ability.name == "Restaurant" then
                local food_available = 0
                local jokers = 1
                if self.ability.name == "Restaurant" and has_value(food, context.other_joker.ability.name) and self ~= context.other_joker then
                    food_available = food_available + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_joker:juice_up(0.5, 0.5)
                            return true
                        end
                    })) 
                    return {
                        message = localize{type='variable',key='a_mult',vars={self.ability.extra.mult}},
                        mult_mod = self.ability.extra.mult
                    }
                end
            end
        else
            if context.cardarea == G.jokers then
                if context.before then
                elseif context.after then else
                    if self.ability.name == "Good Fortune" then
                        return {
                            message = localize{type='variable',key='a_chips',vars={self.ability.extra}},
                            chip_mod = self.ability.extra,
                            colour = G.C.CHIPS
                        }
                    end
                    if self.ability.name == "1337 h4x0r" then
                        return {
                            message = localize{type='variable',key='a_mult',vars={self.ability.extra}},
                            mult_mod = self.ability.extra
                        }
                    end
                    if self.ability.name == "Ace up the Sleeve" then
                        local aces_in_hand = 0
                        for i=1, #G.hand.cards do
                            if G.hand.cards[i]:get_id() == 14 then aces_in_hand = aces_in_hand + 1 end
                        end
                        if aces_in_hand == 1 then
                            return {
                                message = localize{type='variable',key='a_xmult',vars={self.ability.extra}},
                                Xmult_mod = self.ability.extra
                            }
                        end
                    end
                    if self.ability.name == "Restaurant" then
                        local food_jokers_in_hand = 0
                        local jokers_in_hand = 0
                        for i=1, #G.jokers.cards do
                            jokers_in_hand = jokers_in_hand + 1
                            if has_value(food, G.jokers.cards[i].ability.name) then food_jokers_in_hand = food_jokers_in_hand + 1 end
                        end
                        if ((food_jokers_in_hand) == (jokers_in_hand - 1)) and (jokers_in_hand >= 2) then
                            return {
                                message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
                                Xmult_mod = self.ability.extra.x_mult
                            }
                        end
                    end
                end
            end
        end
    end
    return calc_ref
end

local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self)
    local card_type, hide_desc = self.ability.set or "None", nil
    local loc_vars = nil
    local main_start, main_end = nil, nil
    local no_badge = nil

    if self.config.center.unlocked == false and not self.bypass_lock then -- For everyting that is locked
    elseif card_type == 'Undiscovered' and not self.bypass_discovery_ui then -- Any Joker or tarot/planet/voucher that is not yet discovered
    elseif self.debuff then
    elseif card_type == 'Default' or card_type == 'Enhanced' then
    elseif self.ability.set == 'Joker' then
        local customJoker = false

        if self.ability.name == "Good Fortune" then
            loc_vars = {self.ability.extra}
            customJoker = true
        elseif self.ability.name == "1337 h4x0r" then
            loc_vars = {self.ability.extra}
            customJoker = true
        elseif self.ability.name == "Ace up the Sleeve" then
            loc_vars = {self.ability.extra}
            customJoker = true
        elseif self.ability.name == "Restaurant" then
            loc_vars = {self.ability.extra.mult, self.ability.extra.x_mult}
            customJoker = true
        end

        if customJoker then
            local badges = {}
            if (card_type ~= 'Locked' and card_type ~= 'Undiscovered' and card_type ~= 'Default') or self.debuff then
                badges.card_type = card_type
            end
            if self.ability.set == 'Joker' and self.bypass_discovery_ui and (not no_badge) then
                badges.force_rarity = true
            end
            if self.edition then
                if self.edition.type == 'negative' and self.ability.consumeable then
                    badges[#badges + 1] = 'negative_consumable'
                else
                    badges[#badges + 1] = (self.edition.type == 'holo' and 'holographic' or self.edition.type)
                end
            end
            if self.seal then
                badges[#badges + 1] = string.lower(self.seal) .. '_seal'
            end
            if self.ability.eternal then
                badges[#badges + 1] = 'eternal'
            end
            if self.pinned then
                badges[#badges + 1] = 'pinned_left'
            end

            if self.sticker then
                loc_vars = loc_vars or {};
                loc_vars.sticker = self.sticker
            end

            return generate_card_ui(self.config.center, nil, loc_vars, card_type, badges, hide_desc, main_start, main_end)
        end
    end

    return generate_UIBox_ability_tableref(self)
end

----------------------------------------------
------------MOD CODE END----------------------