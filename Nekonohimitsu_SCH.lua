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
	potencyBasedEnancing = S{"Embrava", "Phalanx", "Barfire", "Barfira", "Barblizzard", "Barblizzara", "Baraero",
		"Baraera", "Barstone", "Barstonra", "Barthunder", "Barthundra", "Barwater", "Barwatera"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')
	send_command('bind !- gs c toggle MagicBurst')
end

function user_unload()
	send_command('unbind !- gs c toggle MagicBurst')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	lughMacc = {name="Lugh's Cape", augments={'INT+20', 'Mag. Acc+10', '"Fast Cast"+10%', 'Mag. Acc.+20/Mag. Dmg.+20', 'Damage Taken -5%'}}
	lughMeva = {name="Lugh's Cape", augments={'Eva.+20/Mag.Eva.+20', 'Damage Taken -5%'}}
	lughNuke = {name="Lugh's Cape", augments={'INT+20','INT+10'}}
	vanyaHoodConserveMp = {name="Vanya Hood", augments={'"Conserve MP"+6'}}
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
	gadaEnhDur = {name="Gada", augments={"Enh. Mag. eff. dur. +5"}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

     sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +3"}
	 sets.precast.JA['Enlightenment'] = {body="Pedagogy Gown +3"}

    -- Fast cast sets for spells

    sets.precast.FC = { -- 81%
		main=grioFC, -- 11
		sub="Clerisy Strap +1", -- 3
		ammo="Impatiens",
		head="Amalric Coif +1", -- 11
		neck="Orunmila's Torque", -- 5
		ear1="Loquacious Earring", -- 2
		ear2="Malignance Earring", -- 4
		body="Zendik Robe", -- 13
		hands="Academic's Bracers +3", -- 9
		ring1="Lebeche Ring",
		ring2="Kishar Ring", -- 4
		back="Perimede Cape",
		waist="Witful Belt", -- 3
		legs="Volte Brais", -- 8
		"Pedagogy Loafers +3", -- 8
	}
	
	-- For when casting with a matching Art (White Magic w/ Light Arts) and no Strategem
	sets.GrimoireCasting = { -- 62% FC
		head="Pedagogy Mortarboard +3",
		feet="Academic's Loafers +3"
	}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})
	
    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		ammo="Sapience Orb",
		ring1="Prolix Ring",
		back="Fi Follet Cape +1",
	})

	sets.midcast.ConserveMP = { -- CAP:100%, TRAIT: 28%
		ammo="Pemphredo Tathlum", -- 4%
		head=vanyaHoodConserveMp, -- 12%
		neck="Incanter's Torque", 
		ear1="Calamitous Earring", -- 4%
		body="Vedic Coat", -- 10%
		hands="Academic's Bracers +3", -- 8%
		ring1="Mephitas's Ring +1", -- 8/15%
		back="Fi Follet Cape +1", -- 5%
		waist="Hachirin-no-Obi", 
		legs="Vanya Slops", -- 12% 
		feet="Kaykaus Boots +1" -- 7%
	}

    sets.midcast.Cure = set_combine(sets.midcast.ConserveMP, {
		main="Tamaxchi",
		sub="Genmei Shield",
		ammo="Esper Stone +1",
		head="Kaykaus Mitra +1",
		ear2="Gifted Earring",
		body="Kaykaus Bliaut +1",
		hands="Pedagogy Bracers +3",
		ring2="Naji's Loop",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1"
	})

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Kaja Grip",
		--sub="Khonsu",
		neck="Lasaia Pendant", -- Remove when Enmity OK.
		waist="Hachirin-no-Obi"
	})
	
    sets.midcast.Cursna = {
		main="Gada",
		sub="Chanter's Shield",
		ammo="Sapience Orb",
		head="Kaykaus Mitra +1",
		neck="Debilis Medallion",
		ear1="Meili Earring",
		ear2="Beatific Earring",
		body="Pedagogy Gown +3",
		hands="Hieros Mittens",
		ring1="Haoma's Ring",
		--ring2="Menelaus's Ring",
		ring2="Haoma's Ring",
		back="Oretania's Cape +1",
		waist="Bishop's Sash",
		legs="Academic's Pants +3",
		feet="Gendewitha Galoshes +1"
	}
	
	sets.midcast.EnhancingDuration = set_combine(sets.midcast.ConserveMP, {
		main="Musa",
		sub="Giuoco Grip",
		head="Telchine Cap",
		body="Pedagogy Gown +3",
		hands="Telchine Gloves",
		waist="Embla Sash",
		legs="Telchine Braconi",
		feet="Telchine Pigaches"
	})

	-- Want 500 Enhancing Magic Skill
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {
		-- Base Duration Set gives 509 with Light Arts.
	})
	
	-- Want 500 Enhancing Magic Skill
	sets.midcast.EnhNoLightArts = set_combine(sets.midcast['Enhancing Magic'], {
		ring1="Stikini Ring +1", -- 8
		main="Gada", -- 18
		sub="Ammurapi Shield",
		ear1="Mimir Earring", -- 10
		legs="Shedir Seraweels", -- 15
		feet="Kaykaus Boots +1", -- 21
	})
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Pedagogy Staff", -- Remove when Musa R15+
		body="Telchine Chasuble",
		head="Arbatel Bonnet +3",
		back="Bookworm's Cape"
	})
	
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1"
	})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry Earring",
		legs="Shedir Seraweels"
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, { 		
		main="Vadose Rod",
		sub="Ammurapi Shield",
		head="Amalric Coif +1", 
		hands="Regal Cuffs",
		waist="Emphatikos Rope",
		legs="Shedir Seraweels"
	})

    sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {
		feet="Pedagogy Loafers +3"
	})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell


    -- -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main="Contemplator +1",
		--sub="Khonsu",
		sub="Kaja Grip",
		ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +3",
		--neck="Argute Stole +2",
		neck="Argute Stole +1",
		ear2="Regal Earring",
		ear1="Malignance Earring",
		--ear2="Arbatel Earring +2",
		body="Academic's Gown +3",
		hands= "Kaykaus Cuffs +1",
		ring2="Stikini Ring +1",
		ring1= "Metamorph Ring +1",
		--ring1="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Obstinate Sash",
		legs="Arbatel Pants +3",
		feet="Arbatel Loafers +3"
	}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ring1="Metamorph Ring +1",
		hands="Arbatel Bracers +3"
	})
	
	sets.midcast.ElementalMagicAccuracy = set_combine(sets.midcast.IntEnfeebles, {
		waist="Acuity Belt +1"
	})
	
	sets.midcast.Impact = set_combine(sets.midcast.ElementalMagicAccuracy, {
		head=empty,
		body="Crepuscular Cloak",
        ring2="Archon Ring",
	})
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
		main="Daybreak",
		sub="Ammurapi Shield"
	})

	-- Burn, Rasp, Choke, etc.
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.ElementalMagicAccuracy, {legs="Agwu's Slops"})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.IntEnfeebles, {
		waist="Acuity Belt +1"
	})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Ammurapi Shield",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ear1="Mani Earring",
		legs="Pedagogy Pants +3",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
		waist="Fucho-no-Obi",
		back="Bookworm's Cape",
		feet="Agwu's Pigaches"
	})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
		main="Mpaca's Staff",
		sub="Clerisy Strap +1",
		ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +3",
		neck="Orunmila's Torque",
		--neck="Voltsurge Torque",
		ear2="Regal Earring",
		ear1="Malignance Earring",
		--ear2="Arbatel Earring +2",
		body="Zendik Robe",
		hands="Academic's Bracers +3",
		ring1="Kishar Ring",
		ring2="Metamorph Ring +1",
		back=lughMacc,
		waist="Witful Belt",
		legs="Volte Brais",
		feet="Pedagogy Loafers +3"
	}

    sets.midcast.Stun.Resistant = sets.midcast['Dark Magic']

    sets.midcast['Elemental Magic'] = {
		main="Bunzi's Rod",
        sub="Ammurapi Shield",	
		ammo="Ghastly Tathlum +1",
		head="Arbatel Bonnet +3",
        neck="Argute Stole +1",
        ear2="Malignance Earring",
		--ear2="Arbatel Earring +2",
        ear1="Regal Earring",
		body="Arbatel Gown +3",
		hands="Arbatel Bracers +3",
		legs="Arbatel Pants +3",
        --legs="Agwu's Slops", -- R30
        feet="Arbatel Loafers +3",
        ring1="Metamorph Ring +1",
        ring2="Freke Ring",
        back=lughNuke,
		waist="Acuity Belt +1"
	}
	
	sets.midcast.Burst = set_combine(sets.midcast['Elemental Magic'], {
		head="Agwu's Cap",
		hands="Agwu's Gages",
		legs="Agwu's Slops"
	})
	
    sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'], {
		head="Pixie Hairpin +1",
		ring1="Archon Ring"
	})
	
	sets.midcast.KaustraBurst = set_combine(sets.midcast.Burst, {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"
	})
	
	sets.midcast.Helix = {
		main="Bunzi's Rod",
		sub="Culminus",
		ammo="Ghastly Tathlum +1",
		head="Agwu's Cap",
		--neck="Argute Stole +2",
		neck="Argute Stole +1",
		ear1="Malignance Earring",
		--ear2="Arbatel Earring +2",
		ear2="Regal Earring",
		body="Arbatel Gown +3",
		hands="Arbatel Bracers +3",
		ring1="Freke Ring",
		ring2="Metamorph Ring +1",
		back=lughNuke,
		waist="Acuity Belt +1",
		--waist="Skrymir Cord +1",
		legs="Arbatel Pants +3",
		feet="Agwu's Pigaches"
	}
	
	sets.midcast.Noctohelix = set_combine(sets.midcast.Helix, {
		head="Pixie Hairpin +1",
		ring1="Archon Ring"
	})
	
	sets.midcast.Luminohelix = set_combine(sets.midcast.Helix, {
		main="Daybreak"
	})
	
	sets.midcast.HelixBurst = set_combine(sets.midcast.Helix, {
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Arbatel Loafers +3"
	})
	
	sets.midcast.NoctoBurst = set_combine(sets.midcast.HelixBurst, {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"
	})
	
	sets.midcast.LuminoBurst = set_combine(sets.midcast.HelixBurst, {
		main="Daybreak"
	})
	
    -- -- Resting sets
	sets.idle = {
		main="Mpaca's Staff",
		sub="Oneiros Grip",
		ammo="Homiliary",
		head="Volte Beret",
		body="Arbatel Gown +3",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Volte Gaiters",
		neck="Sibyl Scarf",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		back=lughMeva,
		waist="Carrier's Sash",
		ring2="Stikini Ring +1",
		ring1="Defending Ring"
		--ring1="Stikini Ring +1",
	}
	
	sets.idle.PDT = set_combine(sets.idle, {
		ammo="Staunch Tathlum +1",
		head="Arbatel Bonnet +3",
		neck="Warder's Charm +1",
		ear2="Sanare Earring",
		ring1="Defending Ring",
		ring2="Shadow Ring", 
		legs="Nyame Flanchard"
	})

    sets.buff.Sublimation = {
		head="Academic's Mortarboard +3",
		body="Pedagogy Gown +3",
		ear2="Savant's Earring",
		waist="Embla Sash"
	}

    -- -- Defense sets
    sets.defense.PDT = {
		main="Malignance Pole",
		sub="Oneiros Grip",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Hearty Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Purity Ring",
		ring2="Shadow Ring",
		back=lughMeva,
		waist="Carrier's Sash",
		legs="Arbatel Pants +3",
		feet="Nyame Sollerets"
	}

    sets.defense.MDT = sets.defense.PDT

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Rapture'] = {head="Arbatel Bonnet +3"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +3"}
	sets.buff['Ebullience'] = {head="Arbatel Bonnet +3"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +3"}
    sets.buff['Immanence'] = set_combine(sets.midcast.FastRecast, {
		main="Ternion Dagger +1",
		sub="Genmei Shield",
		head="Blistering Sallet +1",
		ear2="Odnowa Earring +1",
		legs="Academic's Pants +3",
		feet="Academic's Loafers +3"
	})

    sets.Kiting = {feet="Herald's Gaiters"}
	sets.Weather = {waist="Hachirin-no-Obi"}
	
	-- Melee sets
	sets.MeleeWeapons = {
		main="Mpaca's Staff",
		sub="Kaja Grip"
	}
	sets.engaged = {
		ammo="Oshasha's Treatise",
		--head="Blistering Sallet +1",
		head="Nyame Helm",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back="Aurist's Cape +1",
		waist="Goading Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Arbatel Bonnet +3",
		ear1="Telos Earring",
		ear2="Dominance Earring +1",
		body="Arbatel Gown +3",
		hands="Arbatel Bracers +3",
		legs="Arbatel Pants +3",
		feet="Arbatel Loafers +3"
	})
	
	sets.precast.WS['Omniscience'] = set_combine(sets.midcast.Kaustra, {
		ammo="Oshasha's Treatise",
		body="Arbatel Gown +3",
		hands="Nyame Gauntlets",
		ring2="Cornelia's Ring",
		waist="Luminary Sash",
		legs="Arbatel Pants +3",
		feet="Agwu's Pigaches"
	})
	sets.precast.WS['Cataclysm'] = sets.precast.WS['Omniscience']
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		check_grimoire_casting(spell)
	end
	eventArgs.handled = true
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
		if spellMap == nil or spellMap == '' then
			-- If no map, this is FastRecast
			check_grimoire_casting(spell)
		end
		if (spell.element == world.day_element or spell.element == world.weather_element) and (not spellMap == 'Helix' or spellMap == nil or spellMap == '') then
			equip(sets.Weather)
		end
    end
