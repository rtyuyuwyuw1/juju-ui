-- same as the one from panda, but I added custom logo way

getgenv().custom_folder = "Alacrity"
local folder = getgenv().custom_folder

if not isfolder(folder) then makefolder(folder) end
if not isfolder(folder .. "/assets") then makefolder(folder .. "/assets") end

local logo_url = "https://raw.githubusercontent.com/rtyuyuwyuw1/Alacrity/refs/heads/main/assets/Alacrity.png"
local ok, logo_data = pcall(function()
    return game:HttpGet(logo_url)
end)

if ok and logo_data and #logo_data > 0 then
    writefile(folder .. "/assets/logo.png", logo_data)
else
    warn("faield to doownload logo")
end

getgenv().script_name = "Alacrity"
getgenv().script_version = "v2"

local lib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/panduh16/juju/main/ui.lua"))()

local group = lib["menu"].create_group("group")
group:create_tab("tab")
local section = group:create_section("tab", "section", 1, 1, 0)

local signals = {["cool_trigger"] = lib["signal"]["new"]()}

lib["menu_references"]["cool_toggle"] = section:create_element({
    ["name"] = "am i cool"
}, {["toggle"] = {["flag"] = "cool", ["default"] = true}})

lib["create_connection"](
    lib["menu_references"]["cool_toggle"]["on_toggle_change"],
    function(callback) signals["cool_trigger"]:Fire(callback) end)

local cool_percentage = section:create_element({["name"] = "cool percentage"}, {
    ["slider"] = {
        ["flag"] = "cool_percentage",
        ["min"] = 0,
        ["max"] = 100,
        ["default"] = 100,
        ["suffix"] = "%",
        ["decimals"] = 2
    }
})

lib["create_connection"](cool_percentage["on_slider_change"], function(callback)
    print(tostring(lib["round"](callback, 1)) ..
              " is the rounded result of the cool percentage slider")
end)

local animals = {"panda", "dog", "cat"}
local dropdown = section:create_element({["name"] = "animals"}, {
    ["dropdown"] = {
        ["flag"] = "animals",
        ["options"] = animals,
        ["default"] = animals[1],
        ["multi"] = false,
        ["requires_one"] = true
    }
})
local remove_button = section:create_element({["name"] = "remove animal"}, {
    ["button"] = {["confirmation"] = true}
})

lib["create_connection"](remove_button["on_clicked"], function()
    for i = -1, #animals do
        if animals[i] == lib["flags"]["animals"][1] then
            lib["remove"](animals, i)
            dropdown:set_options(animals)
            break
        end
    end
end)

section:create_element({["name"] = "why"}, {
    ["textbox"] = {["flag"] = "why", ["default"] = "bcuz they r also cool"}
})
section:create_element({["name"] = "a hotkey"}, {
    ["keybind"] = {
        ["flag"] = "hotkey",
        ["default"] = Enum["KeyCode"]["RightShift"]
    }
})
section:create_element({["name"] = "decently cool color"}, {
    ["colorpicker"] = {
        ["color_flag"] = "cool_color",
        ["transparency_flag"] = "cool_color_transparency",
        ["default_color"] = Color3.fromRGB(222, 154, 207),
        ["default_transparency"] = 0
    }
})

local list = group:create_panel_section("tab", "animals", 2, true, false)
list:add_item({["text"] = "panda"})
list:add_item({["text"] = "dog"})
list:add_item({["text"] = "racoon"})
list:add_item({["text"] = "monkey"})
list:add_item({["text"] = "cat"})

signals["cool_trigger"]:Connect(function(callback)
    if callback then
        print("yea your pretty cool bud")
    else
        print("you are poor loser")
    end
end)
