spawnPositionX = 2851.234375
spawnPositionY = 918.9951171875 
spawnPositionZ = 10.75

function playerLogin() 
	spawnPlayerOnDefaulPosition(source) 
end

function spawnPlayerOnDefaulPosition(player)
	--spawnPlayer(player, spawnPositionX, spawnPositionY, spawnPositionZ)
	spawnPlayer(player, 1408.69, -1405.36, 8.60)
	--repeat until setElementModel(player,math.random(312))
	setElementModel(player,  137)
	fadeCamera(player, true)
	setCameraTarget(player, player)
	showChat(player, true)
end

function playerWasted() 
	setTimer(spawnPlayerOnDefaulPosition, 1800, 1, source) 
end

function playerCommand(command)
	if command == "pos" then
		local x,y,z = getElementPosition(source)
		outputChatBox("[COMMAND] Your position: x: "..x.." | y: "..y.." | z: "..z, source)
		outputServerLog("position: x: "..x.." | y: "..y.." | z: "..z)
	elseif command == "spawn" then
		spawnPlayerOnDefaulPosition(source)
	elseif command == "kill" then
		setElementHealth(source, 0.0)
	end
end

addEventHandler("onPlayerCommand", getRootElement(), playerCommand)
addEventHandler("onPlayerWasted", getRootElement(), playerWasted)

addEventHandler("onPlayerLogin", getRootElement(), playerLogin)
