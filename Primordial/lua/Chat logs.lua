local ffi = require("ffi")
ffi.cdef[[
    typedef struct {
        unsigned short wYear;
        unsigned short wMonth;
        unsigned short wDayOfWeek;
        unsigned short wDay;
        unsigned short wHour;
        unsigned short wMinute;
        unsigned short wSecond;
        unsigned short wMilliseconds;
    } SYSTEMTIME, *LPSYSTEMTIME;
    
    void GetSystemTime(LPSYSTEMTIME lpSystemTime);
    void GetLocalTime(LPSYSTEMTIME lpSystemTime);
]]

local FindElement = ffi.cast("unsigned long(__thiscall*)(void*, const char*)", memory.find_pattern("client.dll", "55 8B EC 53 8B 5D 08 56 57 8B F9 33 F6 39 77 28"))
local CHudChat = FindElement(ffi.cast("unsigned long**", ffi.cast("uintptr_t", memory.find_pattern("client.dll", "B9 ? ? ? ? E8 ? ? ? ? 8B 5D 08")) + 1)[0], "CHudChat")
local FFI_ChatPrint = ffi.cast("void(__cdecl*)(int, int, int, const char*, ...)", ffi.cast("void***", CHudChat)[0][27])

local function PrintInChat(text)
    FFI_ChatPrint(CHudChat, 0, 0, string.format("%s ", text))
end



local logsCheckbox = menu.add_checkbox("Ragebot", "Logs")
local logsSelection = menu.add_multi_selection("Ragebot", "Logs selection", {"Miss", "Hit" --[[, "Hurt", "Purchase"]]})

local function logFunction()
    local logsValue = logsCheckbox:get()
    
    if logsValue == true then
        logsSelection:set_visible(true)
    else
        logsSelection:set_visible(false)
        logsSelection:set(1, false)
        logsSelection:set(2, false)
        -- logsSelection:set(3, false)
        -- logsSelection:set(4, false)
    end
end

local function missLogs(shot)
    local missValue = logsSelection:get("Miss")

    if missValue == true then
        PrintInChat('\x01[\x0CLogs\x01] \x08Missed \x07' ..shot.player:get_name().. '\x08 due to \x03' ..shot.reason_string.. '\x08 with \x10' ..shot.backtrack_ticks.. '\x08 ms backtrack. Predicted damage \x0B' ..shot.aim_damage.. '\x08 and hitchance \x05' ..shot.aim_hitchance.. '\x08.')
	    print('\x01[\x0CLogs\x01] \x08Missed \x07' ..shot.player:get_name().. '\x08 due to \x03' ..shot.reason_string.. '\x08 with \x10' ..shot.backtrack_ticks.. '\x08 ms backtrack. Predicted damage \x0B' ..shot.aim_damage.. 'and hitchance' ..shot.aim_hitchance.. '\x08.')
    end
end

local function hitLogs(shot)
    local hitValue = logsSelection:get("Hit")

    if hitValue == true then
        PrintInChat('\x01[\x0CLogs\x01] \x08Hit \x07'..shot.player:get_name()..'\x08 in the \x10'..shot.hitgroup..'\x08 for \x0B'..shot.damage..'\08 damage with \x05'..shot.aim_hitchance..'\x08 hitchance while predicted damage \x03' ..shot.aim_damage.. ' \x08 and \x04'..shot.backtrack_ticks..'\x08 ms backtrack.')
	    print('\x01[\x0CLogsl\x01] \x08Hit \x07'..shot.player:get_name()..'\x08 in the \x10'..shot.hitgroup..'\x08 for \x0B'..shot.damage..'\08 damage with \x05'..shot.aim_hitchance..'\x08 hitchance while predicted damage \x03' ..shot.aim_damage.. ' \x08 and \x04'..shot.backtrack_ticks..'\x08 ms backtrack.')
    end
end

callbacks.add(e_callbacks.PAINT, logFunction)
callbacks.add(e_callbacks.AIMBOT_MISS, missLogs)
callbacks.add(e_callbacks.AIMBOT_HIT, hitLogs)