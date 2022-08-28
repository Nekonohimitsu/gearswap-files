-- Define sets and vars used by this job file.
function init_gear_sets()
	alaunMevaCure = {name="Alaunus's Cape", augments={'"Cure" Potency+10%'}}
	alaunMaccFC = {name="Alaunus's Cape", augments={"Fast Cast +10%"}}
	vanyaHoodConserveMp = {name="Vanya Hood", augments={'"Conserve MP"+6'}}
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
	
	sets.midcast.ConserveMP = { main="Septoptic +1", sub="Thuellaic Ecu +1",
		ammo="Pemphredo Tathlum", head=vanyaHoodConserveMp, neck="Incanter's Torque",
		ear1="Calamitous Earring", ear2="Gifted Earring", body="Vedic Coat",
		hands="Fanatic Gloves", ring2="Kishar Ring", back="Fi Follet Cape +1", 
		ring1="Mephitas's Ring +1", waist="Shinjutsu-No-Obi +1", legs="Vanya Slops",
		feet="Kaykaus Boots +1" }

	define_fc_sets()
	define_ja_buff_sets()
	define_status_removal_sets()
	define_cure_sets()
	define_enhancing_magic_sets()
	define_enfeebling_magic_sets()
    define_divine_magic_sets()
    define_idle_sets()
	
    -- Defense sets
    sets.defense.PDT = { main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
		head="Bunzi's Hat", neck="Warder's Charm +1", ear1="Arete del Luna +1", ear2="Hearty Earring",
		body="Inyanga Jubbah +2", hands="Bunzi's Gloves", ring1="Inyanga Ring", ring2="Defending Ring",
		back=alaunMevaCure, waist="Carrier's Sash", legs="Bunzi's Pants", feet="Bunzi's Sabots" }

    sets.defense.MDT = sets.defense.PDT
	
	sets.engaged = sets.idle
end

function define_fc_sets()
    -- Fast cast sets for spells
    sets.precast.FC = {main=grioFC, sub="Clerisy Strap", ammo="Impatiens",
        head="Bunzi's Hat",neck="Cleric's Torque", ear1="Malignance Earring",
		ear2="Loquacious Earring", body="Inyanga Jubbah +2",hands="Fanatic Gloves",
		ring1="Lebeche Ring", ring2="Kishar Ring", back=alaunMaccFC, waist="Witful Belt", 
		legs="Volte Brais", feet="Volte Gaiters"}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head="", body="Crepuscular Cloak"}) -- 63% Fast Cast
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})
	
    -- -- Midcast Sets
    
    sets.midcast.FastRecast =  set_combine(sets.precast.FC, {
		ammo="Pemphredo Tathlum",
		ring1="Mephitas's Ring +1"
	})
end

function define_ja_buff_sets()
    -- -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = { main="Septoptic +1", sub="Ammurapi Shield",
		--ammo="Psilomene",
		head="Pixie Hairpin +1", body="Piety Bliaut +3", hands="Regal Cuffs",
		legs="Piety Pantaloons +3", neck="Cleric's Torque", back="Fi Follet Cape +1", 
		ring1="Mephitas's Ring", ring2="Mephitas's Ring +1", ear1="Evans Earring",
		ear2="Etiolation Earring", feet="Theophany Duckbills +3", waist="Shinjutsu-No-Obi +1" }
		
	sets.precast.JA.Martyr = {hands="Piety Mitts +3"}
	sets.precast.JA.Devotion = {head="Piety Cap +3"}

    -- -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back="Mending Cape"}
end

function define_status_removal_sets()
	-- Status Removal Sets
	
    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Yagrush", sub="Chanter's Shield"})

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		head="Kaykaus Mitra +1", neck="Debilis Medallion", ear1="Meili Earring",
		ear2="Beatific Earring", body="Ebers Bliaut +1",hands="Fanatic Gloves",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back=alaunMaccFC, waist="Bishop's Sash",
		--ring1="Menelaus's Ring",
		legs="Theophany Pantaloons +3", feet="Gendewitha Galoshes +1"})

	sets.midcast.Esuna = set_combine(sets.midcast.StatusRemoval, {main="Piety Wand", 
		sub="Chanter's Shield"})
	
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})
	
	sets.midcast.Erase.DT = set_combine(sets.midcast.Erase, {
		ammo="Staunch Tathlum +1",
		ear1="Odnowa Earring +1",
		ring1="Defending Ring"
	})
end

