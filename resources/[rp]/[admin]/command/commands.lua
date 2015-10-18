function createVeh(client, command, veh, c1, c2)
	if hasObjectPermissionTo(client, "command.createvehicle", false) then
		local x,y,z = getElementPosition(client)
		createVehicle(veh, x+2.0, y+2.0, z, _, _, _, _, _, c1, c2)
	else
		outputChatBox("You can't access!")
	end
end

function teleportPosition(client, command, x, y, z)
	setElementPosition(client, x, y, z)
end

function fixCar(client, command)
	local vehicle = getPedOccupiedVehicle(client)
	fixVehicle(vehicle)
end

function god(client, command)
	local vehicle = getPedOccupiedVehicle(client)
	if(vehicle) then
		if isVehicleDamageProof(vehicle) then
			outputChatBox("Vehicle godmode: false", client)
			setVehicleDamageProof(vehicle, false)
		else
			setVehicleDamageProof(vehicle, true)
			outputChatBox("Vehicle godmode: true", client)
		end
	end
end

function removeVehecles(client, command)
	local vehicle = getPedOccupiedVehicle(client)
	if(vehicle) then	
		destroyElement(vehicle)
	end
end

addCommandHandler("fire", 
	function(client, command)
		createExplosion(1409.2, -1398.0, 8.8, 4)
	end)

addCommandHandler("client", 
	function(client, command, t, value)
		if(t == "set") then
			if(value == "true") then
				setElementData(client, "logged", true)
				outputChatBox("set true", client)
			elseif(value == "false") then
				outputChatBox("set false", client)
				setElementData(client, "logged", false)
			end
		elseif(t == "get") then
			if(getElementData(client, "logged")) then
				outputChatBox("client: true", client)
			else
				outputChatBox("client: false", client)
			end
		end
	end)

addCommandHandler("settime", 
	function(client, command, hh, mm)
		setTime(hh, mm)
	end)

addCommandHandler("skin", 
	function(client, command, skin)
		setElementModel(client, skin)
	end)
addCommandHandler("dveh", removeVehecles)
addCommandHandler("god", god)
addCommandHandler("tpos", teleportPosition)
addCommandHandler("fix", fixCar)
addCommandHandler("veh", createVeh)
addCommandHandler("aclreload", 
	function()
		aclReload()
	end)