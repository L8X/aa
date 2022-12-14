if writefile and isfile and readfile and hookfunction then
local players = game:GetService("Players")
local local_player = getlocalplayer and getlocalplayer() or Players.LocalPlayer

if not isfile("da_hashes.txt") then
 writefile("da_hashes.txt", "")
end

local found_hash = false
local hash_list = readfile("da_hashes.txt")

local lines = hash_list:split("\n")
local clock_offset

if #lines > 0 then
   for i,v in next, lines do
       if found_hash then
           break
       end

       local line_split = v:split(":")
       if string.find(line_split[1], tostring(local_player.UserId)) then
           clock_offset = tonumber(line_split[2])
           found_hash = true
       end
   end
end

if not found_hash then
   math.randomseed(tick())
   clock_offset = math.random(1,200) + math.random(1,10000)/10000
   appendfile("da_hashes.txt", tostring(local_player.UserId)..":"..tostring(clock_offset).."\n")
end

local os_clock; os_clock = hookfunction(os.clock, function()
   return os_clock() + clock_offset
end)
end
