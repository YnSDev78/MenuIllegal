ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

local isMenuOpen = false
local vda_menu = RageUI.CreateMenu("", "Choisissez votre catégorie : ")
vda_menu.Closed = function()
    isMenuOpen = false
end

function OpenVDAMenu()
    if not isMenuOpen then
        isMenuOpen = true
        RageUI.Visible(vda_menu, true)
        while isMenuOpen do
            RageUI.IsVisible(vda_menu, function()
                RageUI.Separator('↓ ~b~Pistolet~s~ ↓')
                for k,v in pairs(ConfigBlackMarket.Pistolet) do
                    RageUI.Button("~w~∑ ~b~→~s~ "..v.label..' | (~b~'..v.price..'~s~$)', nil, {RightBadge = RageUI.BadgeStyle.Armes}, true, {
                        onSelected = function()
                            TriggerServerEvent('vda:PaieWeapon', v.name, v.price)
                        end
                    })
                end
                RageUI.Separator('↓ ~b~SMG~s~ ↓')
                for k,v in pairs(ConfigBlackMarket.SMG) do
                    RageUI.Button("~w~∑ ~b~→~s~ "..v.label..' | (~b~'..v.price..'~s~$)', nil, {RightBadge = RageUI.BadgeStyle.Armes}, true, {
                        onSelected = function()
                            TriggerServerEvent('vda:PaieWeapon', v.name, v.price)
                        end
                    })
                end
                RageUI.Separator('↓ ~b~Fusil D\'assault~s~ ↓')
                for k,v in pairs(ConfigBlackMarket.Assault) do
                    RageUI.Button("~w~∑ ~b~→~s~ "..v.label..' | (~b~'..v.price..'~s~$)', nil, {RightBadge = RageUI.BadgeStyle.Armes}, true, {
                        onSelected = function()
                            TriggerServerEvent('vda:PaieWeapon', v.name, v.price)
                        end
                    })
                end
            end)
            Wait(1)
        end
    end
end

CreateThread(function()
    while true do
        local interval = 750
        local player = PlayerPedId()
        local plyPos = GetEntityCoords(player)
        for _, v in pairs(ConfigBlackMarket.Pos) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == ConfigBlackMarket.NameJob then
                local distance = #(plyPos - v.pos)
                if distance <= 8.5 then
                    interval = 0    
                    DrawMarker(25, v.pos, vector3(0.0, 0.0, 0.0), vector3(0.0, 180.0, 0.0), vector3(0.8, 0.8, 0.8), 255, 255, 255, 999, false, false, 8, false)
                    if distance <= 1.5 then
                        Visual.Subtitle(v.message, 5)
                        if IsControlJustPressed(1, 51) then
                            OpenVDAMenu()  
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)