---@diagnostic disable: lowercase-global

if not lib.checkDependency('ox_lib', '3.32.0', true) then return end

local Config = require 'shared.config'

if Config.VersionCheck then
    lib.versionCheck('AdamaStark-N7/stark_harness')
end

-- local QBCore = exports['qb-core']:GetCoreObject()

local QBX = exports.qbx_core

lib.callback.register('stark_harness:server:GetHarnessInfo', function(source, plate, harnessInfo)
    if plate == nil then return end
    local harnessInfo = hasHarness(plate)
    return harnessInfo
end)

function hasHarness(plate)
    local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
    harnessInfo = nil
    if result ~= nil then
        if #(result) > 0 then
            harnessInfo = json.decode(result[1].harness)
        end
    end
    return harnessInfo
end

RegisterNetEvent('stark_harness:server:installHarness', function(harnessInfo, plate)
    local src = source
    if plate == nil then return end
    -- local Player = QBCore.Functions.GetPlayer(src)
    local Player = QBX:GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
    if result ~= nil and #(result) > 0 then
        if not Config.MechanicOnly then
            if harnessInfo ~= nil then
                MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { json.encode(harnessInfo), plate })
                if Config.Inventory == 'qb' then
                    exports['qb-inventory']:RemoveItem(src, 'harness', 1, false)
                elseif Config.Inventory == 'ps' then
                    exports['ps-inventory']:RemoveItem(src, 'harness', 1, false)
                elseif Config.Inventory == 'ox' then
                    local ox_inventory = exports.ox_inventory
                    ox_inventory:RemoveItem(src, 'harness', 1)
                end
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('info.successful_install_description'), 'success')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('info.successful_install_title'),
                        description = locale('info.successful_install_description'),
                        position = 'center-right',
                        type = 'success'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('info.successful_install_title'),
                        message = locale('info.successful_install_description'),
                        type = 'success',
                        position = 'center-right'
                    })
                end
            end
        else
            if (result[1].citizenid == Player.PlayerData.citizenid) then
                if harnessInfo ~= nil then
                    MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { json.encode(harnessInfo), plate })
                    if Config.Inventory == 'qb' then
                        exports['qb-inventory']:RemoveItem(src, 'harness', 1, false)
                    elseif Config.Inventory == 'ps' then
                        exports['ps-inventory']:RemoveItem(src, 'harness', 1, false)
                    elseif Config.Inventory == 'ox' then
                        local ox_inventory = exports.ox_inventory
                        ox_inventory:RemoveItem(src, 'harness', 1)
                    end
                    if Config.Notify == 'qb' then
                        TriggerClientEvent('QBCore:Notify', src, locale('info.successful_install_description'), 'success')
                    elseif Config.Notify == 'ox' then
                        TriggerClientEvent('ox_lib:notify', src, {
                            title = locale('info.successful_install_title'),
                            description = locale('info.successful_install_description'),
                            position = 'center-right',
                            type = 'success'
                        })
                    elseif Config.Notify == 'lation' then
                        TriggerClientEvent('lation_ui:notify', src, {
                            title = locale('info.successful_install_title'),
                            message = locale('info.successful_install_description'),
                            type = 'success',
                            position = 'center-right'
                        })
                    end
                end
            elseif (Player.PlayerData.job.type == Config.MechanicJobType) then
                if harnessInfo ~= nil then
                    MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { json.encode(harnessInfo), plate })
                    if Config.Inventory == 'qb' then
                        exports['qb-inventory']:RemoveItem(src, 'harness', 1, false)
                    elseif Config.Inventory == 'ps' then
                        exports['ps-inventory']:RemoveItem(src, 'harness', 1, false)
                    elseif Config.Inventory == 'ox' then
                        local ox_inventory = exports.ox_inventory
                        ox_inventory:RemoveItem(src, 'harness', 1)
                    end
                    if Config.Notify == 'qb' then
                        TriggerClientEvent('QBCore:Notify', src, locale('info.successful_install_description'), 'success')
                    elseif Config.Notify == 'ox' then
                        TriggerClientEvent('ox_lib:notify', src, {
                            title = locale('info.successful_install_title'),
                            description = locale('info.successful_install_description'),
                            position = 'center-right',
                            type = 'success'
                        })
                    elseif Config.Notify == 'lation' then
                        TriggerClientEvent('lation_ui:notify', src, {
                            title = locale('info.successful_install_title'),
                            message = locale('info.successful_install_description'),
                            type = 'success',
                            position = 'center-right'
                        })
                    end
                end
            else
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('error.unsuccessful_install_description'), 'error')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src {
                        title = locale('error.unsuccessful_install_title'),
                        description = locale('error.unsuccessful_install_description'),
                        position = 'center-right',
                        type = 'error'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('error.unsuccessful_install_title'),
                        message = locale('error.unsuccessful_install_description'),
                        type = 'error',
                        position = 'center-right',
                    })
                end
            end
        end
    elseif #(result) <= 0 then
        if Config.Notify == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, locale('error.unsuccessful_install_description'), 'error')
        elseif Config.Notify == 'ox' then
            TriggerClientEvent('ox_lib:notify', src {
                title = locale('error.unsuccessful_install_title'),
                description = locale('error.unsuccessful_install_description'),
                position = 'center-right',
                type = 'error'
            })
        elseif Config.Notify == 'lation' then
            TriggerClientEvent('lation_ui:notify', src, {
                title = locale('error.unsuccessful_install_title'),
                message = locale('error.unsuccessful_install_description'),
                type = 'error',
                position = 'center-right',
            })
        end
    else
        if Config.Notify == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, locale('error.installation_error_description'), 'error')
        elseif Config.Notify == 'ox' then
            TriggerClientEvent('ox_lib:notify', src, {
                title = locale('error.installlation_error_title'),
                description = locale('error.installation_error_description'),
                position = 'center-right',
                type = 'error'
            })
        elseif Config.Notify == 'lation' then
            TriggerClientEvent('lation_ui:notify', src, {
                title = locale('error.installlation_error_title'),
                message = locale('error.installation_error_description'),
                type = 'error',
                position = 'center-right',
            })
        end
    end
