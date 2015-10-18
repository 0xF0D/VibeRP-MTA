function createRegistrationWindow()
	local screenW, screenH = guiGetScreenSize()
	wdwRegistration = guiCreateWindow((screenW - 447) / 2, (screenH - 338) / 2, 447, 338, "Регистрация нового аккаунта", false)
	guiWindowSetMovable(wdwRegistration, false)
	guiWindowSetSizable(wdwRegistration, false)
	guiSetAlpha(wdwRegistration, 0.70)

	guiCreateLabel(27, 48, 97, 17, "Имя персонажа:", false, wdwRegistration)
	edtUser = guiCreateEdit(128, 38, 275, 30, "", false, wdwRegistration)
	guiEditSetMaxLength(edtUser, 32)
	guiCreateLabel(75, 87, 49, 15, "Пароль:", false, wdwRegistration)
	guiCreateLabel(10, 126, 110, 15, "Повторите пароль:", false, wdwRegistration)
	guiCreateLabel(62, 162, 57, 18, "Эл.Почта:", false, wdwRegistration)
	lbl = guiCreateLabel(129, 186, 166, 16, "Требуется подтверждение!", false, wdwRegistration)
	guiSetFont(lbl, "default-bold-small")
	guiLabelSetColor(lbl, 250, 64, 0)
	guiCreateLabel(92, 216, 32, 22, "Пол:", false, wdwRegistration)
	edtPass = guiCreateEdit(128, 77, 275, 30, "", false, wdwRegistration)
	edtPassConfirm = guiCreateEdit(128, 116, 275, 30, "", false, wdwRegistration)
	edtEmail = guiCreateEdit(129, 156, 275, 30, "", false, wdwRegistration)

	guiEditSetMasked(edtPass, true)
	guiEditSetMasked(edtPassConfirm, true)

	guiEditSetMaxLength(edtPass, 32)
	guiEditSetMaxLength(edtPassConfirm, 32)
	guiEditSetMaxLength(edtEmail, 64)

	fieldsState = {
		wrong = {
			password = {},
			username,
			email
		},
		ok = {
			password = {},
			username,
			email
		}
	}

	fieldsState.ok.username = guiCreateStaticImage(420, 38, 25, 25, "images/yep.png", false, wdwRegistration)
	fieldsState.wrong.username = guiCreateStaticImage(420, 38, 25, 25, "images/nope.png", false, wdwRegistration)

	fieldsState.ok.password[1] = guiCreateStaticImage(420, 77, 25, 25, "images/yep.png", false, wdwRegistration)
	fieldsState.ok.password[2] = guiCreateStaticImage(420, 116, 25, 25, "images/yep.png", false, wdwRegistration)

	fieldsState.wrong.password[1] = guiCreateStaticImage(420, 77, 25, 25, "images/nope.png", false, wdwRegistration)
	fieldsState.wrong.password[2] = guiCreateStaticImage(420, 116, 25, 25, "images/nope.png", false, wdwRegistration)

	fieldsState.ok.email = guiCreateStaticImage(420, 156, 25, 25, "images/yep.png", false, wdwRegistration)
	fieldsState.wrong.email = guiCreateStaticImage(420, 156, 25, 25, "images/nope.png", false, wdwRegistration)

	guiSetVisible(fieldsState.wrong.password[1], false)
	guiSetVisible(fieldsState.wrong.password[2], false)	

	guiSetVisible(fieldsState.ok.password[1], false)
	guiSetVisible(fieldsState.ok.password[2], false)

	guiSetVisible(fieldsState.ok.username, false)
	guiSetVisible(fieldsState.wrong.username, false)

	guiSetVisible(fieldsState.ok.email, false)
	guiSetVisible(fieldsState.wrong.email, false)

	btnReturnToLogin = guiCreateButton(92, 273, 145, 45, "Назад", false, wdwRegistration)
	radioSexMale = guiCreateRadioButton(185, 217, 21, 15, "", false, wdwRegistration)
	guiRadioButtonSetSelected(radioSexMale, true)
	radioSexFemale = guiCreateRadioButton(271, 217, 15, 15, "", false, wdwRegistration)
	guiCreateLabel(129, 217, 56, 15, "Мужской", false, wdwRegistration)
 	guiCreateLabel(213, 217, 68, 15, "Женский", false, wdwRegistration)
	btnRegistration = guiCreateButton(261, 273, 145, 45, "Зарегистрироваться", false, wdwRegistration)   
 
	guiSetVisible(wdwRegistration, false)
	addEventHandler("onClientGUIClick", btnRegistration, clientSubmitRegistration, false)
	addEventHandler("onClientGUIClick", btnReturnToLogin, 
		function()
			guiSetVisible(wdwRegistration, false)
			createLoginWindow()
		end, false)
