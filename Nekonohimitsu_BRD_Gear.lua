-- Define sets and vars used by this job file.
function init_gear_sets()
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
	maccFCIntarabus = {name="Intarabus's Cape", augments={'CHR+20', 'Mag. Acc+10', '"Fast Cast"+10%', 'Mag. Acc.+20/Mag. Dmg.+20', 'Damage Taken -5%'}}
	mereeIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%'}}
	evisIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','Damage taken-5%'}}
	dexWsdIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	strWsdIntarabus = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=grioFC, sub="Clerisy Strap", head="Bunzi's Hat", neck="Orunmila's Torque",
				body="Inyanga Jubbah +2", hands="Volte Gloves", ring1="Kishar Ring", ring2="Lebeche Ring", 
				back=maccFCIntarabus, waist="Witful Belt", legs="Volte Brais", feet="Fili Cothurnes +2"}

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC, {range="Daurdabla"})
    sets.precast.FC['Honor March'] = set_combine(sets.precast.FC, {range="Marsyas"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {range="Blurred Harp +1", legs="Fili Rhingrave +2"} --legs="Fili Rhingrave +3"
    sets.midcast.Lullaby = {range="Blurred Harp +1", hands="Brioso Cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot +2", back=maccFCIntarabus}
    sets.midcast.March = {hands="Fili Manchettes +2"}
    sets.midcast.Minuet = {body="Fili Hongreline +2"}
    sets.midcast.Minne = {legs="Mousai Seraweels +1"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +2"}
    sets.midcast['Honor March'] = {range="Marsyas", hands="Fili Manchettes +2"}
	sets.midcast.Mambo = {feet="Mousai Crackows"} -- feet="Mousai Crackows +1"
	sets.midcast.Prelude = {back=maccFCIntarabus}
	sets.midcast.Threnody = {body="Mousai Manteel"} -- body="Mousai Manteel +1"
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
		main="Carnwenhan",
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +2",
		neck="Moonbow Whistle +1",
		ear1="Hearty Earring",
		ear2="Odnowa Earring +1",
		body="Fili Hongreline +2",
		hands="Fili Manchettes +2",
		ring1="Defending Ring",
		--ring2="Shadow Ring", -- when +3
		ring2="Gelatinous Ring +1",
		back=maccFCIntarabus,
		waist="Carrier's Sash",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	}
	
	sets.midcast.SongEffect.DW = {sub="Kali"}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		neck="Moonbow Whistle +1",
		ear1="Regal Earring",
		--ear1="Fili Earring +2",
		ear2="Fili Earring +1",
		body="Fili Hongreline +2",
		hands="Brioso Cuffs +3",
		ring1="Metamorph Ring +1",
		ring2="Stikini Ring +1",
		back=maccFCIntarabus,
		waist="Acuity Belt +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	}
	
	sets.midcast.SongDebuff.Enmity = {
		--main="Ungeri Staff",
		--sub="Alber Strap",
		main="Daybreak",
		sub="Genmei Shield",
		--head="Halitus Helm",
		head="Nyame Helm",
		neck="Unmoving Collar +1",
		ear1="Trux Earring",
		ear2="Cryptic Earring",
		body="Emet Harness +1",
		hands="Nyame Gauntlets",
		ring1="Supershear Ring",
		ring2="Pernicious Ring",
		back=maccFCIntarabus,
		waist="Flume Belt",
		legs="Zoar Subligar +1",
		feet="Nyame Sollerets"
	}
	
	sets.midcast.SongDebuff.DW = {sub="Kali"}
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.SongDebuff, {back="Aurist's Cape +1"})
		
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield"})

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.SongDebuff, {
		--legs="Fili Rhingrave +3",
		legs="Brioso Cannions +3",
		hands="Fili Manchettes +2"
	})

    -- Song-specific recast reduction
    sets.midcast.SongRecast = sets.precast.FC

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range="Daurdabla"}
    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = sets.midcast.Daurdabla

    -- Other general spells and classes.
    sets.midcast.Cure = {
		main="Daybreak",
		--main="Mafic Cudgel",
		sub="Genmei Shield",
		head="Kaykaus Mitra +1",
		body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		ring1="Defending Ring",
		ring2="Naji's Loop",
		waist="Pythia Sash",
		legs="Kaykaus Tights +1",
		feet="Kaykaus Boots +1",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Fili Earring +1",
		back=maccFCIntarabus
	}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, 
		{main="Chatoyant Staff", sub="Clerisy Strap", waist="Hachirin-no-Obi"})
	
	sets.midcast.EnhancingDuration = {head="Telchine Cap", 
				body="Telchine Chasuble", hands="Telchine Gloves", legs="Telchine Braconi",
				main="Daybreak", sub="Ammurapi Shield", waist="Embla Sash",
				feet="Telchine Pigaches"}
				
    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga", feet="Bunzi's Sabots"})
				
    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry Earring",
		legs="Shedir Seraweels"
		})
        
    sets.midcast.Cursna = set_combine(sets.precast.FC, {
		hands="Hieros Mittens",
		back="Oretania's Cape +1",
		feet="Gendewitha Galoshes +1",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		--ring2="Menelaus's Ring",
		neck="Debilis Medallion",
		ear1="Beatific Earring",
		ear2="Meili Earring",
		waist="Bishop's Sash"
	})

    
    -- Sets to return to when not performing an action.
    
    sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		head="Inyanga Tiara +2",
		neck="Loricate Torque +1",
		ear1="Hearty Earring",
		ear2="Odnowa Earring +1",
		body="Inyanga Jubbah +2",
		--body="Volte Doublet",
		hands="Volte Gloves",
		ring1="Inyanga Ring",
		ring2="Stikini Ring +1",
		back=maccFCIntarabus,
		waist="Carrier's Sash",
		legs="Inyanga Shalwar +2",
		feet="Inyanga Crackows +2"
	}
    
    -- Resting sets
    sets.resting = sets.idle

    sets.idle.PDT = set_combine(sets.idle, {ring1="Defending Ring", legs="Bunzi's Pants", head="Bunzi's Hat",
				body="Bunzi's Robe", hands="Bunzi's Gloves", feet="Bunzi's Sabots"})
    
    
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle.PDT, {
		main="Daybreak",
		sub="Genmei Shield",
		head="Bunzi's Hat",
		--head="Fili Calot +3",
		neck="Warder's Charm +1", 
		ear1="Hearty Earring",
		ear2="Sanare Earring",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		ring1="Defending Ring",
		ring2="Shadow Ring",
		back=maccFCIntarabus,
		waist="Carrier's Sash",
		--legs="Fili Rhingrave +3",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots"
	})

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Fili Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		--head="Bunzi's Hat", (when STP Aug)
		--body="Ashera Harness",
		--neck="Bard's Charm +2"
		head="Blistering Sallet +1", neck="Bard's Charm", ear1="Telos Earring", ear2="Cessance Earring", 
		body="Nyame Mail", hands="Bunzi's Gloves", ring1="Chirich Ring +1", ring2="Chirich Ring +1",
		back=mereeIntarabus, waist="Sailfi Belt +1", legs="Nyame Flanchard", 
		feet="Nyame Sollerets"}
	
	sets.engaged.DW = set_combine(sets.engaged, {
		--ear1="Eabani Earring",
		ear2="Suppanomimi"
	})
	-- WS Sets
	
	sets.precast.WS = {head="Nyame Helm", neck="Baetyl Pendant", ear1="Moonshade Earring", ear2="Friomisi Earring",
					body="Nyame Mail", hands="Nyame Gauntlets", ring1="Karieyh Ring +1", ring2="Metamorph Ring +1", back=maccFCIntarabus,
					waist="Eschan Stone", legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	sets.precast.WS['Evisceration'] = {
		--head="Blistering Sallet +2", (when r15)
		--neck="Bard's Charm +2",
		--ear1="Mache Earring +1",
		--feet="Lustratio Leggings +1",
		head="Ayanmo Zucchetto +2", neck="Fotia Gorget", ear1="Moonshade Earring",
		ear2="Dominance Earring +1", body="Bihu Justaucorps +3", hands="Bunzi's Gloves",
		ring1="Ilabrat Ring", ring2="Begrudging Ring",back=evisIntarabus, waist="Kentarch Belt +1",
		legs="Lustratio Subligar +1", feet="Nyame Sollerets"}
					
	sets.precast.WS["Rudra's Storm"] = {
		head="Nyame Helm", 
		neck="Bard's Charm", 
		--neck="Bard's Charm +2",
		ear1="Moonshade Earring", 
		ear2="Dominance Earring +1", 
		body="Bihu Justaucorps +3", 
		hands="Nyame Gauntlets", 
		ring1="Ilabrat Ring", 
		ring2="Karieyh Ring +1",
		--ring2="Epaminondas's Ring",
		back=dexWsdIntarabus, 
		waist="Kentarch Belt +1", 
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets"
	}
	
	sets.precast.WS['Mordant Rime'] = {
		--neck="Bard's Charm +2",
		--ear2="Fili Earring +2", (when CHR+11 aug)
		head="Nyame Helm", neck="Bard's Charm", ear1="Regal Earring", ear2="Ishvara Earring", 
		body="Nyame Mail", hands="Nyame Gauntlets", ring1="Karieyh Ring +1",
		ring2="Metamorph Ring +1", back=strWsdIntarabus, waist="Fotia Belt", 
		legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	sets.precast.WS['Aeolian Edge'] = {
		head="Nyame Helm", neck="Sibyl Scarf", ear1="Moonshade Earring", 
		ear2="Friomisi Earring", body="Nyame Mail", hands="Nyame Gauntlets", 
		ring1="Karieyh Ring +1", ring2="Shiva Ring +1", back=dexWsdIntarabus,
		waist="Refoccilation Stone", legs="Nyame Flanchard", feet="Nyame Sollerets"
		--ring2="Epaminondas's Ring",
		--waist="Orpheus's Sash",
		}
		
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Aeolian Edge'], {
		head="Pixie Hairpin +1",
		ring1="Archon Ring"
	})
					
	sets.precast.WS['Savage Blade'] = {
		head="Nyame Helm",
		neck="Republican Platinum Medal",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Rufescent Ring",
		--ring2="Epaminondas's Ring",
		back=strWsdIntarabus,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}

end