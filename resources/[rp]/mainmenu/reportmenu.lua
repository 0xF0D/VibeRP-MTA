reportMenu = {
    radiobutton = {},
    button = {},
    window = {},
    label = {},
    memo = {}
}

function openReportMenu()
    if(reportMenu.window[1] ~= nil) then
        guiSetVisible(reportMenu.window[1], true)
    else
        local screenW, screenH = guiGetScreenSize()
        reportMenu.window[1] = guiCreateWindow((screenW - 500) / 2, (screenH - 360) / 2, 500, 360, "Связь с администрацией", false)
        guiWindowSetSizable(reportMenu.window[1], false)

        reportMenu.memo[1] = guiCreateMemo(10, 101, 480, 141, "", false, reportMenu.window[1])
        reportMenu.button[1] = guiCreateButton(17, 294, 145, 45, "Назад", false, reportMenu.window[1])
        reportMenu.button[2] = guiCreateButton(331, 294, 145, 45, "Отправить", false, reportMenu.window[1])
        reportMenu.label[1] = guiCreateLabel(17, 252, 48, 15, "Жалоба", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[1], "default-bold-small")
        guiLabelSetColor(reportMenu.label[1], 212, 46, 14)
        reportMenu.radiobutton[1] = guiCreateRadioButton(65, 252, 15, 15, "", false, reportMenu.window[1])
        guiRadioButtonSetSelected(reportMenu.radiobutton[1], true)
        reportMenu.label[2] = guiCreateLabel(103, 252, 44, 15, "Вопрос", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[2], "default-bold-small")
        guiLabelSetColor(reportMenu.label[2], 41, 186, 12)
        reportMenu.radiobutton[2] = guiCreateRadioButton(147, 252, 15, 15, "", false, reportMenu.window[1])
        reportMenu.label[3] = guiCreateLabel(38, 27, 428, 15, "В данной форме вы можете отправить жалобу на нарушение правил со ", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[3], "default-bold-small")
        reportMenu.label[4] = guiCreateLabel(38, 42, 429, 15, "стороны игроков, либо задать какой-либо вопрос администрации.", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[4], "default-bold-small")
        reportMenu.label[5] = guiCreateLabel(38, 57, 431, 15, "Внимание! Не забудьте ниже указать правильную категорию! ", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[5], "default-bold-small")
        guiLabelSetColor(reportMenu.label[5], 231, 162, 43)
        reportMenu.label[6] = guiCreateLabel(38, 72, 432, 15, "За флуд и оффтоп вы будете наказываться администрацией!", false, reportMenu.window[1])
        guiSetFont(reportMenu.label[6], "default-bold-small")
        guiLabelSetColor(reportMenu.label[6], 232, 40, 40)

        addEventHandler("onClientGUIClick", reportMenu.button[1], 
            function()
                guiSetVisible(mainMenu.MainMenuwindow[2], true)
                guiSetVisible(reportMenu.window[1], false)
            end, false)
    end
end