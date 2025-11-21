---@diagnostic disable: lowercase-global

if not lib.checkDependency('ox_lib', '3.32.0', true) then return end

local Config = require 'shared.config'

local QBCore = exports['qb-core']:GetCoreObject()

local QBX = exports.qbx_core

RegisterNetEvent('stark_harness:client:installHarness', function(ItemData)
    local Player = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(Player, false)
    if GetPedInVehicleSeat(Vehicle, -1) == Player then
        local Class = GetVehicleClass(Vehicle)
        local plate = lib.getVehicleProperties(Vehicle).plate
        if Vehicle and Class ~= 8 and Class ~= 13 and Class ~= 14 then
            lib.callback('stark_harness:server:GetHarnessInfo', false, function(harnessInfo)
                if harnessInfo == nil then
                    if Config.Progress == 'qb' then
                        QBCore.Functions.Progressbar(locale('info.progress_name'), locale('info.progress_label'),
                            Config.InstallationTime, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- DONE
                                if exports['qb-smallresources']:HasSeatbeltOn() then
                                    TriggerEvent('seatbelt:client:UseSeatbelt')
                                end
                                if Config.Inventory == 'qb' then
                                    harnessUses = ItemData.info.uses
                                    harnessDamage = ItemData.info.damage
                                elseif Config.Inventory == 'ps' then
                                    harnessUses = ItemData.info.uses
                                    harnessDamage = ItemData.info.damage
                                elseif Config.Inventory == 'ox' then
                                    harnessUses = ItemData.metadata.uses
                                    harnessDamage = ItemData.metadata.damage
                                end
                                if harnessUses == nil then
                                    harnessUses = Config.HarnessUses
                                end

                                damage = 100

                                if harnessDamage ~= nil then
                                    damage = harnessDamage
                                else
                                    if Config.Inventory == 'qb' then
                                        ItemData.info.damage = damage
                                    elseif Config.Inventory == 'ps' then
                                        ItemData.info.damage = damage
                                    elseif Config.Inventory == 'ox' then
                                        ItemData.metadata.damage = damage
                                    end
                                end
                                installedHarnessInfo = { uses = harnessUses, damage = damage }
                                TriggerServerEvent('stark_harness:server:installHarness', installedHarnessInfo, plate)
                            end, function() -- CANCELLED
                                if Config.Notify == 'qb' then
                                    QBCore.Functions.Notify(locale('error.cancel_installation_description'), 'error')
                                elseif Config.Notify == 'ox' then
                                    lib.notify({
                                        title = locale('error.cancel_installation_title'),
                                        description = locale('error.cancel_installation_description'),
                                        position = 'center-right',
                                        type = 'error'
                                    })
                                elseif Config.Notify == 'lation' then
                                    exports.lation_ui:notify({
                                        title = locale('error.cancel_installation_title'),
                                        message = locale('error.cancel_installation_description'),
                                        type = 'error',
                                        position = 'center-right'
                                    })
                                end
                            end)
                    elseif Config.Progress == 'ox_bar' then
                        if lib.progressBar({
                                duration = Config.InstallationTime,
                                label = locale('info.progress_label'),
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    car = true,
                                    mouse = false,
                                    combat = true
                                }
                            }) then -- DONE
                            if exports['qb-smallresources']:HasSeatbeltOn() then
                                TriggerEvent('seatbelt:client:UseSeatbelt')
                            end
                            if Config.Inventory == 'qb' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ps' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ox' then
                                harnessUses = ItemData.metadata.uses
                                harnessDamage = ItemData.metadata.damage
                            end
                            if harnessUses == nil then
                                harnessUses = Config.HarnessUses
                            end

                            damage = 100

                            if harnessDamage ~= nil then
                                damage = harnessDamage
                            else
                                if Config.Inventory == 'qb' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ps' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ox' then
                                    ItemData.metadata.damage = damage
                                end
                            end
                            installedHarnessInfo = { uses = harnessUses, damage = damage }
                            TriggerServerEvent('stark_harness:server:installHarness', installedHarnessInfo, plate)
                        else -- CANCELLED
                            if Config.Notify == 'qb' then
                                QBCore.Functions.Notify(locale('error.cancel_installation_description'), 'error')
                            elseif Config.Notify == 'ox' then
                                lib.notify({
                                    title = locale('error.cancel_installation_title'),
                                    description = locale('error.cancel_installation_description'),
                                    position = 'center-right',
                                    type = 'error'
                                })
                            elseif Config.Notify == 'lation' then
                                exports.lation_ui:notify({
                                    title = locale('error.cancel_installation_title'),
                                    message = locale('error.cancel_installation_description'),
                                    type = 'error',
                                    position = 'center-right'
                                })
                            end
                        end
                    elseif Config.Progress == 'ox_circle' then
                        if lib.progressCircle({
                                duration = Config.InstallationTime,
                                label = locale('info.progress_label'),
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = {
                                    move = true,
                                    car = true,
                                    mouse = false,
                                    combat = true
                                }
                            }) then
                            if exports['qb-smallresources']:HasSeatbeltOn() then
                                TriggerEvent('seatbelt:client:UseSeatbelt')
                            end
                            if Config.Inventory == 'qb' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ps' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ox' then
                                harnessUses = ItemData.metadata.uses
                                harnessDamage = ItemData.metadata.damage
                            end
                            if harnessUses == nil then
                                harnessUses = Config.HarnessUses
                            end

                            damage = 100

                            if harnessDamage ~= nil then
                                damage = harnessDamage
                            else
                                if Config.Inventory == 'qb' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ps' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ox' then
                                    ItemData.metadata.damage = damage
                                end
                            end
                            installedHarnessInfo = { uses = harnessUses, damage = damage }
                            TriggerServerEvent('stark_harness:server:installHarness', installedHarnessInfo, plate)
                        else
                            if Config.Notify == 'qb' then
                                QBCore.Functions.Notify(locale('error.cancel_installation_description'), 'error')
                            elseif Config.Notify == 'ox' then
                                lib.notify({
                                    title = locale('error.cancel_installation_title'),
                                    description = locale('error.cancel_installation_description'),
                                    position = 'center-right',
                                    type = 'error'
                                })
                            elseif Config.Notify == 'lation' then
                                exports.lation_ui:notify({
                                    title = locale('error.cancel_installation_title'),
                                    message = locale('error.cancel_installation_description'),
                                    type = 'error',
                                    position = 'center-right'
                                })
                            end
                        end
                    elseif Config.Progress == 'lation' then
                        if exports.lation_ui:progressBar({
                                label = locale('info.progress_label'),
                                duration = Config.InstallationTime,
                                icon = 'fas fa-wrench',
                                iconColor = '#FFFFFF',
                                color = '#0000FF',
                                -- steps = {}, -- FEATURE COMING SOON
                                canCancel = true,
                                useWhileDead = false,
                                disable = {
                                    move = true,
                                    sprint = true,
                                    car = true,
                                    combat = true,
                                    mouse = false
                                }
                            }) then
                            if exports['qb-smallresources']:HasSeatbeltOn() then
                                TriggerEvent('seatbelt:client:UseSeatbelt')
                            end
                            if Config.Inventory == 'qb' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ps' then
                                harnessUses = ItemData.info.uses
                                harnessDamage = ItemData.info.damage
                            elseif Config.Inventory == 'ox' then
                                harnessUses = ItemData.metadata.uses
                                harnessDamage = ItemData.metadata.damage
                            end
                            if harnessUses == nil then
                                harnessUses = Config.HarnessUses
                            end

                            damage = 100

                            if harnessDamage ~= nil then
                                damage = harnessDamage
                            else
                                if Config.Inventory == 'qb' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ps' then
                                    ItemData.info.damage = damage
                                elseif Config.Inventory == 'ox' then
                                    ItemData.metadata.damage = damage
                                end
                            end
                            installedHarnessInfo = { uses = harnessUses, damage = damage }
                            TriggerServerEvent('stark_harness:server:installHarness', installedHarnessInfo, plate)
                        else
                            if Config.Notify == 'qb' then
                                QBCore.Functions.Notify(locale('error.cancel_installation_description'), 'error')
                            elseif Config.Notify == 'ox' then
                                lib.notify({
                                    title = locale('error.cancel_installation_title'),
                                    description = locale('error.cancel_installation_description'),
                                    position = 'center-right',
                                    type = 'error'
                                })
                            elseif Config.Notify == 'lation' then
                                exports.lation_ui:notify({
                                    title = locale('error.cancel_installation_title'),
                                    message = locale('error.cancel_installation_description'),
                                    type = 'error',
                                    position = 'center-right'
                                })
                            end
                        end
                    end
                else
                    if Config.Notify == 'qb' then
                        QBCore.Functions.Notify(locale('error.installation_error_description'), 'error')
                    elseif Config.Notify == 'ox' then
                        lib.notify({
                            title = locale('error.installlation_error_title'),
                            description = locale('error.installation_error_description'),
                            position = 'center-right',
                            type = 'error'
                        })
                    elseif Config.Notify == 'lation' then
                        exports.lation_ui:notify({
                            title = locale('error.installlation_error_title'),
                            message = locale('error.installation_error_description'),
                            type = 'error',
                            position = 'center-right'
                        })
                    end
                end
            end, plate)
        end
    else
        if Config.Notify == 'qb' then
            QBCore.Functions.Notify(locale('error.driver_seat_error_description'), 'error')
        elseif Config.Notify == 'ox' then
            lib.notify({
                title = locale('error.driver_seat_error_title'),
                description = locale('error.driver_seat_error_description'),
                position = 'center-right',
                type = 'error'
            })
        elseif Config.Notify == 'lation' then
            exports.lation_ui:notify({
                title = locale('error.driver_seat_error_title'),
                message = locale('error.driver_seat_error_description'),
                type = 'error',
                position = 'center-right'
            })
        end
    end
