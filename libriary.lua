local lib = {}
local computer = require "computer"
local component = require "component"
local unicode = require "unicode"
local gpu = component.gpu

function lib.button(x, y, text, fcolor)
    local len = unicode.len(text) + 3
    local foreground = gpu.getForeground()
    gpu.setForeground(fcolor)
    gpu.fill(x, y, len, 1, "═")
    gpu.fill(x, y, 1, 3, "║")
    gpu.fill(x + len, y, 1, 3, "║")
    gpu.fill(x, y + 2, len, 1, "═")
    gpu.set(x, y, "╔")
    gpu.set(x + len, y, "╗")
    gpu.set(x, y + 2, "╚")
    gpu.set(x + len, y + 2, "╝")
    gpu.set(x + 2, y + 1, text)
    gpu.setForeground(foreground)
end

function lib.cube(x, y, w, h, fcolor, bold)
    local foreground = gpu.getForeground()
    gpu.setForeground(fcolor)
    if bold then
        gpu.fill(x, y, w, 1, "═")
        gpu.fill(x, y, 1, h, "║")
        gpu.fill(x + w, y, 1, h, "║")
        gpu.fill(x, y + h, w, 1, "═")
        gpu.set(x, y, "╔")
        gpu.set(x + w, y, "╗")
        gpu.set(x, y + h, "╚")
        gpu.set(x + w, y + h, "╝")
    else
        gpu.fill(x, y, w, 1, "─")
        gpu.fill(x, y, 1, h, "│")
        gpu.fill(x + w, y, 1, h, "│")
        gpu.fill(x, y + h, w, 1, "─")
        gpu.set(x, y, "┌")
        gpu.set(x + w, y, "┐")
        gpu.set(x, y + h, "└")
        gpu.set(x + w, y + h, "┘")
        gpu.setForeground(foreground)
    end
end

function lib.error(message)
    local rX, rW = gpu.getResolution()
    gpu.setBackground(0xFF0000)
    gpu.fill(rX / 2 - (unicode.len(message) / 2) - 4, rW / 2 - 2, unicode.len(message) + 4, 3, " ")
    gpu.set((rX / 2) - (unicode.len(message) / 2) - 2, rW / 2 - 1, message)
    gpu.setForeground(0x000000)
end

function lib.drawU(w, h, fcolor)
    local foreground = gpu.getForeground()
    gpu.setForeground(fcolor)
    gpu.set(1, 1, "┌")
    gpu.set(2, 1, "──")
    gpu.set(w - 1, 1, "──")
    gpu.set(2, h + 1, "──")
    gpu.set(w - 1, h + 1, "──")
    gpu.set(1 + w, 1, "┐")
    gpu.set(1, 1 + h, "└")
    gpu.set(1 + w, 1 + h, "┘")
    gpu.set(1, 2, "│")
    gpu.set(1, h, "│")
    gpu.set(w + 1, 2, "│")
    gpu.set(w + 1, h, "│")
    gpu.setForeground(foreground)
end
function lib.center(x, y, text, fcolor)
    local len = unicode.len(text)
    local foreground = gpu.getForeground()
    gpu.setForeground(fcolor)
    gpu.set((x / 2) - (len / 2), y, text)
    gpu.setForeground(foreground)
end

function lib.slot(x, y, xSlots, ySlots, fcolor, slotSize)
    local foreground = gpu.getForeground()
    gpu.setForeground(fcolor)
    gpu.fill(x, y, xSlots * slotSize * 2, 1, "─")
    gpu.fill(x, y + ySlots * slotSize, xSlots * slotSize * 2, 1, "─")
    gpu.fill(x, y, 1, ySlots * slotSize, "│")
    gpu.fill(x + xSlots * slotSize * 2, y, 1, ySlots * slotSize, "│")
    local slotSize = slotSize or 4
    xl = x
    for yl = y + slotSize, ySlots * slotSize + 8, slotSize do
        gpu.fill(xl + 1, yl, xSlots * slotSize * 2 - 1, 1, "─")
        gpu.set(xl, yl, "├")
        gpu.set(xl + (slotSize * 2 * xSlots), yl, "┤")
    end
    yl = y + 1
    for xl = x + slotSize * 2, xSlots * slotSize * 2 + slotSize, slotSize * 2 do
        gpu.fill(xl, yl, 1, ySlots * slotSize - 1, "│")
        gpu.set(xl, yl - 1, "┬")
        gpu.set(xl, yl + (ySlots * slotSize) - 1, "┴")
    end
    for xl = x + slotSize * 2, xSlots * slotSize * 2 + slotSize, slotSize * 2 do
        for yl = y + slotSize, ySlots * slotSize + slotSize * 2, slotSize do
            gpu.set(xl, yl, "┼")
        end
    end
    gpu.fill(x, y + ySlots * slotSize, xSlots * slotSize * 2, 1, "─")
    for xl = x + slotSize * 2, xSlots * slotSize * 2 + slotSize, slotSize * 2 do
        gpu.set(xl, yl + (ySlots * slotSize) - 1, "┴")
    end
    gpu.set(x, y, "┌")
    gpu.set(x + slotSize * xSlots * 2, y, "┐")
    gpu.set(x, y + slotSize * ySlots, "└")
    gpu.set(x + slotSize * xSlots * 2, y + slotSize * ySlots, "┘")
    gpu.setForeground(foreground)
end

function lib.bar(x, y, fill, w, colors)
    gpu.setBackground(0x232323)
    for xb = x, w + 3 do
        gpu.fill(xb, y + 1, 1, 1, " ")
    end
    h = 2
    gpu.setBackground(0x232323)
    gpu.fill(x, y, w + 1, 1, "─")
    gpu.fill(x, y, 1, h, "│")
    gpu.fill(x + w + 1, y, 1, h, "│")
    gpu.fill(x, y + h, w + 1, 1, "─")
    gpu.set(x, y, "┌")
    gpu.set(x + w + 1, y, "┐")
    gpu.set(x, y + h, "└")
    gpu.set(x + w + 1, y + h, "┘")
    if type(colors) ~= "table" then return false end
    if #colors ~= w then return false end
    local foreground = gpu.getForeground()
    color = 1
    x = x + 1
    gpu.setForeground(0x000000)
    if fill == #colors then
        gpu.fill(x, y + 1, fill, 1, " ")
    else
        gpu.fill(x, y + 1, fill + 1, 1, " ")
    end
    for xb = x, fill + x do
        gpu.setForeground(colors[color])
        gpu.fill(xb, y + 1, 1, 1, "▉")
        color = color + 1
    end
    gpu.setForeground(foreground)
end
return lib
