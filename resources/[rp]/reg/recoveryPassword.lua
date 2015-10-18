function createRecoveryWindow()
	wdwRecovery = guiCreateWindow(0.37, 0.28, 0.22, 0.24, "Восстановление пароля", true)
	guiWindowSetMovable(wdwRecovery, false)
	guiWindowSetSizable(wdwRecovery, false)
	guiSetAlpha(wdwRecovery, 0.70)

	edtEmailUsername = guiCreateEdit(68, 115, 318, 45, "", false, wdwRecovery)
	guiEditSetMaxLength(edtEmailUsername, 32)
	btnReturnToLogin = guiCreateButton(166, 198, 105, 40, "Назад", false, wdwRecovery)
	btnRecovery = guiCreateButton(281, 198, 105, 40, "Восстановить пароль", false, wdwRecovery)
	guiCreateLabel(69, 30, 286, 20, "Для восстановления пароля от аккаунта введите ", false, wdwRecovery)
	guiCreateLabel(69, 50, 288, 20, "в поле ниже ваш логин или электронную почту ", false, wdwRecovery)
	guiCreateLabel(69, 70, 290, 17, "и нажмите \"Восстановить пароль\".", false, wdwRecovery)
 
	guiSetVisible(wdwRecovery, false)
	addEventHandler("onClientGUIClick", btnRecovery, clientSubmitRecovery, false)
	addEventHandler("onClientGUIClick", btnReturnToLogin, 
		function()
			guiSetVisible(wdwRecovery, false)
			createLoginWindow()
		end	, false)

	addEventHandler("onClientKey", root, 
		function(button, press)
			if guiGetVisible(wdwRecovery) and button == "enter" and press == false then
				clientSubmitRecovery("left", "up")
			end	
		end)	
end

function clientSubmitRecovery(button, state)
	if button == "left" and state == "up" then
		local EmailUsername = guiGetText(edtEmailUsername)
		triggerServerEvent("submitRecovery", getRootElement(), EmailUsername)
	end
end

function recoveryAnswer(success, message)
	if(success) then
		guiSetVisible(wdwRecovery, false)
		guiSetVisible(wdwLogin, true)

		guiLabelSetColor(guiCreateLabel(0.2, 0.1, 0.55, 0.25, message, true, wdwLogin), 0, 255, 0)
	else
		lblSuccess = guiCreateLabel(69, 97, 308, 15, message, false, wdwRecovery)
		guiSetFont(lblSuccess, "default-bold-small")
		guiLabelSetColor(lblSuccess, 221, 29, 29)  
	end

end

addEvent("recoveryAnswer", true )
addEventHandler("recoveryAnswer", localPlayer, recoveryAnswer)