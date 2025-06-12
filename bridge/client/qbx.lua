local Config = require("shared.sh_config")

if Config.Framework ~= "qbx" then return end

function CallEmergency()
    local coords = GetEntityCoords(PlayerPedId())
    local location = qbx.getZoneName(coords)
	TriggerServerEvent("ND_Ambulance:sendSignal", location, coords)
end

function RevivePed()
	TriggerServerEvent("ND_Ambulance:respawnPlayer")
end

RegisterNetEvent("qbx_core:client:onSetMetaData", function(data)
	if data.metadata.isdead or data.metadata.inlaststand then
		TriggerEvent("cloud-deathscreen:client:OnPlayerDeath")
	else
		TriggerEvent("cloud-deathscreen:client:OnPlayerSpawn")
	end
end)