end)

RegisterNetEvent('stark_harness:server:removeHarness', function(plate)
    local src = source
    if plate == nil then return end
    -- local Player = QBCore.Functions.GetPlayer(src)
    local Player = QBX:GetPlayer(src)
    local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
    if result ~= nil and #(result) > 0 then
        if (result[1].citizenid == Player.PlayerData.citizenid) then
            if (result[1].harness) ~= nil then
                MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { NULL, plate })
                local harnessInfo = json.decode(result[1].harness)
                local data = {}
                if harnessInfo.uses == nil then harnessInfo.uses = 20 end
                data = {
                    uses = harnessInfo.uses,
                    damage = harnessInfo.damage
                }
                if Config.Inventory == 'qb' then
                    exports['qb-inventory']:AddItem(src, 'harness', 1, false, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        exports['qb-inventory']:RemoveItem(src, 'removal_tool', 1, false)
                    end
                elseif Config.Inventory == 'ps' then
                    exports['ps-inventory']:AddItem(src, 'harness', 1, false, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        exports['ps-inventory']:RemoveItem(src, 'removal_tool', 1, false)
                    end
                elseif Config.Inventory == 'ox' then
                    local ox_inventory = exports.ox_inventory
                    ox_inventory:AddItem(src, 'harness', 1, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        ox_inventory:RemoveItem(src, 'removal_tool', 1)
                    end
                end
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('info.successful_removal_description'), 'success')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('info.successful_removal_title'),
                        description = locale('info.successful_removal_description'),
                        position = 'center-right',
                        type = 'success'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('info.successful_removal_title'),
                        message = locale('info.successful_removal_description'),
                        type = 'success',
                        position = 'center-right',
                    })
                end
            else
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('error.unsuccessful_removal_description'), 'error')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('error.unsuccessful_removal_title'),
                        description = locale('error.unsuccessful_removal_description'),
                        position = 'center-right',
                        type = 'error'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('error.unsuccessful_removal_title'),
                        message = locale('error.unsuccessful_removal_description'),
                        type = 'error',
                        position = 'center-right',
                    })
                end
            end
        elseif (Player.PlayerData.job.type == Config.MechanicJobType) then
            if (result[1].harness) ~= nil then
                MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { NULL, plate })
                local harnessInfo = json.decode(result[1].harness)
                local data = {}
                if harnessInfo.uses == nil then harnessInfo.uses = 20 end
                data = {
                    uses = harnessInfo.uses,
                    damage = harnessInfo.damage
                }
                if Config.Inventory == 'qb' then
                    exports['qb-inventory']:AddItem(src, 'harness', 1, false, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        exports['qb-inventory']:RemoveItem(src, 'removal_tool', 1, false)
                    end
                elseif Config.Inventory == 'ps' then
                    exports['ps-inventory']:AddItem(src, 'harness', 1, false, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        exports['ps-inventory']:RemoveItem(src, 'removal_tool', 1, false)
                    end
                elseif Config.Inventory == 'ox' then
                    local ox_inventory = exports.ox_inventory
                    ox_inventory:AddItem(src, 'harness', 1, data)
                    if Config.RemoveWithItem then
                        Wait(3000)
                        ox_inventory:RemoveItem(src, 'removal_tool', 1)
                    end
                end
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('info.successful_removal_description'), 'success')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('info.successful_removal_title'),
                        description = locale('info.successful_removal_description'),
                        position = 'center-right',
                        type = 'success'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('info.successful_removal_title'),
                        message = locale('info.successful_removal_description'),
                        type = 'success',
                        position = 'center-right',
                    })
                end
            else
                if Config.Notify == 'qb' then
                    TriggerClientEvent('QBCore:Notify', src, locale('error.unsuccessful_mechanic_removal_description'),
                        'error')
                elseif Config.Notify == 'ox' then
                    TriggerClientEvent('ox_lib:notify', src, {
                        title = locale('error.unsuccessful_mechanic_removal_title'),
                        description = locale('error.unsuccessful_mechanic_removal_description'),
                        position = 'center-right',
                        type = 'error'
                    })
                elseif Config.Notify == 'lation' then
                    TriggerClientEvent('lation_ui:notify', src, {
                        title = locale('error.unsuccessful_mechanic_removal_title'),
                        message = locale('error.unsuccessful_mechanic_removal_description'),
                        type = 'error',
                        position = 'center-right',
                    })
                end
            end
        end
    end
