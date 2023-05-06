local progs = {
    {"QQ Monitor", "https://raw.githubusercontent.com/Moonalom/OpenComputers/main/QQMonitor.lua", "program", "qqmonitor"},
    {"Library", "https://raw.githubusercontent.com/Moonalom/OpenComputers/main/libriary.lua", "lib", "lib.lua"},
    {"Images", "https://raw.githubusercontent.com/Moonalom/OpenComputers/main/images.lua", "lib", "imgs.lua"}
}
local shell = require "shell"
local version, author = "1.0.1", "zayats"
print("Welcome to the installer! \nVersion: " .. version .. ", by: " .. author)
os.sleep(0.1)
print("Init...")
os.sleep(0.5)
while true do
    require "term".clear()
    print("List of all programs:")
    for program = 1, #progs do
        print(program .. ". " .. progs[program][1] .. " | type: " .. progs[program][3])
    end
    print("\n\nTo exit just enter 'e'")
    print("Enter number of program:")
    prog = io.read()
    if prog == '' then
        return
    elseif prog ~= 'e' then
        print("Your choice: " .. progs[tonumber(prog)][1] .. ". download...")
        if progs[tonumber(prog)][3] == "lib" then
            shell.execute("wget -f " .. progs[tonumber(prog)][2] .. " /lib/" .. progs[tonumber(prog)][4])
            print("Done! Saved at: /lib/" .. progs[tonumber(prog)][4])
        else
            shell.execute("wget -f " .. progs[tonumber(prog)][2] .. " " .. progs[tonumber(prog)][4])
            print("Done! Saved at: " .. progs[tonumber(prog)][4])
        end
        os.sleep(1)
    elseif prog == 'e' then
        print("Bye!")
        os.sleep(1)
        require "computer".shutdown(true)
    else
        print("null!")
    end
end
