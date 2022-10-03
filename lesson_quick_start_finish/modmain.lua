PrefabFiles = {
    "lotus_umbrella",
}


-- 一些预设置，防止系统报错
env.RECIPETABS = GLOBAL.RECIPETABS 
env.TECH = GLOBAL.TECH


-- AddRecipe是官方提供的MOD API，专门用在modmian.lua下的。参数非常多，和scripts/recipe.lua里的Recipe类的参数是一一对应的。
-- 第一个参数，prefab的名字。
-- 第二个参数，配方表，用{}框起来，里面每一项配方用一个Ingredient。Ingredient的第一个参数是具体的prefab名，第二个是数量，这里cutgrass和twigs分别是干草和树枝。这就表明荷叶伞可以用1干草1树枝制作出来。
-- 第三个参数，荷叶伞的归类，RECIPETABS.SURVIVAL表明归类到生存，也就是可以在生存栏里找到。
-- 第四个参数，荷叶伞需要的科技等级，TECH.NONE 表明不需要科技，随时都可以制造。
-- 后续5个参数都是nil，表明不需要这些参数，但需要占位置
-- 最后一个参数，指明图片文档地址，用于制作栏显示图片。
AddRecipe("lotus_umbrella", {Ingredient("cutgrass", 1), Ingredient("twigs", 1)}, RECIPETABS.SURVIVAL, TECH.NONE, nil, nil, nil, nil, nil,"images/inventoryimages/lotus_umbrella.xml") 

env.STRINGS = GLOBAL.STRINGS -- 预设置
STRINGS.NAMES.LOTUS_UMBRELLA = "荷叶伞" -- 物体在游戏中显示的名字
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LOTUS_UMBRELLA = "这伞能挡雨吗？" -- 物体的检查描述
STRINGS.RECIPE_DESC.LOTUS_UMBRELLA = "荷叶做的雨伞" -- 物体的制作栏描述