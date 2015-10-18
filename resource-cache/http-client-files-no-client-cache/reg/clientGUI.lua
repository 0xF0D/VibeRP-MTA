addEventHandler("onClientResourceStart", getResourceRootElement(), 
	function ()
		createLoginWindow()
		outputChatBox("Welcome to My MTA:SA Server, please log in.")
 
		if (wdwLogin ~= nil) then
			guiSetVisible(wdwLogin, true)
		else
			outputChatBox("An unexpected error has occurred and the log in GUI has not been created.")
		end
		 
		showCursor(true)
		guiSetInputEnabled(true)
	end
)

function wrongLoginOrPassword()
	createLoginWindow()
	outputChatBox("Wrong login or password, please try again!")
 
	if (wdwLogin ~= nil) then
		guiSetVisible(wdwLogin, true)
	else
		outputChatBox("An unexpected error has occurred and the log in GUI has not been created.")
	end
		 
	showCursor(true)
	guiSetInputEnabled(true)
end

addEvent("onWrongLoginOrPassword", true )
addEventHandler("onWrongLoginOrPassword", localPlayer, wrongLoginOrPassword)

function createLoginWindow()
	local X = 0.375
	local Y = 0.375
	local Width = 0.25
	local Height = 0.25
	wdwLogin = guiCreateWindow(X, Y, Width, Height, "Please Log In", true)
 
	-- define new X and Y positions for the first label
	X = 0.0825
	Y = 0.2
	-- define new Width and Height values for the first label
	Width = 0.25
	Height = 0.25
	-- create the first label, note the final argument passed is 'wdwLogin' meaning the window
	-- we created above is the parent of this label (so all the position and size values are now relative to the position of that window)
	guiCreateLabel(X, Y, Width, Height, "Username", true, wdwLogin)
	-- alter the Y value, so the second label is slightly below the first
	Y = 0.5
	guiCreateLabel(X, Y, Width, Height, "Password", true, wdwLogin)
 
 
	X = 0.415
	Y = 0.2
	Width = 0.5
	Height = 0.15
	edtUser = guiCreateEdit(X, Y, Width, Height, "", true, wdwLogin)
	Y = 0.5
	edtPass = guiCreateEdit(X, Y, Width, Height, "", true, wdwLogin)
	-- set the maximum character length for the username and password fields to 50
	guiEditSetMaxLength(edtUser, 50)
	guiEditSetMaxLength(edtPass, 50)
 
	X = 0.415
	Y = 0.7
	Width = 0.25
	Height = 0.2
	btnLogin = guiCreateButton(X, Y, Width, Height, "Log In", true, wdwLogin)
 
	-- make the window invisible
	guiSetVisible(wdwLogin, false)
	addEventHandler("onClientGUIClick", btnLogin, clientSubmitLogin, false)
end

function clientSubmitLogin(button,state)
	if button == "left" and state == "up" then
		local username = guiGetText(edtUser)
		local password = guiGetText(edtPass)
 
		if username and password then
			triggerServerEvent("submitLogin", getRootElement(), username, password)

			guiSetInputEnabled(false)
			guiSetVisible(wdwLogin, false)
			showCursor(false)
		else
			outputChatBox("Please enter a username and password.")
		end
	end
end

