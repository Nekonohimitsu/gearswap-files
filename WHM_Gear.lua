-- Define sets and vars used by this job file.
function init_gear_sets()
	alaunMevaCure = {name="Alaunus's Cape", augments={'Enmity-10'}}
	alaunMaccFC = {name="Alaunus's Cape", augments={"Fast Cast +10%"}}
	vanyaHoodConserveMp = {name="Vanya Hood", augments={'"Conserve MP"+6'}}
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
	gadaEnhDur = {name="Gada", augments={"Enh. Mag. eff. dur. +5"}}
	
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
    sets.defense.PDT = { 
		main="Daybreak", sub="Genmei Shield", ammo="Staunch Tathlum +1",
		head="Nyame Helm", neck="Loricate Torque +1", ear1="Odnowa Earring +1", ear2="Genmei Earring",
		body="Nyame Mail", hands="Nyame Gauntlets", ring1="Gelatinous Ring +1", ring2="Shadow Ring",
		back=alaunMevaCure, waist="Carrier's Sash", legs="Nyame Flanchard", feet="Nyame Sollerets" }

    sets.defense.MDT = set_combine(sets.defense.PDT, {
		head="Bunzi's Hat",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
		ear1="Hearty Earring",
		ring1="Purity Ring"
	})
	
	sets.engaged = sets.idle
end

function define_fc_sets()
    -- Fast cast sets for spells
    sets.precast.FC = {main=grioFC, sub="Clerisy Strap", ammo="Impatiens",
        head="Bunzi's Hat",neck="Cleric's Torque", ear1="Malignance Earring",
		ear2="Loquacious Earring", body="Inyanga Jubbah +2",hands="Fanatic Gloves",
		ring1="Lebeche Ring", ring2="Kishar Ring", back="Perimede Cape", waist="Witful Belt", 
		legs="Volte Brais", feet="Volte Gaiters"}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head="", body="Crepuscular Cloak"}) -- 63% Fast Cast
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +2"})
	
    -- -- Midcast Sets
    
    sets.midcast.FastRecast =  set_combine(sets.precast.FC, {
		ammo="Pemphredo Tathlum",
		ring1="Mephitas's Ring +1",
		back=alaunMaccFC,
		neck="Incanter's Torque"
	})
end

function define_ja_buff_sets()
    -- -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = { main="Septoptic +1", sub="Ammurapi Shield",
		--ammo="Psilomene",
		head="Pixie Hairpin +1", body="Ebers Bliaut +2", hands="Regal Cuffs",
		legs="Piety Pantaloons +3", neck="Cleric's Torque", back="Fi Follet Cape +1", 
		ring1="Mephitas's Ring", ring2="Mephitas's Ring +1", ear1="Evans Earring",
		ear2="Etiolation Earring", feet="Theophany Duckbills +3", waist="Shinjutsu-No-Obi +1" }
		
	sets.precast.JA.Martyr = {hands="Piety Mitts +3"}
	sets.precast.JA.Devotion = {head="Piety Cap +3"}

    -- -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +2", back="Mending Cape"}
end

