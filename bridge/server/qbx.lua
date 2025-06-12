local Config = require("shared.sh_config")
local Locales = require("shared.sh_locales")

if Config.Framework ~= "qbx" then
	return
end

local function PayFine(source)
	local Player = exports.qbx_core:GetPlayer(source)
	if not Player then
		return false
	end

	local amount = Config.PriceForDeath
	local moneyAvailable = exports.qbx_core:GetMoney(source, "cash")
	local bankAvailable = exports.qbx_core:GetMoney(source, "bank")

	if moneyAvailable >= amount then
		exports.qbx_core:RemoveMoney(source, "cash", amount, "Death")

		ServerNotify(source, Locales.Notify.PaidFine:format(amount), "info")
		return true
	elseif bankAvailable >= amount then
		exports.qbx_core:RemoveMoney(source, "bank", amount, "Death")
		ServerNotify(source, Locales.Notify.PaidFine:format(amount), "info")
		return true
	else
		ServerNotify(source, Locales.Notify.NoMoney, "error")
		return false
	end
end

lib.callback.register("cloud-deathscreen:server:PayFine", PayFine)
