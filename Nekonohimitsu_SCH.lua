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
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    state.MagicBurst = M(false, 'Magic Burst')
end

function user_unload()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	lughMacc = {name="Lugh's Cape", augments={'INT+20', 'Mag. Acc+10', '"Fast Cast"+10%', 'Mag. Acc.+20/Mag. Dmg.+20', 'Damage Taken -5%'}}
	lughMeva = {name="Lugh's Cape", augments={'Eva.+20/Mag.Eva.+20', 'Damage Taken -5%'}}
	merlinicHoodFC = {name="Merlinic Hood", augments={"Fast Cast +5%"}}
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

    sets.precast.FC = { -- 77%
		main=grioFC, -- 11
		sub="Clerisy Strap", -- 2
		ammo="Impatiens",
		head=merlinicHoodFC, -- 13
		--head="Amalric Coif +1", -- 11
		neck="Orunmila's Torque", -- 5
		ear1="Loquacious Earring", -- 2
		ear2="Malignance Earring", -- 4
		--"Pinga Tunic +1", -- 15
		body="Zendik Robe", -- 13
		hands="Academic's Bracers +2", -- 8
		ring1="Lebeche Ring",
		ring2="Kishar Ring", -- 4
		back="Perimede Cape",
		waist="Witful Belt", -- 3
		--legs="Pinga Pants +1", -- 13
		legs="Volte Brais", -- 8
		"Pedagogy Loafers +3", -- 8
	}
	
	-- For when casting with a matching Art (White Magic w/ Light Arts) and no Strategem
	sets.GrimoireCasting = {
		head="Pedagogy Mortarboard +3",
		feet="Academic's Loafers +2"
	}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Crepuscular Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})
	
    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		ammo="Sapience Orb",
		ring1="Prolix Ring",
		back="Fi Follet Cape +1",
		legs="Volte Brais",
		body="Zendik Robe",
	})

	sets.midcast.ConserveMP = {
		main="Grioavolr",
		sub="Giuoco Grip",
		ammo="Pemphredo Tathlum",
		head=vanyaHoodConserveMp,
		neck="Incanter's Torque",
		ear1="Calamitous Earring",
		ear2="Gifted Earring",
		body="Vedic Coat",
		hands="Academic's Bracers +2",
		ring1="Mephitas's Ring +1",
		back="Fi Follet Cape +1",
		waist="Shinjutsu-No-Obi +1",
		legs="Vanya Slops",
		feet="Kaykaus Boots +1"
	}

    sets.midcast.Cure = set_combine(sets.midcast.ConserveMP, {
		main="Tamaxchi",
		sub="Sors Shield",
		--ammo="Pemphredo Tathlum",
		ammo="Esper Stone +1",
		head="Kaykaus Mitra +1",
		--body="Kaykaus Bliaut +1",
		body="Kaykaus Bliaut",
		hands="Pedagogy Bracers +3",
		--ring2="Naji's Loop",
		--legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1"
	})

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Kaja Grip",
		--sub="Khonsu",
		ammo="Esper Stone +1",
		ear2="Mendicant's Earring",
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
		legs="Academic's Pants +2",
		feet="Gendewitha Galoshes +1"
	}
	
	sets.midcast.EnhancingDuration = set_combine(sets.midcast.ConserveMP, {
		--main="Musa",
		--main="Pedagogy Staff",
		main=gadaEnhDur,
		sub="Ammurapi Shield",
		head="Telchine Cap",
		body="Pedagogy Gown +3",
		hands="Telchine Gloves",
		waist="Embla Sash",
		legs="Telchine Braconi",
		feet="Telchine Pigaches"
	})

	-- Want 500 Enhancing Magic Skill
	-- Currently @ ML0 -- Base Skill: 456 with Light Arts.
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {
		-- Base Duration Set gives 533 with Light Arts.
	})
	
	-- Want 500 Enhancing Magic Skill
	-- Currently @ ML0 -- Base Skill: 386 without Light Arts
	sets.midcast.EnhNoLightArts = set_combine(sets.midcast['Enhancing Magic'], {
		-- +32~34 from LA set
		ring1="Stikini Ring", -- 5
		main="Gada", -- 18
		sub="Ammurapi Shield",
		ear1="Mimir Earring", -- 10
		ear2="Andoaa Earring", -- 5
		legs="Shedir Seraweels", -- 15
		feet="Kaykaus Boots +1", -- 21
	})
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		--main="Musa",
		main="Pedagogy Staff",
		sub="Giuoco Grip",
		body="Telchine Chasuble",
		head="Arbatel Bonnet +2",
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
		ear1="Regal Earring",
		ear2="Malignance Earring",
		--body="Academic's Gown +3",
		body="Mallquis Saio +2",
		hands= "Kaykaus Cuffs +1",
		ring2="Stikini Ring +1",
		ring1= "Metamorph Ring +1",
		back="Aurist's Cape +1",
		waist="Obstinate Sash",
		--legs="Academic's Pants +3",
		legs="Chironic Hose",
		--feet="Academic's Loafers +3",
		feet="Mallquis Clogs +2"
	}

    sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles
	
    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		head=empty,
		body="Crepuscular Cloak",
		hands="Regal Cuffs",
        ring2="Archon Ring",
		waist="Acuity Belt +1",
		legs="Pedagogy Pants +3",
		feet="Arbatel Loafers +2"
	})
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
		main="Daybreak",
		sub="Ammurapi Shield"
	})

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.IntEnfeebles, {legs="Agwu's Slops"})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.IntEnfeebles, {
		neck="Erra Pendant",
		--body="Academic's Gown +3",
		ring1="Evanescence Ring",
		ear2="Mani Earring",
	})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Ammurapi Shield",
		head="Pixie Hairpin +1",
		legs="Pedagogy Pants +3",
		ring2="Archon Ring",
		waist="Fucho-no-Obi",
		back="Bookworm's Cape",
		feet="Agwu's Pigaches"
	})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
		main="Mpaca's Staff",
		sub="Clerisy Strap",
		ammo="Pemphredo Tathlum",
		head="Academic's Mortarboard +3",
		neck="Orunmila's Torque",
		--neck="Voltsurge Torque",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Zendik Robe",
		hands="Volte Gloves",
		--hands="Academic's Bracers +3",
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
		ammo="Pemphredo Tathlum",		
		--ammo="Ghastly Tathlum +1",
		head="Pedagogy Mortarboard +3",
		--head="Agwu's Cap",
		--neck="Argute Stole +2",
        neck="Argute Stole +1",
        ear2="Malignance Earring",
		--ear2="Arbatel Earring +2",
        ear1="Regal Earring",
		body="Agwu's Robe",
        hands="Amalric Gages +1",
		--hands="Agwu's Gages",
        legs="Agwu's Slops",
        feet="Agwu's Pigaches",
        ring1="Metamorph Ring +1",
        ring2="Freke Ring",
        back=lughMacc,
		waist="Acuity Belt +1"
	}
	
	sets.midcast.Burst = set_combine(sets.midcast['Elemental Magic'], {
		head="Pedagogy Mortarboard +3",
		hands="Amalric Gages +1"
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
		--ammo="Ghastly Tathlum +1",
		ammo="Pemphredo Tathlum",
		head="Agwu's Cap",
		--neck="Argute Stole +2",
		neck="Argute Stole +1",
		ear2="Malignance Earring",
		ear1="Regal Earring",
		body="Agwu's Robe",
		hands="Amalric Gages +1",
		--hands="Agwu's Gages",
		ring1="Freke Ring",
		ring2="Metamorph Ring +1",
		back=lughMacc,
		waist="Acuity Belt +1",
		--waist="Skrymir Cord +1",
		legs="Agwu's Slops",
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
		head="Pedagogy Mortarboard +3",
		ear2="Crematio Earring",
		feet="Arbatel Loafers +2"
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
		body="Agwu's Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Volte Gaiters",
		--neck="Sibyl Scarf",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		back=lughMeva,
		waist="Carrier's Sash",
		ring2="Stikini Ring +1",
		ring1="Defending Ring"
	}
	
	sets.idle.PDT = set_combine(sets.idle, {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		legs="Agwu's Slops",
		hands="Nyame Gauntlets"
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
		legs="Agwu's Slops",
		feet="Nyame Sollerets"
	}

    sets.defense.MDT = sets.defense.PDT

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Rapture'] = {head="Arbatel Bonnet +2"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +2"}
	sets.buff['Klimaform'] = {feet="Arbatel Loafers +2"}

    sets.Kiting = {feet="Herald's Gaiters"}
	sets.Weather = {waist="Hachirin-no-Obi"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		check_grimoire_casting(spell)
	end
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
        if newValue == 'Normal' then
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
			if potencyBasedEnancing:contains(spell.english) and not buffactive['Light Arts'] then
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
