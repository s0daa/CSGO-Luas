local enabled = true

local screen_size = render.get_screen_size()
local x = screen_size.x / 1.98
local y = screen_size.y / 2.01

local main_font = render.create_font("smallest_pixel-7", 12, 400, e_font_flags.ANTIALIAS, e_font_flags.DROPSHADOW)

local min_damage_a = menu.find("aimbot", "auto", "target overrides", "force min. damage")
local min_damage_s = menu.find("aimbot", "scout", "target overrides", "force min. damage")
local min_damage_d = menu.find("aimbot", "deagle", "target overrides", "force min. damage")
local min_damage_r = menu.find("aimbot", "revolver", "target overrides", "force min. damage")
local min_damage_p = menu.find("aimbot", "pistols", "target overrides", "force min. damage")
local min_damage_awp = menu.find("aimbot", "awp", "target overrides", "force min. damage")

local amount_auto = unpack(menu.find("aimbot", "auto", "target overrides", "force min. damage"))
local amount_scout = unpack(menu.find("aimbot", "scout", "target overrides", "force min. damage"))
local amount_awp = unpack(menu.find("aimbot", "awp", "target overrides", "force min. damage"))
local amount_deagle = unpack(menu.find("aimbot", "deagle", "target overrides", "force min. damage"))
local amount_pistol = unpack(menu.find("aimbot", "pistols", "target overrides", "force min. damage"))
local amount_revolver = unpack(menu.find("aimbot", "revolver", "target overrides", "force min. damage"))

local function getweapon()
    local local_player = entity_list.get_local_player()
    if local_player == nil then return end

    local weapon_name = nil

    if local_player:get_prop("m_iHealth") > 0 then
    
        local active_weapon = local_player:get_active_weapon()
        if active_weapon == nil then return end

        weapon_name = active_weapon:get_name()


    else return end

    return weapon_name

end

local function on_paint()
    if enabled then

        if menu.is_open() then return end

        if getweapon() == "ssg08" then
            if min_damage_s[2]:get() then
                render.text(main_font, tostring(amount_scout:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        elseif getweapon() == "deagle" then
            if min_damage_d[2]:get() then
                render.text(main_font, tostring(amount_deagle:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        elseif getweapon() == "revolver" then
            if min_damage_r[2]:get() then
                render.text(main_font, tostring(amount_revolver:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        elseif getweapon() == "awp" then
            if min_damage_awp[2]:get() then
                render.text(main_font, tostring(amount_awp:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        elseif getweapon() == "scar20" or getweapon() == "g3sg1" then
            if min_damage_a[2]:get() then
                render.text(main_font, tostring(amount_auto:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        elseif getweapon() == "glock" or getweapon() == "p250" or getweapon() == "cz75a" or getweapon() == "usp-s" or getweapon() == "tec9" or getweapon() == "p2000" or getweapon() == "fiveseven" or getweapon() == "elite" then
            if min_damage_p[2]:get() then
                render.text(main_font, tostring(amount_pistol:get()), vec2_t(x, y - 16), color_t(255, 255, 255))
            end
        end
    end
end

callbacks.add(e_callbacks.PAINT, on_paint)