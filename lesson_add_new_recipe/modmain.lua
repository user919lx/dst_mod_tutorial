PrefabFiles = { 
    "lotus_umbrella", -- 让Mod加载lotus_umbrella定义文件
}
Assets = {
    Asset("ATLAS", "images/craft_samansha_icon.xml"),
}
-- 一些预设置，防止系统报错
env.RECIPETABS = GLOBAL.RECIPETABS 
env.TECH = GLOBAL.TECH
env.STRINGS = GLOBAL.STRINGS

-- 定义一个新的过滤器
local filter_samansha_def = {
    name = "SAMANSHA",
    atlas = "images/craft_samansha_icon.xml",
    image = "craft_samansha_icon.tex",
    image_size = 64,
}

-- 添加自定义过滤器
AddRecipeFilter(filter_samansha_def, 1)
STRINGS.UI.CRAFTING_FILTERS.SAMANSHA ="自定义过滤器" -- 制作栏中显示的名字

local config = {
    atlas = "images/inventoryimages/lotus_umbrella.xml",
}

AddRecipe2("lotus_umbrella", {Ingredient("cutgrass", 1), Ingredient("twigs", 1)}, TECH.NONE, config, {"SAMANSHA"})

-- 将荷叶伞放到「雨具」分类
AddRecipeToFilter("lotus_umbrella","RAIN")

-- 将斧头移出「工具」分类
RemoveRecipeFromFilter("axe", "TOOLS")

    -- 创建一个角色专属配方，只有可读书的人才能使用
    local config2 = {
        atlas = "images/inventoryimages/lotus_umbrella.xml",
        builder_tag = "reader",
        product = "lotus_umbrella", -- 当recipe名不是prefab名时，需要显式指定
    }
    AddCharacterRecipe("lotus_umbrella_few", {Ingredient("cutgrass", 1)}, TECH.NONE, config2, {"SAMANSHA"})


STRINGS.NAMES.LOTUS_UMBRELLA = "荷叶伞" -- 物体在游戏中显示的名字
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LOTUS_UMBRELLA = "这伞能挡雨吗？" -- 物体的检查描述
STRINGS.RECIPE_DESC.LOTUS_UMBRELLA = "荷叶做的雨伞" -- 物体的制作栏描述