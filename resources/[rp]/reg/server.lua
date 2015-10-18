--connect = dbConnect("mysql", "host=stan.beget.ru;db=fh79114r_mta", "fh79114r_mta", "mlp_13664376", "share=0;autoreconnect=1;log=1")
--connect = dbConnect("mysql", "host=stan.beget.ru;dbname=fh79114r_mta", "fh79114r_mta", "J4NS0wfk", "share=0;autoreconnect=1;log=1") 

connect = mysql_connect("localhost", "root", "13664376", "mta")

if (not connect) then
	outputDebugString("Unable to connect to the MySQL server")
else
	outputDebugString("Succesfully")
end

function registrationHandler(username, password, email, sex)
	local time = getRealTime()
	local ip = getPlayerIP(client)

	local checkName = mysql_query(connect, string.format("SELECT `name` FROM `members` WHERE `name` = '%s'", username))
	local checkEmail = mysql_query(connect, string.format("SELECT `email` FROM `members` WHERE `email` = '%s'", email))

	if(checkEmail ~= nil and checkName ~= nil) then
		if mysql_num_rows(checkName) == 0 and mysql_num_rows(checkEmail) == 0 then
			outputChatBox("Your account successfully created!", client)
			mysql_query(connect, string.format("INSERT INTO `members`(`name`, `email`, `pass`, `regip`, `regdate`, `sex`) VALUES ('%s', '%s', '%s', '%s', '%s', '%d')", username, email, password, ip, time.timestamp, sex))
			triggerClientEvent(client, "registrationAnswer", client, true)
		elseif mysql_num_rows(checkName) > 0 then
			outputChatBox(string.format("Username (%s) already registered!", username), client)
			triggerClientEvent(client, "registrationAnswer", client, false, "username")
		elseif mysql_num_rows(checkEmail) > 0 then
			outputChatBox(string.format("Email (%s) already registered!", email), client)
			triggerClientEvent(client, "registrationAnswer", client, false, "email")
		end
	end
end

addEvent("submitRegistration", true)
addEventHandler( "submitRegistration", root, registrationHandler)

addEventHandler("onPlayerChangeNick", getRootElement(), 
	function()
		cancelEvent(true)
	end)

function loginHandler(username, password)
	local result = mysql_query(connect, string.format("SELECT `pass` FROM `members` WHERE `name` = '%s'", username))
	--outputChatBox("SELECT `pass` FROM `members` WHERE `name` = '"..username.."'", client)
	--outputServerLog("fields: "..mysql_num_fields(result).." rows: "..mysql_num_rows(result))

	if(result ~= nil) then
		if mysql_num_rows(result) == 0 then
			outputChatBox("Invalid login or password. Please try again.", client)
			triggerClientEvent(client, "loginAnswer", client, false)
		else
			local row = mysql_fetch_assoc(result)
			if(row["pass"] == password) then
				triggerClientEvent(client, "loginAnswer", client, true)

				outputChatBox("Welcome to VibeRP server!", client)
				exports.spawn:spawnPlayerOnDefaulPosition(client)
				setPlayerName (client, username)
				setPlayerBlurLevel(client, 0)

				setElementData(client, "logged", true)
			else
				outputChatBox("Invalid password. Please try again.", client)
				triggerClientEvent(client, "loginAnswer", client, false)			
			end
		end
		mysql_free_result(result)
	end
end

addEvent("submitLogin",true)
addEventHandler("submitLogin",root,loginHandler)

function recoveryHandler(EmailUsername)
	local result = mysql_query(connect, string.format("SELECT `name`, `email` FROM `members` WHERE `name` = '%s' OR `email` = '%s'", EmailUsername, EmailUsername))

	if result ~= nil then
		if(mysql_num_rows(result) == 0) then
			triggerClientEvent(client, "recoveryAnswer", client, false, "Такая почта или логин не найдены!")
		else
			triggerClientEvent(client, "recoveryAnswer", client, true, "Новый пароль был выслан на почту!")
		end
	end
end

addEvent("submitRecovery", true)
addEventHandler("submitRecovery", root, recoveryHandler)