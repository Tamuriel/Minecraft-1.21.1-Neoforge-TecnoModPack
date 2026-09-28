import crafttweaker.api.ingredient.IIngredient;

// Keep AdFinders' anonymous deposit pebbles, but remove its direct locator tools.
craftingTable.removeByName("adfinders:mineral_finder");
craftingTable.removeByName("adfinders:metal_finder");
craftingTable.removeByName("adfinders:gem_finder");

//Удаляю рецепты теста Farmer's Delight
craftingTable.removeByName("farmersdelight:wheat_dough_from_egg");
craftingTable.removeByName("farmersdelight:wheat_dough_from_water");
craftingTable.removeByName("veggiesdelight:sweet_potato_dough_from_eggs");
craftingTable.removeByName("veggiesdelight:sweet_potato_dough_from_water");
craftingTable.removeByName("createfood:minecraft/crafting/butter_dough_from_egg_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/butter_dough_from_wheat_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/chocolate_sugar_dough_egg_from_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/chocolate_sugar_dough_from_wheat_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/pumpernickel_dough_from_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/pumpernickel_dough_from_crafting_alt");
craftingTable.removeByName("createfood:minecraft/crafting/salt_dough_from_wheat_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/salt_dough_from_egg_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/sugar_dough_from_egg_crafting");
craftingTable.removeByName("createfood:minecraft/crafting/sugar_dough_from_wheat_crafting");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/wheat_dough_from_mixing_water_farmersdelight");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/butter_dough_from_mixing");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/butter_dough_from_mixing_water");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/chocolate_sugar_dough_from_mixing");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/chocolate_sugar_dough_from_mixing_water");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/pumpernickel_dough_from_mixing");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/pumpernickel_dough_from_mixing_water");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/salt_dough_from_mixing_water");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/salt_dough_from_mixing");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/sugar_dough_from_mixing");
<recipetype:create:mixing>.removeByName("createfood:create/mixing/sugar_dough_from_mixing_water");


//Удаляю рецепты хлеба 
craftingTable.removeByName("minecraft:bread");
craftingTable.removeByName("veggiesdelight:cauliflower_bread");

//Удаляю рецепты пирогов
craftingTable.removeByName("minecraft:pumpkin_pie");
craftingTable.removeByName("minecraft:cake");
craftingTable.removeByName("biomeswevegone:pumpkin_pie");
craftingTable.removeByName("farmersdelight:pie_crust");
craftingTable.removeByName("farmersdelight:apple_pie");
craftingTable.removeByName("farmersdelight:cake_from_milk_bottle");
craftingTable.removeByName("upgrade_aquatic:mulberry_pie");
craftingTable.removeByName("farmersdelight:chocolate_pie");
craftingTable.removeByName("veggiesdelight:carrot_cake");
craftingTable.removeByName("veggiesdelight:carrot_cake_from_slices");
craftingTable.removeByName("veggiesdelight:sweet_potato_pie");
craftingTable.removeByName("veggiesdelight:sweet_potato_pie_from_slices");
craftingTable.removeByName("create:crafting/curiosities/cake");
<recipetype:farmersdelight:cooking>.removeByName("veggiesdelight:cooking/cooking/turnip_cake");

//Удаляю рецепт котлеты 
craftingTable.removeByName("veggiesdelight:vegetarian_patty");

//Добавляю крутые рецепты теста из муки

//базовое
craftingTable.addShapeless("wheat_dough_from_egg", <item:farmersdelight:wheat_dough> * 3, [
    <tag:item:c:flours/wheat>,
    <tag:item:c:flours/wheat>, 
    <tag:item:c:flours/wheat>,
    <tag:item:c:eggs> ]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/wheat_dough_from_mixing_water_farmersdelight", 
{type: "create:mixing", ingredients: 
[{tag: "c:flours/wheat"}, 
{tag: "c:flours/wheat"},
{tag: "c:flours/wheat"},
{type: "neoforge:tag", amount: 1000, tag: "c:water"}], 
results: [{count: 3, id: "farmersdelight:wheat_dough"}]});


//сладкий картофель
craftingTable.addShapeless("veggiesdelight.sweet_potato_dough_from_eggs", <item:veggiesdelight:sweet_potato_dough> * 3, [<tag:item:c:crops/sweet_potato>, <tag:item:c:crops/sweet_potato>, <tag:item:c:flours/wheat>, <tag:item:c:eggs>]);
craftingTable.addShapeless("veggiesdelight.sweet_potato_dough_from_water", <item:veggiesdelight:sweet_potato_dough> * 3, [<tag:item:c:crops/sweet_potato>, <tag:item:c:crops/sweet_potato>, <tag:item:c:flours/wheat>, <tag:item:c:buckets/water>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/veggiesdelight.sweet_potato_dough_from_water", 
{type: "create:mixing", ingredients: 
[{tag: "c:crops/sweet_potato"}, 
{tag: "c:crops/sweet_potato"},
{tag: "c:flours/wheat"},
{type: "neoforge:tag", amount: 1000, tag: "c:water"}], 
results: [{count: 3, id: "veggiesdelight:sweet_potato_dough"}]});

//маслянное
craftingTable.addShapeless("createfood.minecraft/crafting/butter_dough_from_egg_crafting", <item:createfood:butter_dough> * 3, [<tag:item:c:eggs>, <tag:item:c:butter>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);
craftingTable.addShapeless("createfood.minecraft/crafting/butter_dough_from_wheat_crafting", <item:createfood:butter_dough> * 3, [<item:minecraft:water_bucket>, <tag:item:c:butter>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/butter_dough_from_mixing", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:butter"}, {tag: "c:eggs"}], results: [{count: 3, id: "createfood:butter_dough"}]});
<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/butter_dough_from_mixing_water", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:butter"}, {type: "neoforge:tag", amount: 1000, tag: "c:water"}], results: [{count: 3, id: "createfood:butter_dough"}]});

