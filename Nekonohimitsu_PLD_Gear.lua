function init_gear_sets()
	gear.EnmRudiMantle = {name="Rudianos's Mantle", augments={"Enmity+10"}}
	gear.FCRudiMantle = {name="Rudianos's Mantle", augments={'"Fast Cast"+10%'}}
	gear.OdyGreavesDT = {name="Odyssean Greaves", augments={'Damage Taken -3%'}}
	gear.OdyGreavesFC = {name="Odyssean Greaves", augments={'"Fast Cast"+4%'}}
	--------------------------------------
    -- Defense sets
    --------------------------------------
	--Base defense set. No specific damage incoming.
	--HP: 3017 (3217)
	sets.defense = {
		main="Malignance Sword",
		sub="Ochain", 
		head={name="Souveran Schaller +1",priority=2}, 
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets", 
		back=gear.EnmRudiMantle, 
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses", 
		feet={name="Souveran Schuhs +1",priority=2},
		ring2="Gelatinous Ring +1", 
		ring1="Defending Ring", 
		ear1={name="Tuisto Earring",priority=2}, 
		ear2={name="Odnowa Earring +1",priority=2}, 
		neck="Unmoving Collar +1",
		ammo="Staunch Tathlum +1"
	}
	
	--------------------------------------
    -- Full Defense Mode sets
	-- These sets stay equipped full-time through midcasts (midcast sets for enmity will not change, JAs will)
    --------------------------------------
	-- Defense set with emphasis on blocking physical damage.
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	--HP: 3065
	sets.defense.BlockRate = set_combine(sets.defense, {
		main="Nixxer",
		neck="Combatant's Torque",
		--ear1="Zwazo Earring +1",
		ear2="Thureous Earring",
		hands={name="Souveran Handschuhs +1",priority=2},
		waist="Creed Baudrier"
	})
	
	-- Defense set with emphasis on reducing magical damage.
	-- F11 to turn mode on. Ctrl-F12 to turn mode off.
	sets.defense.MDT = set_combine(sets.defense, {
		main="Malignance Sword",
		sub="Aegis",
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		neck="Warder's Charm +1",
		ear1="Sanare Earring",
		ear2="Odnowa Earring +1",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		ring1="Gelatinous Ring +1",
		ring2="Shadow Ring",
		back=gear.EnmRudiMantle,
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	})
	
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	sets.defense.ReRaise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	sets.defense.Doom = {ring2="Eshmun's Ring", ring1="Eshmun's Ring", neck="Nicander's Necklace"}
	
	--------------------------------------
    -- Extra Defense Mode sets
	-- These sets go on top of the normal defense set and do not stay equipped full-time (midcasts for enmity change as expected)
    --------------------------------------
	-- Defense set with emphasis on resisting debuffs.
	--HP: 2564 (3039)
	sets.StatusResist = set_combine(sets.defense, {
		main="Malignance Sword",
		sub="Adamas",
		ammo="Staunch Tathlum +1",
		neck="Knight's Bead Necklace +1",
		--neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Hearty Earring",
		head="Sakpata's Helm",
		hands="Sakpata's Gauntlets",
		ring1="Purity Ring",
		ring2="Gelatinous Ring +1",
		back=gear.EnmRudiMantle,
		--back="Moonlight Cape",
		waist="Carrier's Sash",
		feet="Sakpata's Leggings"
	})
	
	sets.MDEF = sets.defense.MDT
	
    sets.Charm = set_combine(sets.StatusResist, {legs="Souveran Diechlings +1", ear1="Arete del Luna +1"})
	
	sets.MP = {
		waist="Flume Belt",
		sub="Ochain",
		ear2="Ethereal Earring",
		back=gear.EnmRudiMantle,
		hands="Sakpata's Gauntlets",
		feet="Reverence Leggings +3",
		ear1="Odnowa Earring +1",
		neck="Knight's Bead Necklace +1"
	}
	
	sets.Knockback = {
		back="Philidor Mantle",
		--legs="Dashing Subligar"
	}
	
	sets.MP_Knockback = set_combine(sets.MP, sets.Knockback)
	
    --------------------------------------
    -- Idle sets
    --------------------------------------
    sets.idle = sets.defense
    
    sets.Kiting = {legs="Carmine Cuisses +1"}
	
	--------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Cover = {body="Caballarius Surcoat"}

    --------------------------------------
    -- Precast sets
    --------------------------------------
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo={name="Egoist's Tathlum",priority=2}, head={name="Souveran Schaller +1",priority=2},
			neck={name="Bloodbead Gorget",priority=2}, ear1={name="Tuisto Earring",priority=2}, ear2="Nourishing Earring +1", body={name="Reverence Surcoat +3",priority=2},
			hands="Caballarius Gauntlets +3", ring1="Stikini Ring +1", ring2={name="Moonlight Ring",priority=2}, back=gear.EnmRudiMantle,
			waist={name="Creed Baudrier",priority=2}, legs="Carmine Cuisses +1", feet="Carmine Greaves"}

    -- Fast cast sets for spells
    sets.precast.FC = set_combine(sets.defense,{sub={name="Srivatsa",priority=2}, ring1={name="Gelatinous Ring +1",priority=2}, ear2={name="Odnowa Earring +1",priority=2},ring2={name="Moonlight Ring",priority=2},
			legs={name="Souveran Diechlings +1",priority=2}, neck={name="Bloodbead Gorget",priority=2}, ammo={name="Egoist's Tathlum",priority=2}, body={name="Reverence Surcoat +3",priority=2}, back=gear.FCRudiMantle,
			main="Sakpata's Sword", head="Carmine Mask", hands="Leyline Gloves", feet=gear.OdyGreavesFC})

    --------------------------------------
    -- Spells
    --------------------------------------
	--Merits 10%
	--Founder's Hose 30%
	--Staunch Tathlum +1 11%
	--Odyssean Greaves 20%
	--Moonbeam Necklace 10%
	--Resolute Belt 8%
	--Bushin Head 15%
	----------------------------
	-- Total: 104% / 102%
	----------------------------
    sets.midcast.FastRecast = set_combine(sets.defense, {head={name="Souveran Schaller +1",priority=2},legs="Founder's Hose", ammo="Staunch Tathlum +1", feet=gear.OdyGreavesDT,
								ear2={name="Odnowa Earring +1",priority=2}, waist="Resolute Belt", body={name="Reverence Surcoat +3",priority=2}, back=gear.FCRudiMantle,
								neck="Moonbeam Necklace", ring1={name="Gelatinous Ring +1",priority=2}, ring2={name="Moonlight Ring",priority=2}})
        
    sets.midcast.Enmity = {main="Brilliance", sub="Srivatsa", head="Loess Barbuta +1", neck="Unmoving Collar +1", ear1="Trux Earring", ear2="Cryptic Earring", body="Souveran Cuirass +1", hands="Yorium Gauntlets",
							ring1="Apeile Ring", ring2="Apeile Ring +1", back=gear.EnmRudiMantle, waist="Creed Baudrier", legs="Souveran Diechlings +1",
							feet="Eschite Greaves", ammo="Iron Gobbet"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {ammo="Sapience Orb"})

	
	sets.midcast.Reprisal = set_combine(sets.midcast.FastRecast, {sub="Srivatsa", ear1="Tuisto Earring", neck="Bloodbead Gorget",
							ring2="Moonlight Ring", waist="Tempus Fugit",back=gear.FCRudiMantle,
							legs="Souveran Diechlings +1", hands="Souveran Handschuhs +1", body="Reverence Surcoat +3", 
							ring1="Kishar Ring", ammo="Sapience Orb", main="Malignance Sword"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {main="Deacon Sword", sub={name="Srivatsa",priority=2}, head={name="Souveran Schaller +1",priority=2}, neck="Moonbeam Necklace", ear1={name="Tuisto Earring",priority=2}, ear2={name="Odnowa Earring +1",priority=2},
						body={name="Souveran Cuirass +1",priority=2}, hands="Sakpata's Gauntlets", ring2={name="Moonlight Ring",priority=2}, ring1="Defending Ring",
						back=gear.EnmRudiMantle, waist="Resolute Belt", legs="Founder's Hose", feet=gear.OdyGreavesDT}

    sets.midcast.Phalanx = {main="Sakpata's Sword", sub="Priwen", ear1={name="Tuisto Earring",priority=2}, neck="Incanter's Torque", hands={name="Souveran Handschuhs +1",priority=2},
							back="Weard Mantle", waist={name="Creed Baudrier",priority=2}, feet="Souveran Schuhs +1", body="Sakpata's Plate", head="Odyssean Helm",
							ammo="Staunch Tathlum +1", ring1="Stikini Ring +1", ring2="Defending Ring", ear2={name="Odnowa Earring +1",priority=2}, legs="Sakpata's Cuisses"}
    
	sets.midcast.Phalanx.SIRDPhalanx = {main="Sakpata's Sword", sub="Priwen", ear1={name="Tuisto Earring",priority=2}, neck="Moonbeam Necklace", hands={name="Souveran Handschuhs +1",priority=2},
							back="Weard Mantle", waist="Resolute Belt", feet=gear.OdyGreavesDT, body="Sakpata's Plate", head={name="Souveran Schaller +1",priority=2},
							ammo="Staunch Tathlum +1", ring1="Stikini Ring +1", ring2={name="Moonlight Ring",priority=2}, ear2={name="Odnowa Earring +1",priority=2}, legs="Founder's Hose"}
	
	-- Shield Barrier trait increases DEF of Protect based on Shield's DEF value. Srivatsa gives Protect DEF+150.
    sets.midcast.Protect = {ring1="Sheltered Ring", sub="Srivatsa"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
    --------------------------------------
    -- Blue Magic Spells
    --------------------------------------
	
	sets.midcast['Blue Magic'] = {main="Brilliance", sub={name="Srivatsa",priority=2}, ammo="Staunch Tathlum +1", head={name="Souveran Schaller +1",priority=2}, 
									neck="Moonbeam Necklace", ear1={name="Tuisto Earring",priority=2},
									ear2="Cryptic Earring", body={name="Souveran Cuirass +1",priority=2}, hands="Yorium Gauntlets", 
									ring2={name="Moonlight Ring",priority=2}, ring1={name="Gelatinous Ring +1",priority=2},
									back=gear.EnmRudiMantle, waist="Resolute Belt", legs="Founder's Hose", feet=gear.OdyGreavesDT}
	
	sets.midcast['Blue Magic'].NoSIRD = sets.midcast.Enmity
	
	--------------------------------------
    -- Job Abilities
    --------------------------------------
	
	sets.midcast.Provoke = sets.midcast.Enmity
	sets.precast.JA['Animated Flourish'] = sets.midcast.Enmity
	sets.midcast.Swordplay = sets.midcast.Provoke
	sets.midcast.Pflug = sets.midcast.Provoke
	sets.midcast.Vallation = sets.midcast.Provoke
	sets.midcast.Swipe = sets.midcast.Provoke
	sets.midcast.Lunge = sets.midcast.Provoke
	
	sets.precast.JA['Invincible'] = set_combine(sets.midcast.Enmity, {legs="Caballarius Breeches +3"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.midcast.Enmity, {})
    sets.precast.JA['Shield Bash'] = set_combine(sets.midcast.Enmity, {hands="Caballarius Gauntlets +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.midcast.Enmity, {feet="Caballarius Leggings +3"})
    sets.precast.JA['Rampart'] = set_combine(sets.midcast.Enmity, {head="Caballarius Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.midcast.Enmity, {body="Caballarius Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.midcast.Enmity, {})--feet="Chevalier's Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.midcast.Enmity, {head="Reverence Coronet +3"})
	
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {main="Naegling", sub="Srivatsa", head="Flamma Zucchetto +2",
					neck="Clotharius Torque", ear1="Telos Earring", ear2="Crepuscular Earring",
					body="Dagon Breastplate", hands="Sakpata's Gauntlets",
					ring1="Cacoethic Ring +1", ring2="Chirich Ring +1",
					back=gear.EnmRudiMantle, waist="Tempus Fugit",
					legs="Sulevia's Cuisses +2", feet="Sakpata's Leggings"}

    sets.engaged.Acc = sets.defense

    sets.engaged.PDT = set_combine(sets.engaged, {head="Sakpata's Helm",
						body="Sakpata's Plate", legs="Sakpata's Cuisses"})
	sets.engaged.FullPDT = sets.defense
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
	
    --------------------------------------
    -- Weapon Skill sets
    --------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {head="Nyame Helm", body="Nyame Mail", hands="Nyame Gauntlets",
					legs="Nyame Flanchard", feet="Nyame Sollerets",neck="Fotia Gorget", waist="Fotia Belt",
					ear1="Moonshade Earring", ear2="Thrud Earring", ring1="Regal Ring", ring2="Karieyh Ring +1", back="Rudianos's Mantle"}

    sets.precast.WS.Acc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS['Sanguine Blade'] = {}
    
    sets.precast.WS['Atonement'] = {}
	
	sets.precast.WS['Aeolian Edge'] = {}
    
end
