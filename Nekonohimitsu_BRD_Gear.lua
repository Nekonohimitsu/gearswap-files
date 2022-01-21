-- Define sets and vars used by this job file.
function init_gear_sets()

	maccFCIntarabus = {name="Intarabus's Cape", augments={'CHR+20', 'Mag. Acc+10', '"Fast Cast"+10%', 'Mag. Acc.+20/Mag. Dmg.+20', 'Damage Taken -5%'}}
	mereeIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%'}}
	evisIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10','Damage taken-5%'}}
	dexWsdIntarabus = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	strWsdIntarabus = {name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main="Grioavolr", sub="Clerisy Strap", head="Bunzi's Hat", neck="Orunmila's Torque",
				ear1="Enchanter's Earring +1", ear2="Loquac. Earring", body="Inyanga Jubbah +2", hands="Leyline Gloves",
				ring1="Kishar Ring", ring2="Lebeche Ring", back=maccFCIntarabus, waist="Witful Belt", legs="Volte Brais",
				feet="Volte Gaiters"}

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC, {range="Daurdabla"})
    sets.precast.FC['Honor March'] = set_combine(sets.precast.FC, {range="Marsyas"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {range="Blurred Harp +1", legs="Fili Rhingrave +1"}
    sets.midcast.Lullaby = {range="Blurred Harp +1", hands="Brioso Cuffs +3"}
    sets.midcast.Madrigal = {head="Fili Calot +1", back=maccFCIntarabus}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {legs="Mousai Seraweels"} -- legs="Mousai Seraweels +1"
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast.Carol = {hands="Mousai Gages"} -- hands="Mousai Gages +1"
	sets.midcast.Etude = {head="Mousai Turban"} -- head="Mousai Turban +1"
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    sets.midcast['Magic Finale'] = { }
    sets.midcast['Honor March'] = {range="Marsyas", hands="Fili Manchettes +1"}
	sets.midcast.Mambo = {feet="Mousai Crackows"} -- feet="Mousai Crackows +1"
    sets.midcast.Mazurka = { }
	sets.midcast.Prelude = {back=maccFCIntarabus}
	sets.midcast.Elegy = { } 
	sets.midcast.Requiem = { }
	sets.midcast.Threnody = {body="Mousai Manteel"} -- body="Mousai Manteel +1"
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
		main="Carnwenhan",
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		neck="Moonbow Whistle +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		ring1="Defending Ring",
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
		ear1="Enchanter's Earring +1",
		ear2="Regal Earring",
		body="Fili Hongreline +1",
		hands="Brioso Cuffs +3",
		ring1="Stikini Ring",
		ring2="Stikini Ring +1",
		back=maccFCIntarabus,
		waist="Luminary Sash",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	}
	
	sets.midcast.SongDebuff.DW = {sub="Kali"}
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.SongDebuff, {
		legs="Brioso Cannions +3", body="Brioso Justaucorps +3", ear2="Crepuscular Earring",
		back="Aurist's Cape +1"})
		
	sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak", sub="Ammurapi Shield"})

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.SongDebuff, {
				main="Daybreak",
				legs="Brioso Cannions +3",
				body="Brioso Justaucorps +3",
				ear2="Crepuscular Earring"
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
		sub="Genmei Shield",
		head="Kaykaus Mitra +1",
		body="Kaykaus Bliaut",
		hands="Brioso Cuffs +3",
		ring1="Lebeche Ring",
		ring2="Prolix Ring",
		legs="Ayanmo Cosciales +2",
		feet="Kaykaus Boots +1",
		neck="Orunmila's Torque",
		ear1="Calamitous Earring",
		ear2="Enervating Earring",
		back="Fi Follet Cape +1"
	}
        
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, 
		{main="Chatoyant Staff", sub="Clerisy Strap", waist="Hachirin-no-Obi", ear1="Mendicant's Earring"})
	
	sets.midcast.EnhancingDuration = {head="Telchine Cap", 
				body="Telchine Chasuble", hands="Telchine Gloves", legs="Telchine Braconi",
				main="Daybreak", sub="Ammurapi Shield", waist="Embla Sash"}
				
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
		neck="Debilis Medallion",
		ear1="Beatific Earring",
		ear2="Meili Earring",
		waist="Bishop's Sash"
	})

    
    -- Sets to return to when not performing an action.
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		head="Inyanga Tiara +2",
		neck="Loricate Torque +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		body="Inyanga Jubbah +2",
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

    sets.idle.PDT = set_combine(sets.idle, {ring1="Gelatinous Ring +1", ring2="Defending Ring", legs="Brioso Cannions +3", head="Bunzi's Hat",
				body="Ayanmo Corazza +2", hands="Bunzi's Gloves", feet="Bunzi's Sabots"})

    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle
    
    
    -- Defense sets

    sets.defense.PDT = sets.idle.PDT

    sets.defense.MDT = set_combine(sets.idle, {ring2="Defending Ring"})

    sets.Kiting = {feet="Fili Cothurnes +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {head="Blistering Sallet +1", neck="Bard's Charm", ear1="Telos Earring", ear2="Crepuscular Earring", 
					body="Ayanmo Corazza +2", hands="Bunzi's Gloves", ring1="Ilabrat Ring", ring2="Chirich Ring +1",
					back=mereeIntarabus, waist="Windbuffet Belt +1", legs="Ayanmo Cosciales +2", feet="Ayanmo Gambieras +2"}
	-- WS Sets
	
	sets.precast.WS['Evisceration'] = {head="Ayanmo Zucchetto +2", neck="Fotia Gorget", ear1="Moonshade Earring", ear2="Dominance Earring +1", 
					body="Bihu Justaucorps +3", hands="Ayanmo Manopolas +2", ring1="Ilabrat Ring", ring2="Begrudging Ring",
					back=evisIntarabus, waist="Fotia Belt", legs="Lustratio Subligar +1", feet="Ayanmo Gambieras +2"}
					
	sets.precast.WS["Rudra's Storm"] = {
		head="Nyame Helm", 
		neck="Bard's Charm", 
		ear1="Moonshade Earring", 
		ear2="Dominance Earring +1", 
		body="Bihu Justaucorps +3", 
		hands="Nyame Gauntlets", 
		ring1="Ilabrat Ring", 
		ring2="Karieyh Ring +1",
		back=dexWsdIntarabus, 
		waist="Grunfeld Rope", 
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets"
	}
	
	sets.precast.WS['Mordant Rime'] = {head="Nyame Helm", neck="Bard's Charm", ear1="Regal Earring", ear2="Ishvara Earring", 
					body="Bihu Justaucorps +3", hands="Nyame Gauntlets", ring1="Karieyh Ring +1", ring2="Metamorph Ring +1",
					back=mereeIntarabus, waist="Windbuffet Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets"}
	
	sets.precast.WS['Aeolian Edge'] = {head="Nyame Helm", neck="Baetyl Pendant", ear1="Moonshade Earring", ear2="Friomisi Earring",
					body="Nyame Mail", hands="Nyame Gauntlets", ring1="Karieyh Ring +1", ring2="Metamorph Ring +1", back=maccFCIntarabus,
					waist="Eschan Stone", legs="Nyame Flanchard", feet="Nyame Sollerets"}
					
	sets.precast.WS['Savage Blade'] = {
		head="Nyame Helm",
		neck="Combatant's Torque",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Bihu Justaucorps +3",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Rufescent Ring",
		back=strWsdIntarabus,
		waist="Prosilio Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}

end