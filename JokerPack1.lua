--- STEAMODDED HEADER
--- MOD_NAME: Joker Pack 1
--- MOD_ID: JokerPack1
--- MOD_AUTHOR: [Shicedregg]
--- MOD_DESCRIPTION: Adds a few handmade Jokers to enhance your enjoyment of this wonderful game!

----------------------------------------------
------------MOD CODE -------------------------

function table_length(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

function SMODS.INIT.JokerPack()
    local jokerTable = {
        -- Good Fortune blesses your soul with a considerate amount of chips every hand!
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
            mult = 1337,
            config = { extra = {}},
            pos = { x = 0, y = 16},
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
                "{C:chips}+77{} Chips"
            }
        },
        j_1337_h4x0r = {
            name = "1337 h4x0r",
            text = {
                "{C:mult}+1337{} Mult"
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
    local jokerpack_mod = SMODS.findModByID("JokerPack1")
    local sprite_jokerpack = SMODS.Sprite:new("Joker", jokerpack_mod.path, "Jokers.png", 71, 95, "asset_atli")

    sprite_jokerpack:register()
end

---[[ Joker abilities
local set_abilityref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)
    set_abilityref(self, center, initial, delay_sprites)
    if self.ability.name == "1337 h4x0r" then
        self.ability.mult = 1337
    end
end
--]]

local calculate_jokerref = Card.calculate_joker
function Card.calculate_joker(self, context)
    local calc_ref = calculate_jokerref(self, context)
    if self.ability.set == "Joker" and not self.debuff then
        if context.cardarea == G.jokers then
            if context.before then elseif context.after then else
                if self.ability.name == "Good Fortune" then
                    return {
                        message = localize{type='variable',key='a_chips',vars={self.ability.extra}},
                        chip_mod = self.ability.extra,
                        colour = G.C.CHIPS
                    }
                end
            if self.ability.name == "1337 h4x0r" then
                return {
                    message = localize{type='variable',key='a_mult',vars={self.ability.mult}},
                    mult_mod = self.ability.mult
                } end
            end
        end
    end
    
    return calc_ref
end

----------------------------------------------
------------MOD CODE END----------------------