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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise', 'FullPDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'NoSIRD', 'SIRDPhalanx')
    state.PhysicalDefenseMode:options('BlockRate', 'ReRaise', 'Doom')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'StatusResist', 'MDEF'}
    
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
end

function user_unload()
    send_command('unbind !f11')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    -- if state.DefenseMode.value ~= 'None' then
        -- handle_equipping_gear(player.status)
        -- eventArgs.handled = true
		-- return
    -- end
end

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.name ~= "Flash" and spell.action_type ~= "Ability" then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
		return
    end
	
	if state.Buff.Sentinel and spell.name == 'Flash' then
		equip(sets.midcast.FlashSentinel)
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.DefenseMode.value == 'None' and state.Buff.Sentinel and spell.name == 'Flash' then
		equip(sets.midcast.FlashSentinel)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	
	if state.ExtraDefenseMode.value ~= 'None' then
        idleSet = set_combine(idleSet, sets[state.ExtraDefenseMode.value])
    end
	
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    return defenseSet
end