function define_status_removal_sets()
	-- Status Removal Sets
	
    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Yagrush", sub="Chanter's Shield"})

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
		head="Kaykaus Mitra +1", neck="Debilis Medallion", ear1="Meili Earring",
		ear2="Ebers Earring", body="Ebers Bliaut +2",hands="Fanatic Gloves",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back=alaunMaccFC, waist="Bishop's Sash",
		--ring1="Menelaus's Ring",
		--ear2="Ebers Earring +2",
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
		main="Queller Rod", sub="Thuellaic Ecu +1", head="Kaykaus Mitra +1", 
		ear1="Nourishing Earring +1",ear2="Glorious Earring", body="Ebers Bliaut +2",
		hands="Theophany Mitts +3", ring2="Naji's Loop", back=alaunMevaCure,
		legs="Ebers Pantaloons +2", feet="Kaykaus boots +1"
	})
	
	sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
		main="Chatoyant Staff",
		sub="Giuoco Grip",
		neck="Cleric's Torque",
		waist="Hachirin-no-obi",
	})
	
	sets.midcast.CureSolace.DT = set_combine(sets.midcast.CureSolace, {
		ammo="Staunch Tathlum +1", -- 3%
		neck="Loricate Torque +1", -- 6%
		ring1="Defending Ring", -- 10%
		waist="Carrier's Sash",
		sub="Genmei Shield", -- P10%
		---------------------------
		-- Base Set: DT-17% (Remove DT-5% for PDT-10% when cape changes)
		---------------------------
		-- DT-36%, PDT-10(46)%
	})
	
	sets.midcast.CureSolaceWeather.DT = set_combine(sets.midcast.CureSolaceWeather,{
		sub="Giuoco Grip", --P1%
		--sub="Mensch Strap +1",
		ammo="Staunch Tathlum +1", -- 3%
		ring1="Defending Ring", -- 10%
		---------------------------
		-- Base Set: DT-17% (Remove DT-5% for PDT-10% when cape changes)
		---------------------------
		-- DT-30%, PDT-1(31)%
	})
	
	-------------------------------------------------------------------------------------------------------------------
	-- Normal Cures
	-------------------------------------------------------------------------------------------------------------------
	sets.midcast.Cures = set_combine(sets.midcast.CureSolace,{
		sub="Sors Shield", -- Remove when Kaykaus +1
		body="Theophany Bliaut +3",
		--body="Kaykaus Bliaut +1",
		--ear1="Ebers Earring",
		ear1="Mendicant's Earring", -- Change to Ebers when Kaykaus +1
		back="Fi Follet Cape +1",
	})
	sets.midcast.CuresWeather = set_combine(sets.midcast.Cures, {
		main="Chatoyant Staff",
		sub="Giuoco Grip",
		ammo="Esper Stone +1", -- Remove when Kaykaus +1
		waist="Hachirin-no-obi",
		ear1="Nourishing Earring +1", -- Remove when Kaykaus +1
		neck="Cleric's Torque",
		back="Twilight Cape"
	})
	sets.midcast.Cures.DT = set_combine(sets.midcast.Cures,{
		sub="Genmei Shield", -- P10%
		ammo="Staunch Tathlum +1", --3%
		neck="Loricate Torque +1", -- 6%
		ear1="Nourishing Earring +1", -- Remove when Kaykaus +1
		ring1="Defending Ring", -- 10%
		back=alaunMevaCure, --5% (change to PDT-10%)
		---------------------------
		-- Base Set: DT-12%
		---------------------------
		-- DT-36%, PDT-10(46)%
		
	})
	sets.midcast.CuresWeather.DT = set_combine(sets.midcast.CuresWeather, {
		ammo="Staunch Tathlum +1", -- 3%
		--ear2="Ebers Earring +2",
		ring1="Defending Ring", -- 10%
		back=alaunMevaCure, -- 5% (change to PDT-10%)
		---------------------------
		-- Base Set: DT-12%
		---------------------------
		-- DT-30%
	})
	
	-------------------------------------------------------------------------------------------------------------------
	-- Curagas
	-------------------------------------------------------------------------------------------------------------------
    sets.midcast.Curagas = set_combine(sets.midcast.Cures)
	sets.midcast.CuragasWeather = set_combine(sets.midcast.CuresWeather)
    sets.midcast.Curagas.DT = set_combine(sets.midcast.Cures.DT)
	sets.midcast.CuragasWeather.DT = set_combine(sets.midcast.CuresWeather.DT)
	
end

function define_enhancing_magic_sets()
	sets.midcast.EnhancingDuration = set_combine(sets.midcast.ConserveMP, {main=gadaEnhDur,
		sub="Ammurapi Shield", head="Telchine Cap", body="Telchine Chasuble",
		hands="Telchine Gloves", legs="Telchine Braconi", feet="Theophany Duckbills +3",
		waist="Embla Sash", ring1="Defending Ring", ring2="Gelatinous Ring +1",
		neck="Loricate Torque +1", ammo="Staunch Tathlum +1", ear1="Odnowa Earring +1",
		ear2="Mimir Earring", neck="Incanter's Torque"
		--ear2="Ebers Earring +2" -- (DT-3+%)
		-- When ML40+ Remove Mimir Earring
	})

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
		neck="Nodens Gorget", ear1="Earthcry Earring",
		waist="Siegel Sash", legs="Shedir Seraweels" })
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, { 		
		main="Vadose Rod", sub="Ammurapi Shield", head="Chironic Hat", 
		hands="Regal Cuffs", waist="Emphatikos Rope", legs="Shedir Seraweels"})

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
		feet="Ebers Duckbills +2"
	})

    sets.midcast.BarElement = set_combine(sets.midcast.EnhancingDuration, {
		main="Beneficus",
		sub="Ammurapi Shield", head="Ebers Cap +2", body="Ebers Bliaut +2",
		hands="Ebers Mitts +2", back=alaunMaccFC, legs="Piety Pantaloons +3",
		feet="Ebers Duckbills +2"
		})

    sets.midcast.Regen = set_combine(sets.midcast.ConserveMP, {main="Bolelabunga",
		sub="Ammurapi Shield", head="Inyanga Tiara +2", body="Piety Bliaut +3",
		hands="Ebers Mitts +2", legs="Theophany Pantaloons +3", feet="Bunzi's Sabots"})
	
    sets.midcast.Protectra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})

    sets.midcast.Shellra = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
