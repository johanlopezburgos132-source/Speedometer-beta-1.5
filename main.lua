




--name : Speedometer Beta 1.5
--description : Speedometer limpio sin alertas de error, con menú en español e inglés.

  -- =============================================
-- SPEEDOMETER LIMPIO - Sin alertas de error
-- Menú en Español e Inglés
-- =============================================


local speed_x = 45
local speed_y = 620
local speed_scale = 1.05
local show_background = true

-- Límites seguros
local MIN_X = 20
local MAX_X = 1750
local MIN_Y = 20
local MAX_Y = 680

-- ================== COORDENADAS ACTUALES ==================
-- Coordenadas actuales del speedometer:  X = 45  |  Y = 620
-- ==========================================================

local function speedometer_hud()
    local m = gMarioStates[0]
    if m == nil then return end

    local speed = math.sqrt(m.vel.x * m.vel.x + m.vel.z * m.vel.z)
    local text = string.format("Velocidad: %.1f", speed)

    if show_background then
        djui_hud_set_color(0, 0, 0, 140)
        djui_hud_render_rect(speed_x - 15, speed_y - 8, 230, 45)
    end

    djui_hud_set_font(FONT_NORMAL)
    djui_hud_set_color(180, 255, 200, 255)
    djui_hud_print_text(text, speed_x, speed_y, speed_scale)

    djui_hud_set_font(FONT_SMALL)
    djui_hud_set_color(200, 230, 255, 180)
end

hook_event(HOOK_ON_HUD_RENDER, speedometer_hud)

-- ====================== COMANDO /speedometer ======================
local function speedometer_command(msg)
    if msg == "" or msg == nil then
        djui_chat_message_create("§eUso: /speedometer <x> <y>")
        djui_chat_message_create("§7Ejemplo: /speedometer 45 620")
        djui_chat_message_create("§7Actual: X=" .. speed_x .. " | Y=" .. speed_y)
        -- Mostrar coordenadas claramente
        djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        djui_chat_message_create("§a Coordenadas actuales: §eX = " .. speed_x .. "   |   Y = " .. speed_y)
        djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        return true
    end

    local x, y = msg:match("(%d+)%s+(%d+)")
    x = tonumber(x)
    y = tonumber(y)

    if x and y then
        if x < MIN_X then x = MIN_X end
        if x > MAX_X then x = MAX_X end
        if y < MIN_Y then y = MIN_Y end
        if y > MAX_Y then y = MAX_Y end

        speed_x = x
        speed_y = y
        djui_chat_message_create("§aPosición actualizada correctamente.")
        djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        djui_chat_message_create("§a Nueva posición: §eX = " .. speed_x .. "   |   Y = " .. speed_y)
        djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        return true
    else
        djui_chat_message_create("§cFormato incorrecto. Usa: /speedometer <x> <y>")
        return true
    end
end

-- ====================== MENÚ EN ESPAÑOL ======================
local function speedhelp_command(msg)
    djui_chat_message_create("§b=== MENÚ SPEEDOMETER ===")
    djui_chat_message_create("§eComando: /speedometer <x> <y>")
    djui_chat_message_create("")
    djui_chat_message_create("§eLímites:")
    djui_chat_message_create("§7X: 20 - 1750")
    djui_chat_message_create("§7Y: 20 - 680")
    djui_chat_message_create("")
    djui_chat_message_create("§eRecomendado para tu foto:")
    djui_chat_message_create("§a/speedometer 45 620")
    djui_chat_message_create("")
    djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    djui_chat_message_create("§ Coordenadas actuales: §eX = " .. speed_x .. "   |   Y = " .. speed_y)
    djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    return true
end

-- ====================== MENÚ EN INGLÉS ======================
local function speedhelp_english_command(msg)
    djui_chat_message_create("§b=== SPEEDOMETER HELP ===")
    djui_chat_message_create("§eCommand: /speedometer <x> <y>")
    djui_chat_message_create("")
    djui_chat_message_create("§eLimits:")
    djui_chat_message_create("§7X: 20 - 1750")
    djui_chat_message_create("§7Y: 20 - 680")
    djui_chat_message_create("")
    djui_chat_message_create("§eRecommended for your photo:")
    djui_chat_message_create("§a/speedometer 45 620")
    djui_chat_message_create("")
    djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    djui_chat_message_create("§a Current coordinates: §eX = " .. speed_x .. "   |   Y = " .. speed_y)
    djui_chat_message_create("§b━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    return true
end

-- Registrar comandos de forma limpia
hook_chat_command("speedometer", "Cambia posición del speedometer", speedometer_command)
hook_chat_command("speedhelp", "Menú de ayuda en español", speedhelp_command)
hook_chat_command("speedhelp-english", "Help menu in English", speedhelp_english_command)

print("Speedometer listo. Usa /speedhelp o /speedhelp-english")