//шоколадное
craftingTable.addShapeless("createfood.minecraft/crafting/chocolate_sugar_dough_egg_from_crafting", <item:createfood:chocolate_sugar_dough> * 3, [<tag:item:c:eggs>, <tag:item:c:sugar>, <tag:item:c:cocoa_powder>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);
craftingTable.addShapeless("createfood.minecraft/crafting/chocolate_sugar_dough_from_wheat_crafting", <item:createfood:chocolate_sugar_dough> * 3, [<item:minecraft:water_bucket>, <tag:item:c:sugar>, <tag:item:c:cocoa_powder>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/chocolate_sugar_dough_from_mixing", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:sugar"}, {tag: "c:cocoa_powder"}, {tag: "c:eggs"}], results: [{count: 3, id: "createfood:chocolate_sugar_dough"}]});
<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/chocolate_sugar_dough_from_mixing_water", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:sugar"}, {tag: "c:cocoa_powder"}, {type: "neoforge:tag", amount: 1000, tag: "minecraft:water"}], results: [{count: 3, id: "createfood:chocolate_sugar_dough"}]});

//бородинское
craftingTable.addShapeless("createfood.minecraft/crafting/pumpernickel_dough_from_crafting", <item:createfood:pumpernickel_dough> * 3, [<tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:cocoa_powder>, <tag:item:c:molasses_bottle>, <item:minecraft:water_bucket>]);
craftingTable.addShapeless("createfood.minecraft/crafting/pumpernickel_dough_from_crafting_alt", <item:createfood:pumpernickel_dough> * 3, [<tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:cocoa_powder>, <tag:item:c:molasses_bottle>, <tag:item:c:eggs>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/pumpernickel_dough_from_mixing", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:cocoa_powder"}, {tag: "c:eggs"}, {type: "neoforge:tag", amount: 500, tag: "c:molasses"}], results: [{count: 3, id: "createfood:pumpernickel_dough"}]});
<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/pumpernickel_dough_from_mixing_water", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:cocoa_powder"}, {type: "neoforge:tag", amount: 500, tag: "c:molasses"}, {type: "neoforge:tag", amount: 1000, tag: "c:water"}], results: [{count: 3, id: "createfood:pumpernickel_dough"}]});

//солёное
craftingTable.addShapeless("createfood.minecraft/crafting/salt_dough_from_egg_crafting", <item:createfood:salt_dough> * 6, [<tag:item:c:eggs>, <tag:item:c:salt>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);
craftingTable.addShapeless("createfood.minecraft/crafting/salt_dough_from_wheat_crafting", <item:createfood:salt_dough> * 6, [<tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:salt>, <item:minecraft:water_bucket>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/salt_dough_from_mixing", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:salt"}, {tag: "c:eggs"}], results: [{count: 6, id: "createfood:salt_dough"}]});
<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/salt_dough_from_mixing_water", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:salt"}, {type: "neoforge:tag", amount: 1000, tag: "c:water"}], results: [{count: 6, id: "createfood:salt_dough"}]});

//сахарное
craftingTable.addShapeless("createfood.minecraft/crafting/sugar_dough_from_egg_crafting", <item:createfood:sugar_dough> * 3, [<tag:item:c:eggs>, <tag:item:c:sugar>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);
craftingTable.addShapeless("createfood.minecraft/crafting/sugar_dough_from_wheat_crafting", <item:createfood:sugar_dough> * 3, [<tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>, <tag:item:c:sugar>, <item:minecraft:water_bucket>]);

<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/sugar_dough_from_mixing", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:sugar"}, {tag: "c:eggs"}], results: [{count: 3, id: "createfood:sugar_dough"}]});
<recipetype:create:mixing>.addJsonRecipe("createfood.create/mixing/sugar_dough_from_mixing_water", {type: "create:mixing", ingredients: [{tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:flours/wheat"}, {tag: "c:sugar"}, {type: "neoforge:tag", amount: 1000, tag: "c:water"}], results: [{count: 3, id: "createfood:sugar_dough"}]});

//хлеб из капусты
craftingTable.addShapeless("veggiesdelight.cauliflower_bread", <item:veggiesdelight:cauliflower_bread>, [<tag:item:c:crops/cauliflower>, <tag:item:c:crops/cauliflower>, <tag:item:c:flours/wheat>]);

//вегетерианская котлета 
craftingTable.addShapeless("veggiesdelight.raw_vegetarian_patty", <item:veggiesdelight:raw_vegetarian_patty>, [<item:veggiesdelight:cauliflower> | <item:veggiesdelight:cauliflower_floret> | <item:minecraft:potato> | <item:veggiesdelight:sweet_potato> | <item:veggiesdelight:zucchini> | <item:veggiesdelight:zucchini_slice>, <tag:item:c:crops/onion>, <tag:item:c:flours/wheat>, <tag:item:c:flours/wheat>]);