end

function define_enfeebling_magic_sets()
	sets.midcast['Enfeebling Magic'] = {main="Bunzi's Rod", sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum", head="Theophany Cap +3",neck="Erra Pendant",
		ear1="Regal Earring", ear2="Malignance Earring", body="Theophany Bliaut +3",
		hands="Kaykaus Cuffs +1",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1", waist="Obstinate Sash", legs="Chironic Hose",
		feet="Theophany Duckbills +3"
		--ring1="Stikini Ring +1"
		--ear2="Ebers Earring +2"
		}
	
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
		hands="Inyanga Dastanas +2"
	})
	
	sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {head="",
		body="Crepuscular Cloak", waist="Acuity Belt +1", legs="Theophany Pantaloons +3"})
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak",
		sub="Ammurapi Shield"})
end

function define_divine_magic_sets()
	
	sets.midcast['Divine Magic'] = {
		main="Daybreak", sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum", neck="Saevus Pendant +1", ear1="Malignance Earring",
		ear2="Regal Earring", body="Bunzi's Robe", hands="Bunzi's Gloves", ring1="Freke Ring",
		ring2="Metamorph Ring +1", back=alaunMaccFC, waist="Sacro Cord", legs="Bunzi's Pants",
		feet="Bunzi's Sabots", head="Bunzi's Hat"
		--ammo="Ghastly Tathlum +1"
		--ear2="Ebers Earring +2"
		}
		
	sets.midcast.Repose = set_combine(sets.midcast['Enfeebling Magic'], {
		neck="Jokushu Chain",
		hands="Inyanga Dastanas +2",
		legs="Theophany Pantaloons +3",
	})
	
	sets.midcast.Banish = set_combine(sets.midcast.Repose, {
		main="Mes'yohi Rod", sub="Ammurapi Shield", head="Ipoca Beret", neck="Jokushu Chain",
		hands="Piety Mitts +3", back="Disperser's Cape"
		--ring1="Fenian Ring"
	})
end

function define_idle_sets()
	-- Sets to return to when not performing an action.
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Mpaca's Staff", sub="Oneiros Grip",ammo="Homiliary",
        head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Hearty Earring",
		ear2="Etiolation Earring", body="Ebers Bliaut +2",hands="Volte Gloves",
		ring1="Inyanga Ring",ring2="Stikini Ring +1", back=alaunMevaCure,
		waist="Carrier's Sash", legs="Inyanga Shalwar +2",feet="Inyanga Crackows +2"
		--neck="Sibyl Scarf"
		--ear2="Ebers Earring +2"
	}
		
	sets.idle.DT = set_combine(sets.idle, {
		head="Bunzi's Hat",
		--ear2="Ebers Earring +2",
		ear1="Odnowa Earring +1",
		hands="Bunzi's Gloves",
		ring1="Gelatinous Ring +1", -- Change to Defending Ring and Genmei Earring when Sibyl Scarf.
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots"
		-- 44% DT, 51% PDT, 48% MDT
		-- Sibyl/Defending/Genmei: 48% DT, 50% PDT, 50% MDT
	})
	
	sets.idle.Misery = set_combine(sets.idle.DT, { 
		main="Piety Wand", -- 12%
		sub="Genmei Shield", -- 10% PDT
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Etiolation Earring",
		ring1="Shadow Ring"
	})
		
	sets.Sublimation = {waist="Embla Sash"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
end