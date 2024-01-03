local pedModel                    = false
local playerPed                   = cache.ped
local ped                         = nil
local DrawMarker                  = DrawMarker
local IsEntityDead                = IsEntityDead
local IsControlJustPressed        = IsControlJustPressed
local AddBlipForCoord             = AddBlipForCoord
local SetBlipSprite               = SetBlipSprite
local SetBlipDisplay              = SetBlipDisplay
local SetBlipScale                = SetBlipScale
local SetBlipColour               = SetBlipColour
local SetBlipAsShortRange         = SetBlipAsShortRange
local BeginTextCommandSetBlipName = BeginTextCommandSetBlipName
local AddTextComponentString      = AddTextComponentString
local EndTextCommandSetBlipName   = EndTextCommandSetBlipName
local positions                   = {}



local function onEnter(self)
    if not self.ped then
        ped = utils.createPed(self.prostituta.pedModel, self.prostituta.pos)
        self.ped = ped

        lib.showTextUI(Krs.TextUi.interact, {
            position = Krs.TextUi.posinteract,
            icon = Krs.TextUi.iconiteract,
            style = { borderRadius = 0, backgroundColor = Krs.TextUi.bcColor, color = Krs.TextUi.colorText }
        })
       
    end
end

local function onExit(self)
    lib.hideTextUI()

    if self.ped and DoesEntityExist(self.ped) then
        local playerPed = cache.ped or PlayerPedId()
        local vehicle = GetVehiclePedIsIn(self.ped, false)
        
        if vehicle ~= 0 then
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        else
            DeletePed(self.ped)
        end

        self.ped = nil
    end
end


local function onNearby(self)
    local playerPed = cache.ped or PlayerPedId()
    local interactionDistance = 14
    if self.currentDistance < 10 and not IsEntityDead(self.ped) and IsControlJustPressed(0, 38) then
        TaskEnterVehicle(self.ped, GetVehiclePedIsIn(playerPed, false), -1, 0, 1.0, 1, 0)
        lib.showTextUI(Krs.TextUi.chatmessage, {
            position = Krs.TextUi.toptext,
            icon = Krs.TextUi.icon,
            style = {
                borderRadius = 0,
                backgroundColor = Krs.TextUi.bcColor,
                color = Krs.TextUi.colorText
            }
        })
        Citizen.Wait(11000)
        lib.hideTextUI()

        Citizen.Wait(5000)
        lib.showTextUI(Krs.TextUi.chatmenu, {
            position = Krs.TextUi.toptext,
            icon = Krs.TextUi.icon,
            style = {
                borderRadius = 0,
                backgroundColor = Krs.TextUi.bcColor,
                color = Krs.TextUi.colorText
            }
        })
        Citizen.Wait(15000)
        lib.hideTextUI()
    end
end


for i = 1, #Krs.prostitute do
    local Krs = Krs.prostitute[i]

    if Krs.blip.enable then
        local blip = AddBlipForCoord(Krs.pos.xy)
        SetBlipSprite(blip, Krs.blip.type)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Krs.blip.scale)
        SetBlipColour(blip, Krs.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Krs.blip.name)
        EndTextCommandSetBlipName(blip)
    end

    positions[i] = lib.points.new({
        coords = Krs.pos.xyz,
        distance = 7.5,
        prostituta = Krs,
        onEnter = onEnter,
        onExit = onExit,
        nearby = onNearby
    })
end



RegisterCommand(Krs.CommandMenu, function()
    lib.showContext('_prostitute')
end)

lib.registerContext({
    id = '_prostitute',
    title = Krs.Menu.titlecontext,
    options = {
        {
            title = Krs.Menu.titleblowjob,
            icon = Krs.Menu.iconblowjob,
            description = Krs.Menu.descriptionblowjob,
            arrow = false,
            onSelect = function(data)
                local money = exports.ox_inventory:Search("count", "money", nil)
                if money >= Krs.PriceBlowjob then
                    print(money)
                    TriggerServerEvent("krs:toglisoldipompino")
              
                    lib.requestAnimDict('oddjobs@towing')
                    TaskPlayAnim(ped, 'oddjobs@towing', 'f_blow_job_loop', 1.0, -1.0, 10000, 0, 1, true, true, true)
                    TaskPlayAnim(playerPed, 'oddjobs@towing', 'm_blow_job_loop', 1.0, -1.0, 10000, 0, 1, true, true, true)
                   
                    print(ped)
                else
                    lib.notify({

                        title = Krs.notify.title,
                        description = Krs.notify.description,
                        type = Krs.notify.type,
                    })
                end
            end,
        },
        {
            title = Krs.Menu.sex,
            icon = Krs.Menu.iconsex,
            description = Krs.Menu.descriptionsex,
            arrow = false,
            onSelect = function(data)
                local money = exports.ox_inventory:Search("count", "money", nil)
                if money >= Krs.PriceSex then
                    print(money)
                   
                    TriggerServerEvent("krs:toglisoldisesso")
              
                    lib.requestAnimDict('mini@prostitutes@sexlow_veh')
                    TaskPlayAnim(ped, 'mini@prostitutes@sexlow_veh', 'low_car_sex_loop_female', 1.0, -1.0, 25000, 0, 1, true,true, true)
                    TaskPlayAnim(playerPed, 'mini@prostitutes@sexlow_veh', 'low_car_sex_loop_player', 1.0, -1.0, 25000, 0, 1,true, true, true)
                
                    
                    print(ped)
                else
                    lib.notify({

                        title = Krs.notify.title,
                        description = Krs.notify.description,
                        type = Krs.notify.type,
                    })
                   
                end
            end,
        },
        {
            title = Krs.Menu.titleperformance,
            icon = Krs.Menu.iconperformance,
            description = Krs.Menu.descriptionperformance,
            arrow = false,
            onSelect = function(data)
                TaskLeaveVehicle(ped, vehicle, 0)
                TaskGoToCoordAnyMeans(ped, 128.65, -1055.36, 29.19, 5.0, 0, 0, 786603, 0xbf800000)
                print(ped, vehicle)
            end,
        },
    },
})