end)

RegisterNetEvent('stark_harness:server:damageHarness', function(damage, plate)
    local src = source
    if plate == nil then
        local Player = GetPlayerPed(src)
        local Vehicle = GetVehiclePedIsIn(Player, false)
        plate = GetVehicleNumberPlateText(Vehicle)
    end
    if plate == nil then return end
    local result = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', { plate })
    if result ~= nil and #(result) > 0 then
        local harnessInfo = json.decode(result[1].harness)
        harnessInfo.damage = (harnessInfo.damage - math.abs(damage))
        if harnessInfo.damage <= 0 then
            MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { NULL, plate })
            if Config.Notify == 'qb' then
                TriggerClientEvent('QBCore:Notify', src, locale('error.harness_broke_description'), 'error')
            elseif Config.Notify == 'ox' then
                TriggerClientEvent('ox_lib:notify', src, {
                    title = locale('error.harness_broke_title'),
                    description = locale('error.harness_broke_description'),
                    position = 'center-right',
                    type = 'error'
                })
            elseif Config.Notify == 'lation' then
                TriggerClientEvent('lation_ui:notify', src, {
                    title = locale('error.harness_broke_title'),
                    message = locale('error.harness_broke_description'),
                    type = 'error',
                    position = 'center-right',
                })
            end
        else
            MySQL.update('UPDATE player_vehicles SET harness = ? WHERE plate = ?', { json.encode(harnessInfo), plate })
        end
    end
end)

RegisterNetEvent('stark_harness:server:toggleSeatbelt', function(plate, ItemData)
    local src = source
    if not src then return end
    local harnessInfo = hasHarness(plate)
    if harnessInfo == nil then
        return TriggerClientEvent('seatbelt:client:UseSeatbelt', src)
    end
    TriggerClientEvent('seatbelt:client:UseHarness', src, ItemData, false)
end)
