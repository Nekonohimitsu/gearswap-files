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
end 

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	alaunMevaCure = {name="Alaunus's Cape", augments={'"Cure" Potency+10%'}}
	alaunMaccFC = {name="Alaunus's Cape", augments={"Fast Cast +10%"}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=grioFC, sub="Clerisy Strap",ammo="Impatiens",
        head="Bunzi's Hat",neck="Cleric's Torque",ear1="Malignance Earring", ear2="Loquacious Earring", 
        body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Lebeche Ring", ring2="Kishar Ring",
        back=alaunMaccFC,waist="Witful Belt",legs="Volte Brais",feet="Volte Gaiters"} -- 82% Fast Cast, 26% Haste
		
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head="", body="Crepuscular Cloak"}) -- 63% Fast Cast
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {legs="Ebers Pantaloons +1"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {main="Septoptic +1", sub="Ammurapi Shield",
		head="Pixie Hairpin +1", body="Piety Bliaut +3",
		hands="Regal Cuffs", legs="Piety Pantaloons +3",
		neck="Cleric's Torque", back="Fi Follet Cape +1", 
		ring1="Mephitas's Ring", ring2="Mephitas's Ring +1",
		ear1="Evans Earring", ear2="Etiolation Earring",
		feet="Theophany Duckbills +3",
		waist="Shinjutsu-No-Obi +1"
		}
		
	sets.precast.JA.Martyr = {hands="Piety Mitts +3"}
	sets.precast.JA.Devotion = {head="Piety Cap +3"}
	
    -- Midcast Sets
    
    sets.midcast.FastRecast =  set_combine(sets.precast.FC, {})
    
    -- Cure sets
    gear.default.obi_waist = "Witful Belt"
    gear.default.obi_back = alaunMevaCure

    sets.midcast.CureSolace = {main="Queller Rod",sub="Sors Shield",ammo="Pemphredo Tathlum",
        head="Kaykaus Mitra +1",neck="Cleric's Torque",ear1="Nourishing Earring +1",ear2="Glorious Earring",
        body="Ebers Bliaut +1",hands="Theophany Mitts +3",ring1="Prolix Ring",ring2="Kishar Ring",
        back=alaunMaccFC,waist="Witful Belt",legs="Ebers Pantaloons +1",feet="Kaykaus boots +1"}

    sets.midcast.Cure = set_combine(sets.midcast.CureSolace, {body="Theophany Bliaut +3", ring1="Lebeche Ring", sub="Chanter's Shield"})

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cure.Weather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff",
		sub="Clerisy Strap",
		waist="Hachirin-no-obi",
		back="Twilight Cape"
	})
	
	sets.midcast.Curaga.Weather = sets.midcast.Cure.Weather
	
	sets.midcast.CureSolace.Weather = set_combine(sets.midcast.CureSolace, {
		main="Chatoyant Staff",
		sub="Clerisy Strap",
		waist="Hachirin-no-obi"
	})

    sets.midcast.Cursna = {main="Yagrush",sub="Chanter's Shield", ammo="Sapience Orb",
        head="Bunzi's Hat",neck="Debilis Medallion", ear1="Meili Earring",
		ear2="Beatific Earring", body="Ebers Bliaut +1",hands="Fanatic Gloves",
		--ring1="Menelaus's Ring",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back=alaunMaccFC,
		waist="Bishop's Sash",legs="Theophany Pantaloons +3",
		feet="Gendewitha Galoshes +1"}

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Yagrush", sub="Chanter's Shield"})
	sets.midcast.Esuna = set_combine(sets.midcast.StatusRemoval, {main="Piety Wand", sub="Chanter's Shield"})
	
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})
	
	sets.midcast.ConserveMP = {
		main="Septoptic +1", sub="Thuellaic Ecu +1", ammo="Pemphredo Tathlum",
		head=vanyaHoodConserveMp, neck="Incanter's Torque", ear1="Calamitous Earring",
		ear2="Gifted Earring", body="Vedic Coat", hands="Fanatic Gloves",
		--ring1="Mephitas's Ring +1",
		ring1="Prolix Ring",
		ring2="Kishar Ring", back="Fi Follet Cape +1", waist="Hachirin-no-obi", 
		legs="Vanya Slops", feet="Kaykaus Boots +1"
	}

    
    sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
        head="Befouled Crown",neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Mimir Earring",
        body="Telchine Chasuble",hands="Telchine Gloves", ring1="Stikini Ring", ring2="Stikini Ring +1",
        back="Fi Follet Cape +1",waist="Embla Sash",legs="Telchine Braconi",feet="Theophany duckbills +3"}

	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {main="Gada", sub="Ammurapi Shield",
	head="Telchine Cap", body="Telchine Chasuble", hands="Telchine Gloves", legs="Telchine Braconi",
	feet="Theophany Duckbills +3", waist="Embla Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		main="Gada", sub="Ammurapi Shield",
		head="Telchine Cap", neck="Nodens Gorget", ear1="Earthcry Earring",
		body="Telchine Chasuble", hands="Telchine Gloves", 
		waist="Siegel Sash", legs="Shedir Seraweels", feet="Theophany duckbills +3"
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, { 		
		main="Vadose Rod", sub="Ammurapi Shield",
		head="Chironic Hat", 
		hands="Regal Cuffs", waist="Emphatikos Rope",
		legs="Shedir Seraweels", feet="Theophany duckbills +3"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
		feet="Ebers Duckbills +1"})

    sets.midcast.BarElement = {main="Beneficus",sub="Ammurapi Shield",
        head="Ebers Cap +1",neck="Incanter's Torque", ear1="Andoaa Earring",
        body="Ebers Bliaut +1",hands="Ebers Mitts +1", ring1="Stikini Ring",
		ring2="Stikini Ring +1",back=alaunMaccFC,
		waist="Embla Sash",legs="Piety Pantaloons +3",feet="Ebers Duckbills +1"}
		
	sets.midcast.BarElementNoArts = set_combine(sets.midcast.BarElement, { waist="Olympus Sash" })

    sets.midcast.Regen = {main="Bolelabunga",sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
		head="Inyanga Tiara +2", neck="Orunmila's Torque", ear1="Gifted Earring", ear2="Calamitous Earring",
        body="Piety Bliaut +3",hands="Ebers Mitts +1", 
        back="Fi Follet Cape +1", waist="Embla Sash", legs="Theophany Pantaloons +3", feet="Bunzi's Sabots"}

	sets.midcast.Haste = set_combine(sets.midcast.FastRecast, sets.midcast.EnhancingDuration)
	sets.midcast.Flurry = sets.midcast.Haste
	sets.midcast.Refresh = sets.midcast.Haste
	
    sets.midcast.Protectra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})

    sets.midcast.Shellra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})

    -- Custom spell classes
	sets.midcast['Enfeebling Magic'] = {main="Contemplator +1", sub="Enki Strap", ammo="Pemphredo Tathlum",
        head="Theophany Cap +3",neck="Erra Pendant",ear1="Regal Earring",ear2="Crepuscular Earring",
        body="Theophany Bliaut +3",hands="Regal Cuffs",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back=alaunMaccFC,waist="Luminary Sash",legs="Chironic Hose",feet="Theophany Duckbills +3"}
	
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield", hands="Volte Gloves", legs="Volte Brais"})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {head="", body="Crepuscular Cloak"})
	
	sets.midcast.Banish = set_combine(sets.midcast.IntEnfeebles,
	{
	main="Mes'yohi Rod",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
	head="Ipoca Beret",
	neck="Jokushu Chain",
	ear1="Crepuscular Earring",
	ear2="Regal Earring",
	body="Vedic Coat",
	hands="Piety Mitts +3",
	--ring1="Fenian Ring",
	ring2="Metamorph Ring +1",
	back="Disperser's Cape",
	waist="Sacro Cord",
	legs="Volte Brais",
	feet="Bunzi's Sabots"
	})
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})
	
    sets.midcast['Divine Magic'] = set_combine(sets.midcast.MndEnfeebles, {})
    
    -- Sets to return to when not performing an action.
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak", sub="Genmei Shield",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Etiolation Earring",
        body="Theophany Bliaut +3",hands="Volte Gloves",ring1="Inyanga Ring",ring2="Stikini Ring +1",
        back=alaunMevaCure,waist="Carrier's Sash",legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}
		
	-- Resting sets
    sets.resting = set_combine(sets.idle, {})
		
	sets.Sublimation = {waist="Embla Sash"}
    
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle, {
		head="Ayanmo Zucchetto +2",
		ear1="Odnowa Earring +1",
		hands="Ayanmo Manopolas +2",
		ring1="Defending Ring",
		waist="Porous Rope",
		legs="Ayanmo Cosciales +2",
		feet="Ayanmo Gambieras +2"
	}) -- No Resistances apart from Silence/Petrify / low Magic Evasion.

    sets.defense.MDT = set_combine(sets.idle, {ammo="Staunch Tathlum +1", neck="Loricate Torque +1", body="Inyanga Jubbah +2",
			ear2="Etiolation Earring",ring1="Defending Ring", ring2="Inyanga Ring", back=alaunMevaCure, waist="Slipor Sash",
			ear1="Arete del Luna +1", neck="Warder's Charm +1", head="Bunzi's Hat", hands="Bunzi's Gloves", feet="Bunzi's Sabots"})

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}
	sets.buff['Afflatus Misery'] = {main="Piety Wand"}
	
	sets.engaged = sets.idle
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
				return "CureSolace"
		elseif default_spell_map == 'Raise' or default_spell_map == 'Reraise' then
			return "ConserveMP"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" and not pure_macc_spells:contains(spell.english) then
                return "MndEnfeebles"
            elseif spell.type == "BlackMagic" and not pure_macc_spells:contains(spell.english) then
                return "IntEnfeebles"
            end
        elseif spell.skill == "Enhancing Magic" then
			if buffactive['light arts'] then
				if default_spell_map == 'Enhancing Magic' then
					return "EnhancingDuration"
				end
			end
			if not buffactive['light arts'] and default_spell_map == 'BarElement' then
				return "BarElementNoArts"
			end
		end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs) 
	if (spell.element == world.day_element or spell.element == world.weather_element) then 
		if spellMap == 'Cure' then
			equip(sets.midcast.Cure.Weather)
		elseif spellMap == 'CureSolace' then
			equip(sets.midcast.CureSolace.Weather)
		elseif spellMap == 'Curaga' then
			equip(sets.midcast.Curaga.Weather)
		end
	end
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	idleSet = sets.idle
	if state.Buff['Afflatus Misery'] then
		idleSet = set_combine(idleSet, sets.buff['Afflatus Misery'])
	end
	
	equip(idleSet)
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
	if state.Buff['Afflatus Misery'] then
		idleSet = set_combine(idleSet, sets.buff['Afflatus Misery'])
	end
	
	if (buffactive['Sublimation: Activated']) then
		idleSet = set_combine(idleSet, sets.Sublimation)
	end
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end