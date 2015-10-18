addEventHandler("onClientResourceStart", getResourceRootElement(), 
	function ()
		createLoginWindow()
		-- outputChatBox("Welcome to My MTA:SA Server, please log in.")
		showCursor(true)
		guiSetInputEnabled(true)
	end
)

function loginAnswer(success)
	if(success) then
		guiSetInputEnabled(false)
		guiSetVisible(wdwLogin, false)
		showCursor(false)

		removeEventHandler("onClientKey", root, clientKey)
	end
end

addEvent("loginAnswer", true )
addEventHandler("loginAnswer", localPlayer, loginAnswer)

function createLoginWindow()
	wdwLogin = guiCreateWindow(0.37, 0.28, 0.22, 0.24, "Log In", true)
	guiWindowSetMovable(wdwLogin, false)
	guiWindowSetSizable(wdwLogin, false)
	guiSetAlpha(wdwLogin, 0.70)

	edtUser = guiCreateEdit(71, 59, 300, 45, "", false, wdwLogin)
	guiEditSetMaxLength(edtUser, 32)
	guiCreateLabel(19, 74, 42, 20, "ЛОГИН:", false, wdwLogin)
	edtPass = guiCreateEdit(71, 123, 300, 45, "", false, wdwLogin)
	guiEditSetMasked(edtPass, true)
	guiEditSetMaxLength(edtPass, 32)
	guiCreateLabel(16, 137, 51, 17, "ПАРОЛЬ:", false, wdwLogin)
	btnLogin = guiCreateButton(51, 198, 105, 40, "Войти", false, wdwLogin)
	btnRegistration = guiCreateButton(166, 198, 105, 40, "Регистрация", false, wdwLogin)
	btnRecovery = guiCreateButton(281, 198, 105, 40, "Восстановить пароль", false, wdwLogin)

	guiSetVisible(wdwLogin, true)

	addEventHandler("onClientGUIClick", btnLogin, clientSubmitLogin, false)
	addEventHandler("onClientGUIClick", btnRegistration, clientRegistration, false)
	addEventHandler("onClientGUIClick", btnRecovery, clientRecovery, false)

	addEventHandler("onClientKey", root, clientKey)
end

function clientKey(button, press)
	if button == "enter" and press == false then
		if guiGetVisible(wdwLogin) then
			clientSubmitLogin("left", "up")
		elseif guiGetVisible(wdwRegistration) then
			clientSubmitRegistration("left", "up")
		elseif guiGetVisible(wdwRecovery) then
			clientSubmitRecovery("left", "up")
		end
	elseif (press == false) and wdwRegistration ~= nil and guiGetVisible(wdwRegistration) then
		onlineFieldsCheck()
	end
end

function clientRecovery(button, state)
	if button == "left" and state == "up" then
		guiSetVisible(wdwLogin, false)
		createRecoveryWindow()
		guiSetVisible(wdwRecovery, true)
	end
end

function clientRegistration(button, state)
	if button == "left" and state == "up" then
		--guiSetInputEnabled(false)
		guiSetVisible(wdwLogin, false)
		--showCursor(false)
		createRegistrationWindow()
		guiSetVisible(wdwRegistration, true)
	end
end

function clientSubmitLogin(button,state)
	if button == "left" and state == "up" then
		local username = guiGetText(edtUser)
		local password = guiGetText(edtPass)
 
		if username and password then
			triggerServerEvent("submitLogin", getRootElement(), username, password)
		else
			outputChatBox("Please enter a username and password.")
		end
	end
end