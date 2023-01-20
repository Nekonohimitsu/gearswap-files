function init_gear_sets()
	gear.EnmRudiMantle = {name="Rudianos's Mantle", augments={"Enmity+10"}}
	gear.FCRudiMantle = {name="Rudianos's Mantle", augments={'"Fast Cast"+10%'}}
	gear.OdyGreavesDT = {name="Odyssean Greaves", augments={'Damage Taken -3%'}}
	gear.OdyGreavesFC = {name="Odyssean Greaves", augments={'"Fast Cast"+4%'}}
	--------------------------------------
    -- Defense sets
    --------------------------------------
	--Base defense set. No specific damage incoming.
	--HP: 3010
	sets.defense = {
		--main="Burtgang",
		main="Malignance Sword",
		sub="Ochain", 
		ammo="Staunch Tathlum +1",
		head={name="Sakpata's Helm",priority=2}, 
		neck={name="Unmoving Collar +1",priority=3},
		ear1={name="Tuisto Earring",priority=3}, 
		ear2={name="Odnowa Earring +1",priority=3}, 
		body={name="Sakpata's Plate",priority=2},
		hands={name="Sakpata's Gauntlets",priority=2},
		ring1={name="Gelatinous Ring +1",priority=3}, 
		ring2="Shadow Ring", 
		back=gear.EnmRudiMantle, 
		waist="Carrier's Sash",
		legs={name="Chevalier's Cuisses +3",priority=2},
		feet={name="Sakpata's Leggings",priority=2}
	}
	
	--------------------------------------
    -- Full Defense Mode sets
	-- These sets stay equipped full-time through midcasts (midcast sets for enmity will not change, JAs will)
    --------------------------------------
	-- Defense set with emphasis on blocking physical damage.
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	sets.defense.BlockRate = set_combine(sets.defense, {})
	
	-- Defense set with emphasis on reducing magical damage.
	-- F11 to turn mode on. Ctrl-F12 to turn mode off.
	-- HP:2976
	sets.defense.MDT = set_combine(sets.defense, {
		main="Malignance Sword",
		sub="Aegis",
		ammo={name="Happy Egg",priority=3}, 
		head={name="Sakpata's Helm",priority=2},
		neck="Warder's Charm +1",
		ear1={name="Tuisto Earring",priority=3}, 
		ear2={name="Odnowa Earring +1",priority=3}, 
		body={name="Sakpata's Breastplate",priority=2},
		hands={name="Sakpata's Gauntlets",priority=2},
		ring1={name="Gelatinous Ring +1",priority=3}, 
		ring2="Shadow Ring",
		back={name="Moonlight Cape",priority=3}, 
		waist={name="Carrier's Sash",priority=2},
		legs={name="Sakpata's Cuisses",priority=2},
		feet={name="Sakpata's Leggings",priority=2}
	})
	
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	sets.defense.ReRaise = {head="Twilight Helm", body="Twilight Mail"}
	
	-- F10 to turn mode on. Ctrl-F12 to turn mode off. Ctrl-F10 to cycle mode between BlockRate, Reraise, Doom.
	sets.defense.Doom = {ring2="Eshmun's Ring", ring1="Eshmun's Ring", neck="Nicander's Necklace", waist="Gishdubar Sash"}
	
	--------------------------------------
    -- Extra Defense Mode sets
	-- These sets go on top of the normal defense set and do not stay equipped full-time (midcasts for enmity change as expected)
    --------------------------------------
	-- Defense set with emphasis on resisting debuffs.
	--HP: 2997
	sets.StatusResist = {
		main="Malignance Sword",
		sub="Adamas",
		ammo="Staunch Tathlum +1",
		head={name="Sakpata's Helm",priority=2},
		neck={name="Unmoving Collar +1",priority=3},
		ear2={name="Odnowa Earring +1",priority=3},
		ear1="Hearty Earring",
		body={name="Sakpata's Breastplate",priority=2},
		hands={name="Sakpata's Gauntlets",priority=2},
		ring2="Purity Ring",
		ring1={name="Gelatinous Ring +1",priority=3},
		back={name="Moonlight Cape",priority=3},
		waist="Carrier's Sash",
		legs={name="Sakpata's Cuisses",priority=2},
		feet={name="Sakpata's Leggings",priority=2}
	}
	
	sets.MDEF = sets.defense.MDT
		
	-- HP: 3018
	sets.MP = set_combine(sets.defense, {
		ammo="Staunch Tathlum +1",
		head={name="Chevalier's Armet +3",priority=2},
		ear2="Ethereal Earring",
		ring2={name="Moonlight Ring",priority=3},
		waist="Flume Belt",
		feet={name="Reverence Leggings +3",priority=2}
	})
	
	sets.Knockback = {
		back="Philidor Mantle",
		--legs="Dashing Subligar"
	}
	
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

    -- Fast cast sets for spells
    sets.precast.FC = {
		main={name="Sakpata's Sword",priority=2},
		sub={name="Srivatsa",priority=2},
		ammo={name="Egoist's Tathlum",priority=2},
		--head="Carmine Mask +1",
		head="Carmine Mask",
		neck="Orunmila's Torque",
		ear2={name="Odnowa Earring +1",priority=2},
		ear1={name="Tuisto Earring",priority=2},
		body={name="Reverence Surcoat +3",priority=2},
		hands="Leyline Gloves",
		ring1={name="Gelatinous Ring +1",priority=2},
		ring2="Kishar Ring",
		back=gear.FCRudiMantle,
		waist={name="Creed Baudrier",priority=2},
		legs="Eschite Cuisses",
		--feet="Chevalier's Sabatons +3"
		feet="Chevalier's Sabatons +3"
	}
	
    --------------------------------------
    -- Spells
    --------------------------------------
    sets.midcast.FastRecast = sets.precast.FC
        
    sets.midcast.Enmity = {
			main="Brilliance",
			sub={name="Srivatsa",priority=2},
			ammo={name="Egoist's Tathlum",priority=2},
			head="Loess Barbuta +1",
			neck={name="Unmoving Collar +1",priority=2},
			ear1="Trux Earring",
			ear2={name="Cryptic Earring",priority=2},
			body={name="Souveran Cuirass +1",priority=2},
			hands="Caballarius Gauntlets +3",
			ring1="Apeile Ring",
			ring2="Apeile Ring +1",
			back=gear.EnmRudiMantle, 
			waist={name="Creed Baudrier",priority=2},
			legs="Souveran Diechlings +1",
			feet={name="Eschite Greaves",priority=2}
	}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {
		ammo="Sapience Orb",
		ear2={name="Odnowa Earring +1",priority=2},
		body="Reverence Surcoat +3",
		waist="Goading Belt",
		--feet="Chevalier's Sabatons +3",
		feet="Chevalier's Sabatons +3",
	})
	
	sets.midcast.FlashSentinel = {
		main={name="Sakpata's Sword",priority=2},
		sub={name="Srivatsa",priority=2},
		ammo="Sapience Orb",
		--head="Carmine Mask +1",
		head="Carmine Mask",
		neck={name="Unmoving Collar +1",priority=2},
		ear2={name="Odnowa Earring +1",priority=2},
		ear1="Trux Earring",
		body={name="Reverence Surcoat +3",priority=2},
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Defending Ring",
		back=gear.FCRudiMantle,
		waist={name="Creed Baudrier",priority=2},
		legs="Souveran Diechlings +1",
		--feet="Chevalier's Sabatons +3",
		feet="Chevalier's Sabatons +3"
	}

	
	sets.midcast.Reprisal = set_combine(sets.midcast.FastRecast,{})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
		main={name="Sakpata's Sword",priority=2},
		sub={name="Srivatsa",priority=2},
		ammo="Staunch Tathlum +1",
		head={name="Souveran Schaller +1",priority=2}, 
		--neck="Moonlight Necklace",
		neck="Moonlight Necklace", 
		ear1="Knightly Earring",
		--ear2="Chevalier's Earring +2",
		ear2="Chevalier's Earring +1",
		body={name="Souveran Cuirass +1",priority=2},
		--hands="Macabre Gauntlets +1", -- when Moonlight
		hands="Regal Gauntlets", 
		ring2={name="Moonlight Ring",priority=2},
		--ring1={name="Gelatinous Ring +1", priority=2}, -- when Moonlight
		ring1="Supershear Ring", 
		back=gear.EnmRudiMantle,
		waist="Audumbla Sash",
		legs="Caballarius Breeches +3",
		feet=gear.OdyGreavesDT
	}

    sets.midcast.Phalanx = { 
			main={name="Sakpata's Sword",priority=3},
			sub="Priwen",
			ammo="Staunch Tathlum +1",
			head="Odyssean Helm",
			neck="Loricate Torque +1",
			ear1="Sanare Earring",
			ear2={name="Odnowa Earring +1",priority=3},
			--body="Odyssean Chestplate",
			body={name="Sakpata's Plate",priority=2},
			hands={name="Souveran Handschuhs +1",priority=2},
			ring2="Apeile Ring +1",
			ring1={name="Gelatinous Ring +1",priority=3},
			back="Weard Mantle",
			waist="Carrier's Sash",
			legs="Sakpata's Cuisses",
			feet={name="Souveran Schuhs +1",priority=2}
	}
    
	sets.midcast.Phalanx.SIRDPhalanx = {
			main={name="Sakpata's Sword",priority=3},
			sub="Priwen",
			ammo="Staunch Tathlum +1", -- 11%
			head={name="Souveran Schaller +1",priority=3}, -- 20%
			--neck="Moonlight Necklace",
			neck="Knight's Bead Necklace +1",
			--ear1="Halasz Earring",
			ear1={name="Tuisto Earring",priority=3},
			--ear2="Knightly Earring",
			ear2={name="Odnowa Earring +1",priority=3},
			body="Chevalier's Cuirass +3",
			hands={name="Souveran Handschuhs +1",priority=3},
			ring2="Evanescence Ring", -- 5%
			ring1={name="Gelatinous Ring +1",priority=3},
			back="Weard Mantle",
			waist="Audumbla Sash",
			--legs="Sakpata's Cuisses", (when Audumbla, Knightly, Moonlight, Halasz)
			legs="Founder's Hose",
			feet={name="Souveran Schuhs +1",priority=3}
			-- 96/92%
	}
	
	-- Shield Barrier trait increases DEF of Protect based on Shield's DEF value. Srivatsa gives Protect DEF+150.
    sets.midcast.Protect = {ring1="Sheltered Ring", sub="Srivatsa"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
    --------------------------------------
    -- Blue Magic Spells
    --------------------------------------
	
	sets.midcast['Blue Magic'] = {
		main="Brilliance",
		sub={name="Srivatsa",priority=2},
		ammo="Staunch Tathlum +1", 
		head="Loess Barbuta +1",
		--neck="Moonlight Necklace",
		neck="Moonlight Necklace",
		ear1={name="Tuisto Earring",priority=2},
		ear2="Knightly Earring",
		body={name="Souveran Cuirass +1",priority=2},
		hands="Regal Gauntlets", 
		--ring2="Apeile Ring +1", -- when Moonlight
		ring2="Evanescence Ring",
		ring1={name="Gelatinous Ring +1",priority=2},
		back=gear.EnmRudiMantle,
		waist="Audumbla Sash",
		legs="Founder's Hose",
		feet="Eschite Greaves"
	}
	
	sets.midcast['Blue Magic'].NoSIRD = sets.midcast.Enmity
	
	sets.midcast.Sleepga = sets.midcast['Blue Magic']
	
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
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}
	sets.precast.JA['Invincible'] = set_combine(sets.midcast.Enmity, {legs="Caballarius Breeches +3"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.midcast.Enmity, {feet="Reverence Leggings +3"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.midcast.Enmity, {hands="Caballarius Gauntlets +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.midcast.Enmity, {feet="Caballarius Leggings +3"})
    sets.precast.JA['Rampart'] = set_combine(sets.midcast.Enmity, {head="Caballarius Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.midcast.Enmity, {body="Caballarius Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.midcast.Enmity, {feet="Chevalier's Sabatons +3"})
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
