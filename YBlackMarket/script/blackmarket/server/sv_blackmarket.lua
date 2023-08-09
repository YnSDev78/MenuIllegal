ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterNetEvent('vda:PaieWeapon')
AddEventHandler('vda:PaieWeapon', function(name, price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job2.name == ConfigBlackMarket.NameJob then
        if xPlayer.getAccount('cash').money >= tonumber(price) then
            xPlayer.removeAccountMoney('cash', tonumber(price))
            xPlayer.addInventoryItem(name, 1)
        else
            TriggerClientEvent('esx:showNotification', source, '[~r~Erreur~s~] Vous n\'avez pas assez d\'argent')
        end
        TriggerClientEvent('esx:showNotification', source, 'TU PEUX T F4L')
    else
        DropPlayer(source, '↓ StoryV Protect ↓\n\nTu ne peux pas te give ahahhaha 😂 🤣\nSi cela est un soucis merci d\'ouvrir un ticket : discord.gg/storyv')
    end
end)