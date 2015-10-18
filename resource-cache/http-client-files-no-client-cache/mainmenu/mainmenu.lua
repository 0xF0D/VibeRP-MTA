mainMenu = {
    MainMenuwindow = {},
    label = {},
    IDlabel = {},
    AdminReportbutton = {},
    Levellabel = {},
    Ex = {
        Statisticbutton = {}
    },
    Warnslabel = {},
    Numberlabel = {},
    CommandHelpbutton = {},
    NickLabel = {},
    CloseWindowbutton = {},
    EXPlabel = {},
    Settingsbutton = {},
    Donatebutton = {}
}

function openMainMenu()
	local screenW, screenH = guiGetScreenSize()
	mainMenu.MainMenuwindow[2] = guiCreateWindow((screenW - 237) / 2, (screenH - 446) / 2, 237, 446, "Личное меню", false)
	guiWindowSetSizable(mainMenu.MainMenuwindow[2], false)

	showCursor(true)

	mainMenu.label[1] = guiCreateLabel(58, 86, 54, 17, "Уровень:", false, mainMenu.MainMenuwindow[2])
 	mainMenu.label[2] = guiCreateLabel(77, 113, 35, 15, "Опыт:", false, mainMenu.MainMenuwindow[2])
	mainMenu.label[3] = guiCreateLabel(17, 34, 95, 15, "Имя персонажа:", false, mainMenu.MainMenuwindow[2])
	mainMenu.label[4] = guiCreateLabel(41, 58, 71, 18, "ID аккаунта:", false, mainMenu.MainMenuwindow[2])
	mainMenu.NickLabel[13] = guiCreateLabel(122, 35, 120, 14, getPlayerName(getLocalPlayer()), false, mainMenu.MainMenuwindow[2])
	mainMenu.IDlabel[14] = guiCreateLabel(122, 58, 71, 18, "10231", false, mainMenu.MainMenuwindow[2])
	mainMenu.Levellabel[15] = guiCreateLabel(122, 86, 54, 17, "15", false, mainMenu.MainMenuwindow[2])
	mainMenu.EXPlabel[16] = guiCreateLabel(122, 113, 71, 15, "24 / 124", false, mainMenu.MainMenuwindow[2])
	mainMenu.AdminReportbutton[8] = guiCreateButton(10, 238, 217, 30, "Связь с Администрацией", false, mainMenu.MainMenuwindow[2])
	mainMenu.CommandHelpbutton[10] = guiCreateButton(10, 278, 217, 30, "Помощь по командам", false, mainMenu.MainMenuwindow[2])
 	mainMenu.Donatebutton[11] = guiCreateButton(10, 318, 217, 30, "Донат услуги", false, mainMenu.MainMenuwindow[2])
	mainMenu.Settingsbutton[12] = guiCreateButton(10, 358, 217, 30, "Настройки", false, mainMenu.MainMenuwindow[2])
	mainMenu.CloseWindowbutton[13] = guiCreateButton(10, 398, 217, 30, "Выход", false, mainMenu.MainMenuwindow[2])
	mainMenu.Ex.Statisticbutton[14] = guiCreateButton(10, 198, 217, 30, "Расширенная статистика", false, mainMenu.MainMenuwindow[2])
	mainMenu.label[5] = guiCreateLabel(10, 138, 102, 15, "Номер телефона:", false, mainMenu.MainMenuwindow[2])
	mainMenu.Numberlabel[19] = guiCreateLabel(122, 138, 102, 15, "666123", false, mainMenu.MainMenuwindow[2])
	mainMenu.label[6] = guiCreateLabel(74, 163, 38, 15, "Варны:", false, mainMenu.MainMenuwindow[2])
	mainMenu.Warnslabel[21] = guiCreateLabel(122, 163, 32, 15, "2 / 3", false, mainMenu.MainMenuwindow[2])

	addEventHandler("onClientGUIClick", mainMenu.AdminReportbutton[8], 
		function()
			guiSetVisible(mainMenu.MainMenuwindow[2], false)
			openReportMenu()
		end, false)

	addEventHandler("onClientGUIClick", mainMenu.CloseWindowbutton[13], 
		function()
			guiSetVisible(mainMenu.MainMenuwindow[2], false)
			showCursor(false)
		end, false)
end

bindKey("F1", "up", 
	function(key, state)
		if(mainMenu.MainMenuwindow[2] ~= nil) then
			if(guiGetVisible(mainMenu.MainMenuwindow[2]) == false) then
				guiSetVisible(mainMenu.MainMenuwindow[2], true)
				showCursor(true)
			else
				guiSetVisible(mainMenu.MainMenuwindow[2], false)
				showCursor(false)
			end
		else
			openMainMenu()
		end
	end)