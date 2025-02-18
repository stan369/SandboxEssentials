
--░██████╗░█████╗░███╗░░██╗██████╗░██████╗░░█████╗░██╗░░██╗
--██╔════╝██╔══██╗████╗░██║██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝
--╚█████╗░███████║██╔██╗██║██║░░██║██████╦╝██║░░██║░╚███╔╝░
--░╚═══██╗██╔══██║██║╚████║██║░░██║██╔══██╗██║░░██║░██╔██╗░
--██████╔╝██║░░██║██║░╚███║██████╔╝██████╦╝╚█████╔╝██╔╝╚██╗
--╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═════╝░░╚════╝░╚═╝░░╚═╝

--███████╗░██████╗░██████╗███████╗███╗░░██╗████████╗██╗░█████╗░██╗░░░░░░██████╗
--██╔════╝██╔════╝██╔════╝██╔════╝████╗░██║╚══██╔══╝██║██╔══██╗██║░░░░░██╔════╝
--█████╗░░╚█████╗░╚█████╗░█████╗░░██╔██╗██║░░░██║░░░██║███████║██║░░░░░╚█████╗░
--██╔══╝░░░╚═══██╗░╚═══██╗██╔══╝░░██║╚████║░░░██║░░░██║██╔══██║██║░░░░░░╚═══██╗
--███████╗██████╔╝██████╔╝███████╗██║░╚███║░░░██║░░░██║██║░░██║███████╗██████╔╝
--╚══════╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░╚═╝╚══════╝╚═════╝░

-- Stan https://steamcommunity.com/id/Stan369


-- Chose the table route for faster checks. 
local disallowedNPCs = {
    npc_helicopter = true,
    npc_combinedropship = true,
    npc_combinegunship = true,
    npc_strider = true,
    npc_tf2_ghost = true
	-- Add more NPCs here if needed
}

local disallowedEntities = {
    sent_ball = true,
    npc_grenade_frag = true,
    item_rpg_round = true,
    item_ammo_smg1_grenade = true,
    grenade_helicopter = true,
    combine_mine = true
	    -- Add more entities here if needed 
}

local disallowedWeapons = {
    weapon_rpg = true,
    weapon_frag = true,
    weapon_slam = true,
    manhack_welder = true,
    bb_cssfrag_alt = true
	    -- Add more weapons here if needed.
}

-- Below are the hooks to disallow. 

-- Hook into player spawn functions
hook.Add("PlayerSpawnNPC", "DisallowNPCSpawn", function(ply, npcType, weapon)
    if disallowedNPCs[npcType] then
        ply:PrintMessage(HUD_PRINTTALK, "[TheSBoxServer] You are not allowed to spawn this NPC.") -- NPC Blacklist Message
        return false
    end
end)

hook.Add("PlayerSpawnSENT", "DisallowEntitySpawn", function(ply, class)
    if disallowedEntities[class] then
        ply:PrintMessage(HUD_PRINTTALK, "[TheSBoxServer] You are not allowed to spawn this entity.") -- Entity Blacklist Message
        return false
    end
end)

-- Prevent giving weapons via commands (give <weapon>)
hook.Add("PlayerGiveSWEP", "DisallowWeaponSpawn", function(ply, weaponClass, swep)
    if disallowedWeapons[weaponClass] then
        ply:PrintMessage(HUD_PRINTTALK, "[TheSBoxServer] You are not allowed to spawn this weapon.") -- Weapon Blacklist Message
        return false
    end
end)

-- Prevent spawning weapons via Q menu
hook.Add("PlayerSpawnSWEP", "DisallowSWEPSpawn", function(ply, weaponClass, swep)
    if disallowedWeapons[weaponClass] then
        ply:PrintMessage(HUD_PRINTTALK, "[TheSBoxServer] You are not allowed to spawn this weapon.") -- Weapon Blacklist Message
        return false
    end
end)

-- Prevent picking up blacklisted weapons
hook.Add("PlayerCanPickupWeapon", "DisallowWeaponPickup", function(ply, weapon)
    if disallowedWeapons[weapon:GetClass()] then
        ply:PrintMessage(HUD_PRINTTALK, "[TheSBoxServer] You are not allowed to use this weapon.") -- Weapon Blacklist Message
        return false
    end
end)