function define_cure_sets()
	-------------------------------------------------------------------------------------------------------------------
	-- Cures w/ Solace up
	-------------------------------------------------------------------------------------------------------------------
    sets.midcast.CureSolace = set_combine(sets.midcast.ConserveMP, {
		main="Queller Rod", sub="Sors Shield", neck="Cleric's Torque",
        head="Kaykaus Mitra +1", ear1="Mendicant's Earring",ear2="Glorious Earring",
        body="Ebers Bliaut +1",hands="Theophany Mitts +3", ring2="Lebeche Ring",
        back=alaunMaccFC, legs="Ebers Pantaloons +1", feet="Kaykaus boots +1"
		--ring1="Naji's Loop" (drop Mendicant's Earring)
	})
	
	sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
		main="Chatoyant Staff",
		sub="Clerisy Strap",
		waist="Hachirin-no-obi",
		--ear1="Mendicant's Earring" (When Naji's Loop in base)
	})
	
	sets.midcast.CureSolace.DT = set_combine(sets.midcast.CureSolace, {
		main="Tamaxchi",
		sub="Genmei Shield",
		ring1="Defending Ring", -- 10%
		ammo="Staunch Tathlum +1", -- 3%
		ear1="Odnowa Earring +1", -- 3%
		waist="Acerbic Sash",
		neck="Loricate Torque +1" -- 6%
		--back 5%
		--------------
		-- 27% DT, 10% PDT, 2% MDT
		-- -46 Enmity
		-- 567 Healing Skill 
		-- 53% Cure Potency
		-- 10% Cure Potency II
	})
	
	sets.midcast.CureSolaceWeather.DT = set_combine(sets.midcast.CureSolaceWeather,{
		sub="Giuoco Grip", -- 1% PDT
		ammo="Staunch Tathlum +1", -- 3% DT
		ring1="Defending Ring", -- 10% DT
		ear1="Odnowa Earring +1" -- 3% DT, 2% MDT
		-- back 5%
		--------------
		-- 21% DT, 1% PDT, 3% MDT
		-- -44 Enmity
		-- 567 Healing Skill 
		-- 46% Cure Potency
		-- 10% Cure Potency II
		-- +0.2 Weather
	})
	
	-------------------------------------------------------------------------------------------------------------------
	-- Normal Cures
	-------------------------------------------------------------------------------------------------------------------
	sets.midcast.Cures = set_combine(sets.midcast.CureSolace,{body="Theophany Bliaut +3"})
	sets.midcast.CuresWeather = set_combine(sets.midcast.Cures, {
		main="Chatoyant Staff",
		sub="Clerisy Strap",
		waist="Hachirin-no-obi",
		back="Twilight Cape"
	})
	sets.midcast.Cures.DT = set_combine(sets.midcast.CureSolace.DT,{body="Theophany Bliaut +3"})
	sets.midcast.CuresWeather.DT = set_combine(sets.midcast.CuresWeather)
	
	-------------------------------------------------------------------------------------------------------------------
	-- Curagas
	-------------------------------------------------------------------------------------------------------------------
    sets.midcast.Curagas = set_combine(sets.midcast.Cures)
	sets.midcast.CuragasWeather = set_combine(sets.midcast.CuresWeather)
    sets.midcast.Curagas.DT = set_combine(sets.midcast.Cures.DT)
	sets.midcast.CuragasWeather.DT = set_combine(sets.midcast.CuresWeather.DT)
	
end

function define_enhancing_magic_sets()
	sets.midcast.EnhancingDuration = set_combine(sets.midcast.ConserveMP, {main="Gada",
		sub="Ammurapi Shield", head="Telchine Cap", body="Telchine Chasuble",
		hands="Telchine Gloves", legs="Telchine Braconi", feet="Theophany Duckbills +3",
		waist="Embla Sash"})

	-- Want 500 Enhancing Magic Skill
	-- Currently @ ML22 -- Base Skill: 512 with Light Arts.
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {})
	
	-- Want 500 Enhancing Magic Skill
	-- Currently @ ML22 -- Base Skill: 486 without Light Arts
	sets.midcast.EnhNoLightArts = set_combine(sets.midcast['Enhancing Magic'], {
        ear2="Mimir Earring", -- 10
		ring1="Stikini Ring +1" -- 8
	})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		neck="Nodens Gorget", ear1="Earthcry Earring",
		waist="Siegel Sash", legs="Shedir Seraweels" })
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, { 		
		main="Vadose Rod", sub="Ammurapi Shield", head="Chironic Hat", 
		hands="Regal Cuffs", waist="Emphatikos Rope", legs="Shedir Seraweels"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
		feet="Ebers Duckbills +1"})

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {main="Beneficus",
		sub="Ammurapi Shield", head="Ebers Cap +1", body="Ebers Bliaut +1",
		hands="Ebers Mitts +1", back=alaunMaccFC, legs="Piety Pantaloons +3",
		feet="Ebers Duckbills +1"})
		
	sets.midcast.BarElementNoArts = set_combine(sets.midcast.BarElement, {
		ring1="Stikini Ring +1" -- 8
	})

    sets.midcast.Regen = set_combine(sets.midcast.ConserveMP, {main="Bolelabunga",
		sub="Ammurapi Shield", head="Inyanga Tiara +2", body="Piety Bliaut +3",
		hands="Ebers Mitts +1", legs="Theophany Pantaloons +3", feet="Bunzi's Sabots"})
	
    sets.midcast.Protectra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})

    sets.midcast.Shellra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