end

function check_grimoire_casting(spell)
	if spell.type == 'WhiteMagic' and buffactive['Light Arts'] and
	not buffactive['Celerity'] and not buffactive['Accession']
	then
		equip(sets.GrimoireCasting)
		
	elseif spell.type == 'BlackMagic' and buffactive['Dark Arts'] and
	not buffactive['Alacrity'] and not buffactive['Manifestation']
	then
		if spell.english ~= 'Impact' then
			equip(sets.GrimoireCasting)
		end
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' or newValue == 'Acc' then
			equip(sets.MeleeWeapons)
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
		elseif default_spell_map == 'Raise' or default_spell_map == 'Reraise' then
			return "ConserveMP"
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
		elseif spell.skill == 'Enhancing Magic' then
			if potencyBasedEnancing:contains(spell.english) and not buffactive['Light Arts'] and not buffactive['Addendum: White'] then
				return 'EnhNoLightArts'
			end
			if not default_spell_map then
				return 'EnhancingDuration'
			end
		elseif spell.english == 'Kaustra' then
			if state.MagicBurst.value then
				return 'KaustraBurst'
			end
        elseif spell.skill == 'Elemental Magic' then
			if state.MagicBurst.value then
				if default_spell_map == 'Helix' then
					if spell.english == 'Noctohelix' or spell.english == 'Noctohelix II' then
						return 'NoctoBurst'
					elseif spell.english == 'Luminohelix' or spell.english == 'Luminohelix II' then
						return 'LuminoBurst'
					else
						return 'HelixBurst'
					end
				else
					return 'Burst'
				end
			else
				if spell.english == 'Luminohelix' or spell.english == 'Luminohelix II' then
					return 'Luminohelix'
				elseif spell.english == 'Noctohelix' or spell.english == 'Noctohelix II' then
					return 'Noctohelix'
				end
			end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    elseif player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_active_strategems()
    update_sublimation()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end
