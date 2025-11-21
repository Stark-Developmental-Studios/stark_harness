# Acknowledgements

## MannyOnBrazzers
I would like to thank the original developer for creating an excellent script for QBCore that allows players to utilize a persisent harness in their personal vehicles.

## SneakEOne
I would like to thank fellow FiveM developer, SneakEOne, for his help, guidance, suggestions, and more with my updating of his script to support more than one resource, allowing for more widespread use across all of FiveM.

## QBCore
I would like to thank the developers of QBCore for creating a solid RP framework for FiveM servers that allows for easy development of scripts to enhance gameplay.

## Qbox
I would also like to thank the developers of Qbox for creating a solid, alternative RP framework for FiveM servers that allows for easy development of scripts to enhance gameplay.

## Overextended
I would like to thank the amazing developers at Overextended for creating stellar resources in both Ox Inventory and Ox Lib.

## Community Ox
I would like to thank the team at Community Ox for continuing on with Overextended's legacy by maintaining their resources for future use with FiveM development.

## Lation
I would like to thank Lation for developing a clean and sophisticated UI interface for FiveM which I am proud to directly support in this resource.

Lation's UI interface can be purchased here from his Tebex!

* Link: [Lation Modern UI](https://lationscripts.com/product/modern-ui).

# Description
Stark Harness is a resource that allows for a persisent safety harness in all personally owned player vehicles.

## Installation
1. Add stark_harness to your resources folder for your server
2. Be sure to remove the '-main' from the end of the folder name
3. Customize the script to your liking in the Config!
4. Add ```setr ox:locale en``` to your server.cfg
5. Add ```ensure stark_harness``` to your server.cfg
6. Restart your server and enjoy!!

# Further Installation Steps
For your convenience, an amended version of ```qb-smallresources/client/seatbelt.lua``` has been provided for installation purposes for this resource. Please see the included **install** folder for this file & the item images and code for your server's inventory script!

## QB-Smallresources
1. In ```qb-smallresources/client/seatbelt.lua```, locate the following event: ```'seatbelt:client:UseHarness'```.

Replace it with the following snippet of code:
```lua
RegisterNetEvent('seatbelt:client:UseHarness', function(ItemData) -- On Item Use (registered server side)
    local ped = PlayerPedId()
    local inVeh = IsPedInAnyVehicle(ped, false)
    local class = GetVehicleClass(GetVehiclePedIsUsing(ped))
    if inVeh and class ~= 8 and class ~= 13 and class ~= 14 then
        if not harnessOn then
            LocalPlayer.state:set("inv_busy", true, true)
            QBCore.Functions.Progressbar("harness_equip", Lang:t('seatbelt.use_harness_progress'), 5000, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                LocalPlayer.state:set("inv_busy", false, true)
                toggleHarness()
                if updateInfo then TriggerServerEvent('equip:harness', ItemData) end
            end)
            if updateInfo then
                harnessHp = ItemData.info.uses
                harnessData = ItemData
                TriggerEvent('hud:client:UpdateHarness', harnessHp)
            end
        else
            harnessOn = false
            toggleSeatbelt()
        end
    else
        QBCore.Functions.Notify(Lang:t('seatbelt.no_car'), 'error')
    end
end)
```

2. In ```qb-smallresources/client/seatbelt.lua```, locate the following command: ```'toggleseatbelt'```.

Replace it with the following snippet of code:

```lua
RegisterCommand('toggleseatbelt', function()
    if not IsPedInAnyVehicle(PlayerPedId(), false) or IsPauseMenuActive() then return end
    local class = GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId()))
    if class == 8 or class == 13 or class == 14 then return end
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = QBCore.Functions.GetPlate(vehicle)
    TriggerServerEvent('stark_harness:server:toggleSeatbelt', plate)
end, false)

RegisterKeyMapping('toggleseatbelt', 'Toggle Seatbelt', 'keyboard', 'B')
```

3. In ```qb-smallresources/client/seatbelt.lua```, add the following event after ```'seatbelt:client:UseHarness'```:

```lua
RegisterNetEvent('seatbelt:client:UseSeatbelt', function()
    toggleSeatbelt()
end)
```

4. In ```qb-smallresources/client/seatbelt.lua```, replace the following lines

```lua
harnessHp -= 1
TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
```

with the following snippet of code:

```lua
TriggerServerEvent('stark_harness:server:damageHarness', -1)
```

For reference, the following lines should be changed if using the latest version of qb-smallresources: 129, 139, 151, and 161.

5. In ```qb-smallresources/server/main.lua```, locate the following:

```lua
QBCore.Functions.CreateUseableItem('harness', function(source, item)
    TriggerClientEvent('seatbelt:client:UseHarness', source, item)
end)
```

and replace it with the following snippet of code:

```lua
QBCore.Functions.CreateUseableItem('harness', function(source, item)
    TriggerClientEvent('stark_harness:client:installHarness', source, item)
end)
```

6. If you want to add a special harness removal tool, add the following snippet of code to ```qb-smallresources/server/main.lua``` after the harness useable item:

```lua
QBCore.Functions.CreateUseableItem('removal_tool', function(source, item)
    TriggerClientEvent('stark_harness:client:removeHarness', source, item)
end)
```

7. You must run the provided harness.sql in your server's database to ensure successful operation of the script. OR you may execute the following qwery in your server's database:

```sql
ALTER TABLE player_vehicles ADD COLUMN `harness` VARCHAR(50) NULL;
```

8. If you would like to have the option to exit your vehicle without first undoing the seatbelt or harness, in ```qb-smallresources/client/seatbelt.lua```, locate ```function SeatBeltLoop()``` and replace it with the following snippet of code:

```lua
function SeatBeltLoop()
    CreateThread(function()
        while true do
            sleep = 1000
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                sleep = 0
                if seatbeltOn or harnessOn then
                    if IsControlJustPressed(0, 75) then
                        seatbeltOn = false
                        harnessOn = false
                    end
                end
            else
                seatbeltOn = false
                harnessOn = false
            end
            Wait(sleep)
        end
    end)
end
```

# Features
1. A Persisent Vehicle Harness For All Player Owned Vehicles
2. An Optional Harness Removal Tool
3. Either the Vehicle Owner or a Mechanic May Install or Remove the Harness

# Supported Frameworks
1. QBCore
2. Qbox (COMING SOON!)

# Supported Inventories
1. qb-inventory
2. ps-inventory
3. ox_inventory

# Dependencies
1. ox_lib
2. oxmysql
3. qb-smallresources (QBCore)
4. qbx_seatbelt (Qbox)