end

function define_enfeebling_magic_sets()
	sets.midcast['Enfeebling Magic'] = {main="Contemplator +1", sub="Enki Strap",
		ammo="Pemphredo Tathlum", head="Theophany Cap +3",neck="Erra Pendant",
		ear1="Regal Earring", ear2="Malignance Earring", body="Theophany Bliaut +3",
		hands="Regal Cuffs",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1", waist="Luminary Sash", legs="Chironic Hose",
		feet="Theophany Duckbills +3"}
	
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak",
		sub="Ammurapi Shield", hands="Volte Gloves", legs="Volte Brais"})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {head="",
		body="Crepuscular Cloak"})
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak",
		sub="Ammurapi Shield"})
end

function define_divine_magic_sets()
	sets.midcast.Banish = { main="Mes'yohi Rod", sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum", head="Ipoca Beret", neck="Jokushu Chain", 
		ear1="Malignance Earring", ear2="Regal Earring", body="Vedic Coat",
		hands="Piety Mitts +3", ring2="Metamorph Ring +1", feet="Bunzi's Sabots",
		--ring1="Fenian Ring",
		back="Disperser's Cape", waist="Sacro Cord", legs="Bunzi's Pants"}
	
	sets.midcast['Divine Magic'] = {main="Daybreak", sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum", neck="Saevus Pendant +1", ear1="Malignance Earring",
		ear2="Crematio Earring", body="Vedic Coat", hands="Bunzi's Gloves", ring1="Freke Ring",
		ring2="Metamorph Ring +1", back=alaunMaccFC, waist="Sacro Cord", legs="Bunzi's Pants",
		feet="Bunzi's Sabots", head="Bunzi's Hat"}
		
	sets.midcast.Flash = {ammo="Sapience Orb", neck="Warder's Charm +1", ear1="Friomisi Earring",
		waist="Goading Belt"}
		
	sets.midcast.Repose = set_combine(sets.midcast.MndEnfeebles, {})
end

function define_idle_sets()
	-- Sets to return to when not performing an action.
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Mpaca's Staff", sub="Oneiros Grip",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Hearty Earring",
		ear2="Etiolation Earring", body="Theophany Bliaut +3",hands="Volte Gloves",
		ring1="Inyanga Ring",ring2="Stikini Ring +1", back=alaunMevaCure,
		waist="Carrier's Sash", legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"}
		
	sets.idle.DT = set_combine(sets.idle, {
		--Base: 11% DT
		main="Malignance Pole", -- 20%
		ring2="Defending Ring", -- 10%
		ear2="Odnowa Earring +1", -- 3%
		feet="Bunzi's Sabots" -- 6%
	})
	
	sets.idle.Misery = set_combine(sets.idle, { 
		-- 42% DT, 10% PDT, 5% MDT
		main="Piety Wand", -- 12%
		sub="Genmei Shield", -- 10% PDT
		head="Ayanmo Zucchetto +2", -- 3%
		neck="Loricate Torque +1", -- 6%
		ear2="Odnowa Earring +1", -- 3%, 2% MDT
		ear1="Etiolation Earring", -- 3% MDT
		--body="Shamash Robe",
		--hands="Shrieker's Cuffs",
		ring1="Stikini Ring +1",
		ring2="Defending Ring", -- 10%
		--back="Prodigious Mantle",
		waist="Porous Rope", 
		legs="Ayanmo Cosciales +2", -- 5%
		feet="Ayanmo Gambieras +2" -- 3%
	}) -- No Resistances apart from Silence/Petrify / low Magic Evasion.
		
	sets.Sublimation = {waist="Embla Sash"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
end