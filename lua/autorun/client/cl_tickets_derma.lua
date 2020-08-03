-- Functions j'suis fatigué -- j'avoue après c'est ez quand même
function RespyX(py)
    return ScrW() / (1920 / py)
end

function RespyY(xy)
    return ScrH() / (1080 / xy)
end

-- Functions

concommand.Add("x_tickets", function()
    local Tickets = vgui.Create("DFrame")
    Tickets:SetSize(RespyX(400), RespyY(200))
    Tickets:Center()
    Tickets:SetTitle("")
    Tickets:MakePopup()
    Tickets:ShowCloseButton(false)
    
    function Tickets:Paint(w,h)
        draw.RoundedBox(8, 0,0,w, h, Color(32,32,32))
        draw.RoundedBox(8, 0,0,w, 50, Color(36,36,36))
    end

    local Close = vgui.Create("DLabel", Tickets)
    Close:SetText("X")
    Close:SetFont("XLean_Admin:15")
    Close:SetPos(380,15)
    Close:SetMouseInputEnabled( true )
    function Close:DoClick()
        Tickets:Close()
    end

    local dTextEntry = vgui.Create("DTextEntry", Tickets)
    dTextEntry:SetText("Entrer une raison ici")
    dTextEntry:SetPos(25,70)
    dTextEntry:SetSize(350, 40)
    dTextEntry:SetDrawLanguageID(false)

    dTextEntry.OnGetFocus = function(self)
        self:SetValue("")
    end

    local XLeanButton = vgui.Create("DButton", Tickets)
    XLeanButton:SetText("Confirmer")
    XLeanButton:SetPos(RespyX(25), RespyY(130))
    XLeanButton:SetSize(RespyX(350), RespyY(50))
    XLeanButton:SetTextColor(Color(255, 255, 255))
    XLeanButton:SetFont("XLean_Admin:15")
    XLeanButton.DoClick = function() 
    LocalPlayer():ConCommand("say @" .. dTextEntry:GetValue())
    Tickets:Close()
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


hook.Add("OnPlayerChat", "XLean::Command", function(ply, strText, bTeam, bDead)
    if (ply ~= LocalPlayer()) then return end
    strText = string.lower(strText)

    if (strText == xlean_admin_config.Menu) then
        ply:ConCommand("xadmin")

        return true
    end
end)

hook.Add("OnPlayerChat", "XLean::CommandTicket", function(ply, strText, bTeam, bDead)
    if (ply ~= LocalPlayer()) then return end
    strText = string.lower(strText)

    if (strText == xlean_admin_config.Tickets) then
        ply:ConCommand("x_tickets")

        return true
    end
end)