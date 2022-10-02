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
    state.Buff.Saboteur = buffactive.saboteur or false
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II', 'Poison', 'Poisonga'}	
	pure_macc_spells = S{'Break', 'Silence', 'Sleep', 'Sleep II', 'Sleepga', 'Breakga', 'Bind'} 
	no_cap_enh_skill = S{'Temper', 'Temper II', 'Enfire', 'Enblizzard',
	'Enaero', 'Enstone', 'Enthunder', 'Enwater', 'Enfire II', 'Enblizzard II', 'Enaero II', 'Enstone II', 'Enthunder II', 'Enwater II'}
	duration_only = S{'Dia', 'Dia II', 'Dia III', 'Bio', 'Bio II', 'Bio III'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
	
    state.MagicBurst = M(false, 'Magic Burst')
	update_combat_form()
end


-- Define sets and vars used by this job file.
function init_gear_sets()	
	maccMatkSucCape = {name="Sucellos's Cape", augments={'INT+20', 'INT+10'}}
	mevaSucCape = {name="Sucellos's Cape", augments={'MND+20', 'Eva.+20/Mag. Eva.+20'}}
	storeTPSucCape = {name="Sucellos's Cape", augments={'"Store TP"+10'}}
	savageSucCape = {name="Sucellos's Cape", augments={'STR+20', 'STR+10'}}
	critSucCape = {name="Sucellos's Cape", augments={'DEX+20', 'Crit.hit rate+10'}}
	mndWsdSucCape = {name="Sucellos's Cape", augments={'MND+20', 'Weapon skill damage +10%'}}
	mndDaSucCape = {name="Sucellos's Cape", augments={'MND+20', '"Dbl.Atk."+10'}}
	merlinicCrackowsDrainAspir = {name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +10'}}
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {
		ammo="Impatiens", head="Atrophy Chapeau +3", hands="Volte Gloves",
		ring1="Lebeche Ring", back="Perimede Cape", waist="Witful Belt", feet="Volte Gaiters",
		body="Vitiation Tabard +3"
	}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Crepuscular Cloak",
		main=grioFC,
		sub="Clerisy Strap",
		legs="Volte Brais",
		ear2="Lethargy Earring"
	})
		
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	   
				
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
		main="Tamaxchi", sub="Sors Shield", ammo="Esper Stone +1", head="Kaykaus Mitra +1",
		neck="Incanter's Torque", ear1="Malignance Earring", ear2="Etiolation Earring",
		body="Kaykaus Bliaut", hands="Kaykaus Cuffs +1", ring1="Naji's Loop", ring2="Mephitas's Ring +1", 
		back="Fi Follet Cape +1", waist="Shinjutsu-no-obi +1", legs="Bunzi's Pants", feet="Kaykaus Boots +1"
		--legs="Kaykaus Tights +1",
		--body="Kaykaus Bliaut +1",
		--ammo="Pemphredo Tathlum"
	}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure
	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff", sub="Clerisy Strap", waist="Hachirin-no-Obi"
	})
	
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {ring1="Haoma's Ring",
		ring2="Haoma's Ring", neck="Debilis Medallion", feet="Gendewitha Galoshes +1",
		ear1="Beatific Earring", ear2="Meili Earring", legs="Carmine Cuisses +1", head="Kaykaus Mitra +1",
		waist="Bishop's Sash", body="Vitiation Tabard +3", hands="Hieros Mittens",
		back="Oretania's Cape +1"
		--ring1="Menelaus's Ring"
	})
    
	--Used for Pure MACC Spells (Sleep, Break, Silence, etc)
    sets.midcast.MndEnfeebles = {
		main="Bunzi's Rod", sub="Ammurapi Shield", range="Ullr", ammo="", head="Vitiation Chapeau +3",
		neck="Duelist's Torque +1", ear1="Regal Earring", ear2="Snotra Earring", body="Atrophy Tabard +3",
		hands="Lethargy Gantherots +2", ring1="Metamorph Ring +1", ring2="Stikini Ring +1",
		back="Aurist's Cape +1", waist="Obstinate Sash", legs="Chironic Hose", feet="Vitiation Boots +3"
		--ring1="Stikini Ring +1",
		--neck="Duelist's Torque +2",
		--ear2="Lethargy Earring +2",
	}		 
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		ring1="Metamorph Ring +1",
	})
	
	--Duration only spells (Dia, Bio)
	sets.midcast.DurationEnfeebles = {ring1="Kishar Ring", ear1="Snotra Earring", neck="Duelist's Torque +1",
	hands="Regal Cuffs", head="Vitiation Chapeau +3", waist="Obstinate Sash"
	--neck=Duelist's Torque +2",
	}
	
	sets.midcast.Bind = set_combine(sets.midcast.IntEnfeebles, sets.midcast.DurationEnfeebles)
	
	--Used for spells where potency varies (Slow, Paralyze, Blind, Frazzle, etc)
	sets.midcast.EffectMndEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main="Daybreak", sub="Ammurapi Shield", range="", ammo="Regal Gem", ring1="Metamorph Ring +1",
		ear2="Snotra Earring", ear1="Malignance Earring", body="Lethargy Sayon +2",
		hands="Kaykaus Cuffs +1", feet="Vitiation Boots +3", back=mevaSucCape, legs="Lethargy Fuseau +2",
		waist="Luminary Sash"
	})
	
	sets.midcast.EffectIntEnfeebles = set_combine(sets.midcast.IntEnfeebles, {
		range="", ammo="Regal Gem", hands="Regal Cuffs", body="Lethargy Sayon +2",
		feet="Vitiation Boots +3", legs="Volte Brais", waist="Acuity Belt +1", back=maccMatkSucCape
	})
	
	sets.midcast.EffectMndEnfeebles.Resistant = sets.midcast.MndEnfeebles
	sets.midcast.EffectIntEnfeebles.Resistant  = sets.midcast.IntEnfeebles
	
	--Used for spells where potency varies with Enfeebling Magic Skill (Cap: 610)
	sets.midcast.SkillMndEnfeebles = set_combine(sets.midcast.EffectMndEnfeebles, {
		main="Contemplator +1", sub="Mephitis Grip", ear1="Vor Earring", waist="Obstinate Sash",
		legs="Chironic Hose", hands="Lethargy Gantherots +2"	
		--ring1="Stikini Ring +1", -- can remove Mephitis Grip and potentially Vor depending on ML.
	})
	sets.midcast.SkillIntEnfeebles = set_combine(sets.midcast.EffectIntEnfeebles, {
		main="Contemplator +1", sub="Mephitis Grip", ear1="Vor Earring", waist="Obstinate Sash",
		legs="Chironic Hose", hands="Lethargy Gantherots +2"	
		--ring1="Stikini Ring +1", -- can remove Mephitis Grip and potentially Vor depending on ML.
	})
	sets.midcast.SkillMndEnfeebles.Resistant = sets.midcast.EffectMndEnfeebles.Resistant
	sets.midcast.SkillIntEnfeebles.Resistant = sets.midcast.EffectIntEnfeebles.Resistant
	
			 
	sets.midcast['Dispel'] = set_combine(sets.midcast.IntEnfeebles, {neck="Duelist's Torque +1"})
	sets.midcast.Dispelga = set_combine(sets.midcast['Dispel'], {main="Daybreak", sub="Ammurapi Shield"})
    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
		head=empty,body="Crepuscular Cloak", waist="Acuity Belt +1",ear1="Malignance Earring", feet="Lethargy Houseaux +2"
		--feet="Bunzi's Sabots" -- R25. Lethargy Houseaux +2 until R21.
		--legs="Vitiation Tights +3",
		--hands="Raetic Bangles +1",
	})
    sets.midcast.Stun = {
		main="Mpaca's Staff", sub="Clerisy Strap", --sub="Clerisy Strap +1",
		range="Ullr", ammo="", head="Atrophy Chapeau +3", neck="Duelist's Torque +1", --neck="Duelist's Torque +2",
		ear1="Malignance Earring", ear2="Lethargy Earring", --ear2="Lethargy Earring +2",
		body="Atrophy Tabard +3", hands="Regal Cuffs", --hands="Raetic Bangles +1",
		ring1="Stikini Ring +1", ring2="Metamorph Ring +1", --ring2="Stikini Ring +1",
		back="Aurist's Cape +1", waist="Acuity Belt +1", legs="Volte Brais", feet="Vitiation Boots +3"
		--feet="Bunzi's Sabots" (when R20+)
	}
    
    sets.midcast['Elemental Magic'] = {
			main="Bunzi's Rod",
			sub="Ammurapi Shield",
			ammo="Pemphredo Tathlum",
			--ammo="Ghastly Tathlum +1",
			head="Ea Hat +1",
			neck="Saevus Pendant +1",
			--neck="Sibyl Scarf",
			ear1="Regal Earring",
			ear2="Malignance Earring",
			body="Bunzi's Robe",
			hands="Amalric Gages +1",
			ring1="Metamorph Ring +1",
			ring2="Freke Ring",
			back=maccMatkSucCape,
			waist="Acuity Belt +1",
			legs="Bunzi's Pants",
			feet="Vitiation Boots +3"
			--feet="Bunzi's Sabots"
	}
	
	sets.magic_burst = {
        hands="Amalric Gages +1", --(5)
		head="Ea Hat +1",
		--body="Ea Houppelande +1",
		legs="Ea Slops +1"
    }


    sets.midcast.Drain = set_combine(sets.midcast.IntEnfeebles, {
		ring1="Evanescence Ring", main="Rubicundity", sub="Ammurapi Shield",
		ring2="Archon Ring", waist="Fucho-no-Obi", head="Pixie Hairpin +1", feet=merlinicCrackowsDrainAspir})

    sets.midcast.Aspir = sets.midcast.Drain

    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
		main="Colada", sub="Ammurapi Shield",
		head="Telchine Cap", body="Vitiation Tabard +3", hands="Atrophy Gloves +3",
		back=mevaSucCape, legs="Telchine Braconi", feet="Lethargy Houseaux +2", 
		neck="Duelist's Torque +1", waist="Embla Sash", ear2="Lethargy Earring"
		--ear2="Lethargy Earring +2",
		--neck="Duelist's Torque +2",
	}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga", feet="Bunzi's Sabots"})
	
	sets.midcast['Enhancing Magic'] = sets.midcast.EnhancingDuration

    sets.midcast.GainSpell = set_combine( sets.midcast['Enhancing Magic'] , {hands="Vitiation Gloves +3"})
	
	sets.midcast.NoCapEnhancingMagic = set_combine(sets.midcast['Enhancing Magic'], {
		main="Pukulatmuj +1", sub="Forfend +1",
		head="Befouled Crown", neck="Incanter's Torque", ear2="Andoaa Earring", ear1="Mimir Earring", 
		body="Vitiation Tabard +3", hands="Vitiation Gloves +3", ring2="Stikini Ring +1", ring1="Stikini Ring",
		back="Ghostfyre Cape", waist="Olympus Sash", legs="Atrophy Tights +3", feet="Lethargy Houseaux +2"
		--ring1="Stikini Ring +1",
	})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", body="Atrophy Tabard +3", legs="Lethargy Fuseau +2"})

    sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear2="Earthcry Earring",
		legs="Shedir Seraweels"
		})
	
	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
		legs="Shedir Seraweels",
		hands="Regal Cuffs",
		waist="Emphatikos Rope"
	})
        
    sets.buff.ComposureOther = sets.midcast.EnhancingDuration

    sets.buff.Saboteur = {hands="Lethargy Gantherots +2"}
    
    -- Idle sets
    sets.idle = {		
		main="Daybreak",
		sub="Sacro Bulwark",
		ammo="Homiliary",
		head="Vitiation Chapeau +3",
		neck="Loricate Torque +1",
		--neck="Sibyl Scarf",
		ear1="Hearty Earring",
		ear2="Odnowa Earring +1",
		body="Jhakri Robe +2",
		hands="Volte Gloves",
		ring1="Defending Ring",
		--ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=mevaSucCape,
		waist="Carrier's Sash",
		legs="Volte Brais",
		feet="Volte Gaiters"
	}
	sets.idle.DT = set_combine(sets.idle, {
		body="Lethargy Sayon +2",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		ear2="Sanare Earring"
	})
    
    -- Defense sets
    sets.defense.PDT = {
		main="Daybreak", sub="Sacro Bulwark", ammo="Staunch Tathlum +1",
		head="Bunzi's Hat", neck="Warder's Charm +1", ear1="Sanare Earring", ear2="Hearty Earring",
		body="Bunzi's Robe", hands="Bunzi's Gloves", ring1="Shadow Ring", ring2="Purity Ring",
		back=mevaSucCape, waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots"
	}

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {range="", ammo="Coiste Bodhar", head="Malignance Chapeau",
		body="Malignance Tabard", neck="Clotharius Torque", 
		ear1="Telos Earring", ear2="Sherida Earring", hands="Malignance Gloves",
		ring1="Chirich Ring +1", ring2="Chirich Ring +1", back=storeTPSucCape,
		waist="Sailfi Belt +1", legs="Nyame Flanchard",
		feet="Malignance Boots"
		--ear2="Lethargy Earring +2",
	}
	sets.engaged.DW = set_combine(sets.engaged, {waist="Reiki Yotai", ear1="Suppanomimi"})
	sets.engaged.DT = set_combine(sets.engaged, {
		-- Base: 36%
		ring1="Defending Ring", -- 10%
		waist="Flume Belt", -- P4%
		---------------------------
		-- DT-46%, PDT-4(50)%
	})
	
	sets.engaged.Acc = set_combine(sets.engaged, {ear1="Telos Earring", neck="Combatant's Torque", waist="Grunfeld Rope"})
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {ear1="Telos Earring", neck="Combatant's Torque"})
	
	-- WS Sets
	sets.precast.WS['Evisceration'] = {head="Malignance Chapeau", neck="Fotia Gorget", ear1="Dominance Earring +1", ear2="Sherida Earring", 
				hands="Malignance Gloves", ring1="Ilabrat Ring", ring2="Begrudging Ring", back=critSucCape, waist="Fotia Belt",
				legs="Carmine Cuisses +1", feet="Thereoid Greaves", body="Vitiation Tabard +3", ammo="Yetshila"
				--head="Blistering Sallet +1",
				--ammo="Yetshila +1",
				--legs="Zoar Subligar +1"
				}
	sets.precast.WS['Chant du Cygne'] = sets.precast.WS['Evisceration'] 
	
	sets.precast.WS['Savage Blade'] = {head="Nyame Helm", neck="Duelist's Torque +1", ear1="Ishvara Earring", ear2="Moonshade Earring",
		body="Nyame Mail", hands="Nyame Gauntlets", ring1="Karieyh Ring +1", ring2="Rufescent Ring", back=savageSucCape, 
		waist="Sailfi Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets", ammo="Coiste Bodhar"
		--neck="Republican Platinum Medal",
		--ear2="Lethargy Earring +2",
		--ring1="Epaminonda's Ring",
	}
	sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Seraph Blade'] = {head="Nyame Helm", neck="Baetyl Pendant", ear1="Moonshade Earring", ear2="Malignance Earring",
		body="Nyame Mail", hands="Jhakri Cuffs +2", ring1="Freke Ring", ring2="Karieyh Ring +1", back=mndWsdSucCape, waist="Sacro Cord",
		legs="Nyame Flanchard", feet="Lethargy Houseaux +2", ammo="Pemphredo Tathlum"
		--neck="Sibyl Scarf",
		--waist="Orpheus's Sash",
		--ring2="Epaminonda's Ring",
		--legs="Amalric Slops +1",
	}
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Seraph Blade'], {ear1="Regal Earring", ring1="Archon Ring", head="Pixie Hairpin +1"})
	
	sets.precast.WS['Shining Strike'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Seraph Strike'] = sets.precast.WS['Shining Strike']
	sets.precast.WS['Requiescat'] = sets.precast.WS['Savage Blade'] 

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
	end
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur and not pure_macc_spells:contains(spell.english) and not duration_only:contains(spell.english) then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
		if no_cap_enh_skill:contains(spell.english) then
			equip(sets.midcast.NoCapEnhancingMagic)
		elseif spell.english:contains('Gain-') then
			equip(sets.midcast.GainSpell)
		elseif not spellMap then
			equip(sets.midcast.EnhancingDuration)
			if buffactive.composure and spell.target.type == 'PLAYER' then
				equip(sets.buff.ComposureOther)
				if spellMap == 'Refresh' then
					equip(sets.midcast.Refresh)
				end
			elseif spell.target.type == 'SELF' and spellMap == 'Refresh' then
				equip(sets.midcast.RefreshSelf)
			elseif spell.name == 'Aquaveil' then
				equip(sets.midcast.Aquaveil)
			end
		end 
    elseif spellMap == 'Cure' then
		if spell.target.type == 'SELF' then
			equip(sets.midcast.CureSelf)
		elseif (spell.element == world.day_element or spell.element == world.weather_element) then 
			equip(sets.midcast.CureWeather)
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
			if duration_only:contains(spell.english) then
				return "DurationEnfeebles"
			else
				if spell.type == "WhiteMagic" then
					if pure_macc_spells:contains(spell.english) then
						return "MndEnfeebles"
					elseif enfeebling_magic_skill:contains(spell.english) then
						return "SkillMndEnfeebles"
					else
						return "EffectMndEnfeebles"
					end	
				else 
					if pure_macc_spells:contains(spell.english) then
						return "IntEnfeebles"
					elseif enfeebling_magic_skill:contains(spell.english) then
						return "SkillIntEnfeebles"
					else
						return "EffectIntEnfeebles"
					end	
				end
			end 
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function update_combat_form()
-- Check for H2H or single-wielding
	if player.sub_job == "DNC" or player.sub_job == "NIN" then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end
end