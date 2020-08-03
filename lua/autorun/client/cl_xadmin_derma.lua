-- Functions j'suis fatigué
function RespyX(py)
    return ScrW() / (1920 / py)
end

function RespyY(xy)
    return ScrH() / (1080 / xy)
end

-- Functions
concommand.Add("xadmin", function()
    if xlean_admin_config.Staff[LocalPlayer():GetUserGroup()] then
    local Base = vgui.Create("DFrame")
    Base:SetSize(RespyX(1000), RespyX(700))
    Base:Center()
    Base:SetTitle("")
    Base:MakePopup()
    Base:ShowCloseButton(false)

    function Base:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(0, 0, 0, w, 50, Color(36, 36, 36))
    end

    local Close = vgui.Create("DLabel", Base)
    Close:SetText("X")
    Close:SetFont("XLean_Admin:15")
    Close:SetPos(RespyX(970), RespyX(15))
    Close:SetMouseInputEnabled(true)

    function Close:DoClick()
        if IsValid(Base) then
            Base:Close()
        end
        if IsValid(Punishment) then
            Punishment:Close()
        end
    end

    local Copyright = vgui.Create("DLabel", Base)
    Copyright:SetText("Admin menu of " .. LocalPlayer():Name()) -- KAPPA
    Copyright:SetSize(300, 30)
    Copyright:SetFont("XLean_Admin:30")
    Copyright:SetPos(RespyX(20), RespyX(10))

    function ZarosTuBanQuand(name, x, y, w, h, func)
        local XLeanButton = vgui.Create("DButton", Base)
        XLeanButton:SetText(name)
        XLeanButton:SetPos(RespyX(x), RespyY(y))
        XLeanButton:SetSize(RespyX(w), RespyY(h))
        XLeanButton:SetTextColor(Color(255, 255, 255))
        XLeanButton:SetFont("XLean_Admin:15")
        XLeanButton.DoClick = func
        XLeanButton.Slide = 0

        XLeanButton.OnCursorEntered = function(self)
            self.hover = true
            surface.PlaySound("UI/buttonrollover.wav")
        end

        XLeanButton.OnCursorExited = function(self)
            self.hover = false
        end

        function XLeanButton:Paint()
            if self.hover then
                self.Slide = Lerp(0.02, self.Slide, w)
                draw.RoundedBox(5, 0, 0, w, h, Color(36, 36, 36, 255))
                draw.RoundedBox(5, 0, 0, self.Slide, h, Color(40, 40, 40, 255))
            else
                self.Slide = Lerp(0.02, self.Slide, 0)
                draw.RoundedBox(5, 0, 0, w, h, Color(36, 36, 36, 255))
                draw.RoundedBox(5, 0, 0, self.Slide, h, Color(40, 40, 40, 255))
            end
        end
    end

    ZarosTuBanQuand("Admin Mode", 25, 100, 950, 50, function() // EZ
        net.Start("XAdmin::Admin")
        net.SendToServer()
        LocalPlayer():ConCommand("noclip")
        Base:Close()
    end)

-- EZ
ZarosTuBanQuand("Punishment menu", 25, 175, 950, 50, function()
    Punishment = vgui.Create("DFrame")
    Punishment:SetSize(RespyX(400), RespyX(500))
    Punishment:SetPos(RespyX(1500), RespyX(190))
    Punishment:SetTitle("")
    Punishment:ShowCloseButton(false)

    function Punishment:Paint(w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(32, 32, 32))
        draw.RoundedBox(8, 0, 0, w, 50, Color(36, 36, 36))
    end

    local CloseP = vgui.Create("DLabel", Punishment)
    CloseP:SetText("X")
    CloseP:SetFont("XLean_Admin:15")
    CloseP:SetPos(RespyX(370), RespyX(15))
    CloseP:SetMouseInputEnabled(true)

    function CloseP:DoClick()
        if IsValid(Base) then
            Punishment:Close()
        end
    end

    local reason = vgui.Create("DComboBox", Punishment)
    reason:SetPos(RespyX(25), RespyX(100 - 50))
    reason:SetSize(RespyX(350), RespyX(50))
    reason:SetValue("Quelle est la raison de ce bannisement ?")

    for k, v in pairs(xlean_admin_config.BanReason) do
        reason:AddChoice(v)

        reason.OnSelect = function(_, _, value)
        end
    end

    local comboBox = vgui.Create("DComboBox", Punishment)
    comboBox:SetPos(RespyX(25), RespyX(175 - 50))
    comboBox:SetSize(RespyX(350), RespyX(50))
    comboBox:SetValue("Quelle joueur voulez-vous bannir ?")

    for k, v in pairs(player.GetAll()) do
        comboBox:AddChoice(v:Name())

        comboBox.OnSelect = function(_, _, value)
        end
    end

    local Temps = vgui.Create("DComboBox", Punishment)
    local ValueTemps = Temps:GetValue()

    Temps:SetPos(RespyX(25), RespyX(200))
    Temps:SetSize(RespyX(350), RespyX(50))

    Temps:SetValue("Pour combien de temps voulez-vous le bannir ?")

    Temps:AddChoice("Secondes")
    Temps:AddChoice("Minutes")
    Temps:AddChoice("Heures")
    Temps:AddChoice("Jours")
    Temps:AddChoice("Permanent")

    Temps.OnSelect = function(self, _, value)
    end

    local Temps_ = vgui.Create("DComboBox", Punishment)

    Temps_:SetPos(RespyX(25), RespyX(275))
    Temps_:SetSize(RespyX(350), RespyX(50))

    Temps_:SetValue("Durée du bannisement")

    Temps_:AddChoice("1")
    Temps_:AddChoice("2")
    Temps_:AddChoice("3")
    Temps_:AddChoice("4")
    Temps_:AddChoice("5")
    Temps_:AddChoice("6")
    Temps_:AddChoice("7")
    Temps_:AddChoice("8")
    Temps_:AddChoice("9")

    Temps_.OnSelect = function(self, _, value)
    end


    local XLeanButton = vgui.Create("DButton", Punishment)
    XLeanButton:SetText("Confirmer")
    XLeanButton:SetPos(RespyX(25), RespyY(350))
    XLeanButton:SetSize(RespyX(350), RespyY(50))
    XLeanButton:SetTextColor(Color(255, 255, 255))
    XLeanButton:SetFont("XLean_Admin:15")
    XLeanButton.DoClick = function() 
    if Temps:GetValue() == "Secondes" then 
        LocalPlayer():ConCommand("ulx ban " .. comboBox:GetValue() .. " " .. Temps_:GetValue() / 60 .. " " .. reason:GetValue())
    elseif Temps:GetValue() == "Minutes" then 
        LocalPlayer():ConCommand("ulx ban " .. comboBox:GetValue() .. " " .. Temps_:GetValue() .. " " .. reason:GetValue())
    elseif Temps:GetValue() == "Heures" then 
        LocalPlayer():ConCommand("ulx ban " .. comboBox:GetValue() .. " " .. Temps_:GetValue() * 60 .. " " .. reason:GetValue())
    elseif Temps:GetValue() == "Heures" then 
        LocalPlayer():ConCommand("ulx ban " .. comboBox:GetValue() .. " " .. Temps_:GetValue() * 60 * 24 .. " " .. reason:GetValue())
    elseif Temps:GetValue() == "Permanent" then 
        LocalPlayer():ConCommand("ulx ban " .. comboBox:GetValue() .. " 0 " .. reason:GetValue())
    end
    end
    XLeanButton.Slide = 0

    XLeanButton.OnCursorEntered = function(self)
        self.hover = true
        surface.PlaySound("UI/buttonrollover.wav")
    end

    XLeanButton.OnCursorExited = function(self)
        self.hover = false
    end

    function XLeanButton:Paint(w, h)
        if self.hover then
            self.Slide = Lerp(0.02, self.Slide, w)
            draw.RoundedBox(5, 0, 0, w, h, Color(36, 36, 36, 255))
            draw.RoundedBox(5, 0, 0, self.Slide, h, Color(40, 40, 40, 255))
        else
            self.Slide = Lerp(0.02, self.Slide, 0)
            draw.RoundedBox(5, 0, 0, w, h, Color(36, 36, 36, 255))
            draw.RoundedBox(5, 0, 0, self.Slide, h, Color(40, 40, 40, 255))
        end
    end
end)

    ZarosTuBanQuand("Tickets menu", 25, 250, 950, 50, function() // EZ
        LocalPlayer():ConCommand("x_tickets")
        Base:Close()
    end)

    ZarosTuBanQuand("Refund menu", 25, 325, 950, 50, function() // EZ
        LocalPlayer():ChatPrint("Pas encore plus tard.")
        Base:Close()
    end)

    ZarosTuBanQuand("Open logs menu", 25, 400, 950, 50, function() // EZ
        LocalPlayer():ConCommand("say ".. xlean_admin_config.Logs)
        Base:Close()
    end)

    ZarosTuBanQuand("Addon support", 25, 475, 950, 50, function() // EZ
        gui.OpenURL( "discord.gg/gca" )
        Base:Close()
    end)

    ZarosTuBanQuand("Warning menu", 25, 550, 950, 50, function() // EZ
        LocalPlayer():ConCommand("say ".. xlean_admin_config.Warn)
        Base:Close()
    end)

    ZarosTuBanQuand("Open ULX menu", 25, 625, 950, 50, function() // EZ
        LocalPlayer():ConCommand("xgui")
        Base:Close()
    end)

end
end)