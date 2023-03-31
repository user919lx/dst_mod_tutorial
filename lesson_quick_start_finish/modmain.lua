PrefabFiles = { 
    "lotus_umbrella", -- 让Mod加载lotus_umbrella定义文件
}


-- 一些预设置，防止系统报错
env.RECIPETABS = GLOBAL.RECIPETABS 
env.TECH = GLOBAL.TECH


-- AddRecipe已过期，现在请使用AddRecipe2
-- AddRecipe2是官方提供的MOD API，专门用于Mod环境，参数非常多，和scripts/recipe.lua里的Recipe2一致。
-- Recipe2(name, ingredients, tech, config)
-- 参数说明如下
-- name = prefab名。
-- ingredients = 配方表，用{}框起来，里面每一项配方是一个Ingredient。例子中
-- Ingredient("{prefab_name}", num), 两个参数分别是prefab名和数量
-- 本Mod的例子，可以用一个干草+一个树枝制作
-- tect = 所需科技，TECH.NONE 表明不需要科技，随时都可以制造。
-- config = 其它参数选项，是一个表
-- config: {
--     placer: unknown, 放置物prefab，用于显示一个建筑的临时放置物，在放下建筑后就会消失
--     min_spacing: unknown, 最小间距
--     nounlock: unknown, 是否锁定，锁定时，只能在对应的科技建筑旁建造
--     numtogive: unknown, 给几个制作物
--     builder_tag: unknown, 要求具备的制作者标签。如果人物没有此标签，便无法制作物品，可以用于人物的专属物品。
--     atlas: unknown, 图片文档路径，用于制作栏显示图片
--     image: unknown, 图片文件路径，其实atlas中有包含，不必再填
--     testfn: unknown, 放置时的检测函数，比如有些建筑对地形有特殊要求，可以使用此函数检测
--     product: unknown, 产出物
--     build_mode: unknown, 建造模式，无限制/地上/水上
--     build_distance: unknown, 建造距离，
-- }

local config = {
    atlas = "images/inventoryimages/lotus_umbrella.xml",
}

AddRecipe2("lotus_umbrella", {Ingredient("cutgrass", 1), Ingredient("twigs", 1)}, TECH.NONE, config)

env.STRINGS = GLOBAL.STRINGS -- 预设置
STRINGS.NAMES.LOTUS_UMBRELLA = "荷叶伞" -- 物体在游戏中显示的名字
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LOTUS_UMBRELLA = "这伞能挡雨吗？" -- 物体的检查描述
STRINGS.RECIPE_DESC.LOTUS_UMBRELLA = "荷叶做的雨伞" -- 物体的制作栏描述