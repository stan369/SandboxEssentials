
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


-- Define a list of NPCs that players are not allowed to spawn
local disallowedNPCs = {
    "npc_helicopter",
    "npc_combinedropship",
	    "npc_combinegunship",
		    "npc_strider",
			    "npc_tf2_ghost",
    -- Add more NPCs here if needed
}

-- Define a list of entities that players are not allowed to spawn
local disallowedEntities = {
	"sent_ball",
--  "",
--	"",
--	"",
    -- Add more entities here if needed remove the two - and add entity between ""
}

-- Hook into player spawn functions
hook.Add("PlayerSpawnNPC", "DisallowNPCSpawn", function(ply, npcType, weapon)
    -- Check if the NPC being spawned is in the disallowed list
    if table.HasValue(disallowedNPCs, npcType) then
        -- Inform the player that they cannot spawn this NPC
        ply:PrintMessage(HUD_PRINTTALK, "[SBoxEssentials] You are not allowed to spawn this NPC.")
        -- Return false to prevent the NPC from spawning
        return false
    end
end)

hook.Add("PlayerSpawnSENT", "DisallowEntitySpawn", function(ply, class)
    -- Check if the entity being spawned is in the disallowed list
    if table.HasValue(disallowedEntities, class) then
        -- Inform the player that they cannot spawn this entity
        ply:PrintMessage(HUD_PRINTTALK, "[SBoxEssentials] You are not allowed to spawn this entity.")
        -- Return false to prevent the entity from spawning
        return false
    end
end)