end

function onlineFieldsCheck()		
	if (guiGetText(edtPassConfirm) ~= "" and guiGetText(edtPass) ~= "") then
		if(guiGetText(edtPassConfirm) == guiGetText(edtPass)) then
			if(string.len(guiGetText(edtPass))) > 5 then
				guiSetVisible(fieldsState.ok.password[1], true)
				guiSetVisible(fieldsState.ok.password[2], true)

				guiSetVisible(fieldsState.wrong.password[1], false)
				guiSetVisible(fieldsState.wrong.password[2], false)	
			end	
		else
			guiSetVisible(fieldsState.ok.password[1], false)
			guiSetVisible(fieldsState.ok.password[2], false)

			guiSetVisible(fieldsState.wrong.password[1], true)
			guiSetVisible(fieldsState.wrong.password[2], true)
		end
	else
		guiSetVisible(fieldsState.wrong.password[1], false)
		guiSetVisible(fieldsState.wrong.password[2], false)	

		guiSetVisible(fieldsState.ok.password[1], false)
		guiSetVisible(fieldsState.ok.password[2], false)
	end
	if(guiGetText(edtUser) ~= "") then
		if pregFind(guiGetText(edtUser), "([A-Z]{1,1})[a-z]{2,9}_([A-Z]{1,1})[a-z]{2,9}") then
			guiSetVisible(fieldsState.ok.username, true)
			guiSetVisible(fieldsState.wrong.username, false)
		else
			guiSetVisible(fieldsState.ok.username, false)
			guiSetVisible(fieldsState.wrong.username, true)
		end
	end
	if(guiGetText(edtEmail) ~= "") then
		if(string.find(guiGetText(edtEmail), "@") ~= nil) then
			guiSetVisible(fieldsState.ok.email, true)
			guiSetVisible(fieldsState.wrong.email, false)
		else
			guiSetVisible(fieldsState.ok.email, false)
			guiSetVisible(fieldsState.wrong.email, true)
		end
	end
end

function clientSubmitRegistration(button, state)
	if button == "left" and state == "up" then
		local username = guiGetText(edtUser)
		local password = guiGetText(edtPass)
		local email = guiGetText(edtEmail)

		if username ~= "" and email ~= "" and password ~= "" then
			if pregFind(username, "([A-Z]{1,1})[a-z]{2,9}_([A-Z]{1,1})[a-z]{2,9}") then -- Check RP nickname
					if guiRadioButtonGetSelected(radioSexMale) then
						triggerServerEvent("submitRegistration", getRootElement(), username, password, email, 0)
					else
						triggerServerEvent("submitRegistration", getRootElement(), username, password, email, 1)
					end
			else
				outputChatBox("Non-RP username!")
			end
		else 
			outputChatBox("Please enter username, email and password!")
		end
		-- outputChatBox("login: "..login.." | pass: "..pass.." | email: "..email)
	end
end

function registrationAnswer(success, wrongField)
	if(success) then
		clientReturnLoginForm("left", "up")
	else

	end
end

addEvent("registrationAnswer", true )
addEventHandler("registrationAnswer", localPlayer, registrationAnswer)
