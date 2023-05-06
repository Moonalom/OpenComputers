--Created by zayats. 06.05.23. Special for IU discord community.
local multiplier = 49 --Модуль области: без него = 1, 3х3 = 9, 5х5 = 25, 7х7 = 49
local updateTime = 1 -- время обновления экрана [Default: 1 секунда.]
--------------------------------------------------------------------------------
local clear = require "term".clear()
local lib = require "lib"
local img = require "imgs"
local unicode = require "unicode"
local component = require "component"
local gpu = component.gpu
local quarry = component.quantumquarry
local rx, ry = 48, 20
local colors = {0xff0000, 0xff2200, 0xff3400, 0xfe4100, 0xfc4d00, 0xfb5800, 0xf96100, 0xf66b00, 0xf37400, 0xf07c00, 0xec8400, 0xe88c00, 0xe49400, 0xdf9c00, 0xd9a300, 0xd4aa00, 0xceb100, 0xc7b800, 0xc0be00, 0xb8c500, 0xb0cb00, 0xa7d100, 0x9ed700, 0x94dd00, 0x88e300, 0x7be900, 0x6cef00, 0x59f400, 0x3ffa00, 0x00ff00}
function init()
    gpu.setBackground(0x232323)
    gpu.setResolution(rx, ry)
    gpu.fill(1, 1, rx, ry, " ")
    lib.center(rx, 1, "Quantum Quarry Monitor", 0xFFFFFF)
    lib.center(rx, ry, "v1.1", 0xF5F0F0)
    lib.cube(2, 4, 18, 9, 0xFFFFFF)
    lib.cube(22, 4, 25, 9, 0xFFFFFF)
    gpu.fill(2, 8, 19, 2, " ")
    gpu.fill(10, 4, 3, 10, " ")
    gpu.setBackground(0x232323)
    lib.bar(2, 16, -1, #colors - 3, colors)
    gpu.setBackground(0x232323)
end
local function draw(start_x, start_y, meta)
    img = img.load(meta)
    local w, h = #img, #img[1]
    y = start_y
    for i = 1, #img / 2 do
        x = start_x
        for j = 1, #img[i] do
            gpu.setBackground(img[i * 2 - 1][j])
            gpu.setForeground(img[i * 2][j])
            gpu.set(x,y,"▄")
            x = x + 1
        end
        y = y + 1
    end
end
local function convert(value)
    if value > 1000 and value < 1000000 then
        return string.format("%.2f", value / 1000) .. " k"
    elseif value > 1000000 and value < 1000000000 then
        return string.format("%.2f", value / 1000000) .. " M"
    elseif value > 1000000000 then
        return string.format("%.2f", value / 1000000000) .. " G"
    elseif value < -1000 and value > -1000000 then
        return string.format("%.2f", value / 1000) .. " k"
    elseif value < -1000000 and value > -1000000000 then
        return string.format("%.2f", value / 1000000) .. " M"
    elseif value < -1000000000 then
        return "-" .. string.format("%.2f", value / 1000000000) .. " G"
    else
        return value .. " "
    end
end
function getData()
    local capacity = quarry.getCapacityEnergy()
    local vein = quarry.getTypeVeinStack()
    local veinName = quarry.getTypeVein()
    local fortune = quarry.getChance()
    local work = quarry.isWork()
    local consume = quarry.getConsume()
    local blocksTick = quarry.getBlocksTick()
    local energy = quarry.getQuantumEnergy()
    local info = {capacity, fortune, work, consume, blocksTick, energy, veinName}
    return info, vein
end
function loadVein(vein)
    draw(3, 5, vein.damage + 1)
    gpu.setForeground(0xFFFFFF)
    gpu.setBackground(0x000000)
end
function update(info)
    gpu.setBackground(0x232323)
    gpu.fill(23, 5, 22, 6, " ")
    gpu.setForeground(0x5555F0)
    gpu.set(29, 5, info[7])
    gpu.setForeground(0xFFFFFF)
    gpu.set(23, 5, "Жила: ")
    gpu.set(22, 6,  "├────────────────────────┤")
    gpu.set(22, 11, "├────────────────────────┤")
    gpu.set(23, 7, "Накопленно: " .. convert(info[6]) .. "qE")
    gpu.set(23, 8, "Блоков/тик: " .. convert(info[5]) .. "B/t")
    gpu.set(23, 9, "Удача: " .. info[2])
    gpu.set(23, 10, "Потребление: " .. convert(info[4]) .. "qE/t")
    gpu.set(3, 15, "Мощность:")
    local w = (info[5] / multiplier ) * (#colors - 1)
    if w < 0 then
        w = #colors - 1
    end
    lib.bar(2, 16, w, #colors, colors)
    gpu.setBackground(0x232323)
    if info[5] > 1 then
        gpu.setForeground(0x00FF00)
        gpu.set(23, 12, "Статус: активен  ")
    else
        gpu.setForeground(0xFF0000)
        gpu.set(23, 12, "Статус: неактивен")
    end
    gpu.setForeground(0xFFFFFF)
end

init()
local info, vein = getData()
loadVein(vein)

while true do
    local info, vein = getData()
    update(info)
    os.sleep(updateTime)
end
