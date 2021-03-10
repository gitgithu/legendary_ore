local S

if minetest.get_translator ~= nil then
	S = minetest.get_translator(minetest.get_current_modname())
else
	S = function(str)
		return(str)
	end
end

--block definitions and recipes

minetest.register_node("legendary_ore:legendary_block", {
    description = S("A legendary bloc"),
    tiles = {"legendary_ore_block.png"},
    light_source = 7,
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_craft({
    type = "shaped",
    output = "legendary_ore:legendary_block 1",
    recipe = {
        {"legendary_armor:ingot", "legendary_armor:ingot", "legendary_armor:ingot"},
        {"legendary_armor:ingot", "legendary_armor:ingot",  "legendary_armor:ingot"},
        {"legendary_armor:ingot", "legendary_armor:ingot",  "legendary_armor:ingot"}
    }
})

minetest.register_node("legendary_ore:legendary_ore", {
	description = S("Ore"),
	tiles = {"default_stone.png^legendary_ore_ore.png"},
	groups = {cracky = 2},
	sounds = default_stone_sounds,
        light_source = 7,
	drop = "legendary_armor:ingot",
})

--Mapgen taken from Nyan cat mod, modified a little bit
--License: https://github.com/clinew/nyancat/blob/master/license.txt
--May or may not be working, haven't gotten around to testing it yet

legendaryOre = {}

function legendaryOre.place(pos, facedir, length)
	if facedir > 3 then
		facedir = 0
	end
	local tailvec = minetest.facedir_to_dir(facedir)
	local p = {x = pos.x, y = pos.y, z = pos.z}
	minetest.set_node(p, {name = "legendary_ore:legendary_ore", param2 = facedir})
	--for i = 1, length do
	--	p.x = p.x + tailvec.x
	--	p.z = p.z + tailvec.z
	--	minetest.set_node(p, {name = "nyancat:nyancat_rainbow", param2 = facedir})
	--end
end

function legendaryOre.generate(minp, maxp, seed)
	local height_min = -31000
	local height_max = -32
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x - minp.x + 1) * (y_max - y_min + 1) * (maxp.z - minp.z + 1)
	local pr = PseudoRandom(seed + 9324342)
	local max_num_ores = math.floor(volume / (16 * 16 * 16))
	for i = 1, max_num_ores do
		if pr:next(0, 1000) == 0 then
			local x0 = pr:next(minp.x, maxp.x)
			local y0 = pr:next(minp.y, maxp.y)
			local z0 = pr:next(minp.z, maxp.z)
			local p0 = {x = x0, y = y0, z = z0}
			legendaryOre.place(p0, pr:next(0, 3), pr:next(3, 15))
		end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
	legendaryOre.generate(minp, maxp, seed)
end)