end)

RegisterNetEvent('stark_harness:client:removeHarness', function()
    local Player = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(Player, false)
    if GetPedInVehicleSeat(Vehicle, -1) == Player then
        local plate = lib.getVehicleProperties(Vehicle).plate
        lib.callback('stark_harness:server:GetHarnessInfo', false, function(harnessInfo)
            if harnessInfo ~= nil then
                if Config.Progress == 'qb' then
                    QBCore.Functions.Progressbar(locale('info.uninstall_progress_name'),
                        locale('info.uninstall_progress_label'), Config.InstallationTime, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }, {}, {}, {}, function() -- DONE
                            TriggerServerEvent('stark_harness:server:removeHarness', plate)
                        end, function()       -- CANCELLED
                            if Config.Notify == 'qb' then
                                QBCore.Functions.Notify(locale('error.cancel_removal_description'), 'error')
                            elseif Config.Notify == 'ox' then
                                lib.notify({
                                    title = locale('error.cancel_removal_title'),
                                    description = locale('error.cancel_removal_description'),
                                    position = 'center-right',
                                    type = 'error'
                                })
                            elseif Config.Notify == 'lation' then
                                exports.lation_ui:notify({
                                    title = locale('error.cancel_removal_title'),
                                    message = locale('error.cancel_removal_description'),
                                    type = 'error',
                                    position = 'center-right'
                                })
                            end
                        end)
                elseif Config.Progress == 'ox_bar' then
                    if lib.progressBar({
                            duration = Config.InstallationTime,
                            label = locale('info.uninstall_progress_label'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            }
                        }) then
                        TriggerServerEvent('stark_harness:server:removeHarness', plate)
                    else
                        if Config.Notify == 'qb' then
                            QBCore.Functions.Notify(locale('error.cancel_removal_description'), 'error')
                        elseif Config.Notify == 'ox' then
                            lib.notify({
                                title = locale('error.cancel_removal_title'),
                                description = locale('error.cancel_removal_description'),
                                position = 'center-right',
                                type = 'error'
                            })
                        elseif Config.Notify == 'lation' then
                            exports.lation_ui:notify({
                                title = locale('error.cancel_removal_title'),
                                message = locale('error.cancel_removal_description'),
                                type = 'error',
                                position = 'center-right'
                            })
                        end
                    end
                elseif Config.Progress == 'ox_circle' then
                    if lib.progressCircle({
                            duration = Config.InstallationTime,
                            label = locale('info.uninstall_progress_label'),
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            }
                        }) then
                        TriggerServerEvent('stark_harness:server:removeHarness', plate)
                    else
                        if Config.Notify == 'qb' then
                            QBCore.Functions.Notify(locale('error.cancel_removal_description'), 'error')
                        elseif Config.Notify == 'ox' then
                            lib.notify({
                                title = locale('error.cancel_removal_title'),
                                description = locale('error.cancel_removal_description'),
                                position = 'center-right',
                                type = 'error'
                            })
                        elseif Config.Notify == 'lation' then
                            exports.lation_ui:notify({
                                title = locale('error.cancel_removal_title'),
                                message = locale('error.cancel_removal_description'),
                                type = 'error',
                                position = 'center-right'
                            })
                        end
                    end
                elseif Config.Progress == 'lation' then
                    if exports.lation_ui:progressBar({
                            label = locale('info.uninstall_progress_label'),
                            duration = Config.InstallationTime,
                            icon = 'fas fa-wrench',
                            iconColor = '#FFFFFF',
                            color = '#0000FF',
                            -- steps = {}, -- FEATURE COMING SOON
                            canCancel = true,
                            useWhileDead = false,
                            disable = {
                                move = true,
                                sprint = true,
                                car = true,
                                combat = true,
                                mouse = false
                            }
                        }) then
                        TriggerServerEvent('stark_harness:server:removeHarness', plate)
                    else
                        if Config.Notify == 'qb' then
                            QBCore.Functions.Notify(locale('error.cancel_removal_description'), 'error')
                        elseif Config.Notify == 'ox' then
                            lib.notify({
                                title = locale('error.cancel_removal_title'),
                                description = locale('error.cancel_removal_description'),
                                position = 'center-right',
                                type = 'error'
                            })
                        elseif Config.Notify == 'lation' then
                            exports.lation_ui:notify({
                                title = locale('error.cancel_removal_title'),
                                message = locale('error.cancel_removal_description'),
                                type = 'error',
                                position = 'center-right'
                            })
                        end
                    end
                end
            else
                if Config.Notify == 'qb' then
                    QBCore.Functions.Notify(locale('error.removal_error_description'), 'error')
                elseif Config.Notify == 'ox' then
                    lib.notify({
                        title = locale('error.removal_error_title'),
                        description = locale('error.removal_error_description'),
                        position = 'center-right',
                        type = 'error'
                    })
                elseif Config.Notify == 'lation' then
                    exports.lation_ui:notify({
                        title = locale('error.removal_error_title'),
                        message = locale('error.removal_error_description'),
                        type = 'error',
                        position = 'center-right'
                    })
                end
            end
        end, plate)
    else
        if Config.Notify == 'qb' then
            QBCore.Functions.Notify(locale('error.driver_seat_removal_error_description'), 'error')
        elseif Config.Notify == 'ox' then
            lib.notify({
                title = locale('error.driver_seat_removal_error_title'),
                description = locale('error.driver_seat_removal_error_description'),
                position = 'center-right',
                type = 'error'
            })
        elseif Config.Notify == 'lation' then
            exports.lation_ui:notify({
                title = locale('error.driver_seat_removal_error_title'),
                message = locale('driver_seat_removal_error_description'),
                type = 'error',
                position = 'center-right'
            })
        end
    end
end)
