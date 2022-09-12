-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false	
	
	pure_macc_spells = S{'Break', 'Silence', 'Sleep', 'Sleep II', 'Sleepga', 'Breakga'} 
	potencyBasedEnancing = S{"Embrava", "Phalanx", "Barfire", "Barfira", "Barblizzard", "Barblizzara", "Baraero",
		"Baraera", "Barstone", "Barstonra", "Barthunder", "Barthundra", "Barwater", "Barwatera"}
end 

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT', 'Misery')
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
	local new_spell_map = default_spell_map
	
	if spell.action_type == 'Magic' then
		if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
			if default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
				new_spell_map = "CureSolace"
			else
				-- This is needed because Mote's lib checks for spell.english set before spellMap
				new_spell_map = new_spell_map .. "s"
			end
			if (is_matching_day_weather(spell)) then 
				new_spell_map = new_spell_map .. "Weather"
			end
		elseif default_spell_map == 'Raise' or default_spell_map == 'Reraise' then
			new_spell_map = "ConserveMP"
		elseif spell.skill == "Enfeebling Magic" then
			if not pure_macc_spells:contains(spell.english) then
				if spell.type == "WhiteMagic" then
					new_spell_map = "MndEnfeebles"
				elseif spell.type == "BlackMagic" then
					new_spell_map = "IntEnfeebles"
				end
			end
		elseif spell.skill == "Enhancing Magic" then
			if not default_spell_map or not default_spell_map == "Regen" then
				if not potencyBasedEnancing:contains(spell.english) then
					new_spell_map = "EnhancingDuration"
				end
			end
		end
	end
	
	return new_spell_map
end

function job_post_midcast(spell, action, spellMap, eventArgs) 	
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_state_change(state_being_updated, new_state_value, old_state_value)
	if new_state_value == "DT" or new_state_value == "Normal" then
		if state_being_updated == "Casting Mode" then
			state.IdleMode:set(new_state_value)
		elseif state_being_updated == "Idle Mode" then
			state.CastingMode:set(new_state_value)
		end
	end
end

function is_matching_day_weather(spell)
	if spell.element == world.weather_element then
		return true
	elseif spell.element == world.day_element then
		if elements.weak_to[spell.element] == world.weather_element then
			return false
		end
	end
	return false
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
	if (buffactive['Sublimation: Activated']) then
		idleSet = set_combine(idleSet, sets.Sublimation)
	end
    return idleSet
end
