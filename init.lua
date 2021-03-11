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
    description = S("Legendary block"),
    tiles = {"legendary_ore_block.png"},
    light_source = 7,
    is_ground_content = true,
    groups = {cracky=3}
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

if minetest.get_modpath("legendary_armor") then
	minetest.register_node("legendary_ore:legendary_ore", {
		description = S("Legendary ore"),
		tiles = {"default_stone.png^legendary_ore_ore.png"},
		groups = {cracky = 3},
		sounds = default_stone_sounds,
			light_source = 7,
		drop = "legendary_armor:ingot",
	})
else
	minetest.register_node("legendary_ore:legendary_ore", {
		description = S("Legendary ore"),
		tiles = {"default_stone.png^legendary_ore_ore.png"},
		groups = {cracky = 3},
		sounds = default_stone_sounds,
			light_source = 7,
		drop = "legendary_ore:legendary_ore",
	})
end


-- Mapgen 
--Spin off of gemstones mapgen

      minetest.register_ore({
	          ore_type       = "scatter",
	          ore            = "legendary_ore:legendary_ore",
	          wherein        = "default:stone",
	          clust_scarcity = 65 * 65 * 65,
	          clust_num_ores = 2,
	          clust_size     = 2,
	          y_max          = -450,
	          y_min          = -31000,
	   })
