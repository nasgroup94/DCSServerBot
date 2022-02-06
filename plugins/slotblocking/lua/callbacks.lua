local base 	    = _G
local dcsbot    = base.dcsbot

local slotblock = slotblock or {}
dcsbot.userInfo = dcsbot.userInfo or {}

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function slotblock.onPlayerTryChangeSlot(playerID, side, slotID)
    log.write('DCSServerBot', log.DEBUG, 'Slotblocking: onPlayerTryChangeSlot()')
    player = net.get_player_info(playerID, 'ucid')
    unit_name = DCS.getUnitProperty(slotID, DCS.UNIT_NAME)
    group_name = DCS.getUnitProperty(slotID, DCS.UNIT_GROUPNAME)
    unit_type = DCS.getUnitType(slotID)
    -- check levels if any
    for id, unit in pairs(dcsbot.params['slotblocking']['restricted']) do
        if (unit['unit_type'] and unit['unit_type'] == unit_type)
                or (unit['unit_name'] and string.find(unit_name, unit['unit_name'], 1, true) ~= nil)
                or (unit['group_name'] and string.find(group_name, unit['group_name'], 1, true) ~= nil) then
            -- blocking slots by points
            if unit['points'] and dcsbot.userInfo[player].points < unit['points'] then
                message = 'You need at least ' .. unit['points'] .. ' points to enter this slot. You currently have ' .. dcsbot.userInfo[player].points .. ' points.'
                net.send_chat_to(message, playerID)
                return false
            -- blocking slots by discord groups
            elseif unit['discord'] and has_value(dcsbot.userInfo[player].roles, unit['discord']) == false then
                message = unit['message'] or 'This slot is restricted for a specific discord role.'
                net.send_chat_to(message, playerID)
                return false
            end
        end
    end
end

DCS.setUserCallbacks(slotblock)