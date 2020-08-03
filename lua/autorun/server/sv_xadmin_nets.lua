util.AddNetworkString("XAdmin::Admin")

net.Receive("XAdmin::Admin", function(len, ply)
    if xlean_admin_config.Staff[ply:GetUserGroup()] then
    local admin = ply:GetNWInt("XAdmin::Admin") -- maybe
    if admin == 1 then
        ply:SetNWInt( 'XAdmin::Admin', 0 )
        ply:GodDisable()
    else    
        ply:SetNWInt( 'XAdmin::Admin', 1 )
        ply:GodEnable()
    end
    end
end)