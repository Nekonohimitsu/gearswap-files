-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
	--F9 to Cycle
	state.OffenseMode:options('Normal', 'Anguta', 'Caladbolg', 'Ragnarok', 'Naegling', 'Lycurgos', 'Dolichenus', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.CastingMode:options('Normal', 'Resistant')
	
	--This matches the Offense or Ranged modes according to WS used if it can.
	state.WeaponskillMode:options('Normal', 'Acc')
    state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false
	
	state.LoseTP = M(false, 'TP Lost for Drain/Aspir')
	
	update_subjob_mode()
end

function init_gear_sets()	
	ankouTP = {name="Ankou's mantle", augments={'"Store TP"+10'}}	
	ankouSTRWS = {name="Ankou's mantle", augments={'Weapon skill damage +10%', 'STR+20', 'STR+10'}}
	ankouSTRDA = {name="Ankou's mantle", augments={'"Dbl.Atk."+10', 'STR+20', 'STR+10'}}
	ankouINTDA = {name="Ankou's mantle", augments={'"Dbl.Atk."+10', 'INT+20', 'INT+10'}}
	ankouVITWS = {name="Ankou's mantle", augments={'Weapon skill damage +10%', 'VIT+20', 'VIT+10'}}

	sets.precast.FC = {	
		ammo="Impatiens",
		head="Carmine Mask",
		neck="Orunmila's Torque",
		ear1="Etiolation Earring",
		ear2="Malignance Earring",
		body="Fallen's Cuirass +3",
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Prolix Ring",
		legs="Eschite Cuisses",
		feet=gear.OdyGreavesFC
	}
	
    --------------------------------------
    -- Job Abilities
    --------------------------------------
	
	
	sets.buff['Dark Seal'] = {head="Fallen's Burgeonet"}
	sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
	sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +2"}
	sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +3"}
	sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +3"}
	sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +3"}
		
    --------------------------------------
    -- Spells
    --------------------------------------
	
	
	sets.midcast['Endark II'] = {
		head="Ignominy Burgeonet +2",
		neck="Erra Pendant",
		body="Carmine Scale Mail",
		hands="Fallen's Finger Gauntlets +3",
		ear1="Mani Earring",
		ring2="Evanescence Ring",
		ring1="Stikini Ring +1",
		back="Niht Mantle",
		legs="Eschite Cuisses",
		feet="Ratri Sollerets"
	}
	
	sets.midcast['Dread Spikes'] = {
		ammo="Staunch Tathlum +1",
		head="Hjarrandi Helm",
		neck="Bloodbead Gorget",
		ear1="Odnowa Earring +1",
		ear2="Tuisto Earring",
		body="Heathen's Cuirass +1",
		hands="Ignominy Gauntlets +2",
		ring1="Meridian Ring",
		ring2="Gelatinous Ring +1",
		back="Engulfer Cape +1",
		waist="Flume Belt",
		legs="Ratri Cuisses",
		feet="Ratri Sollerets"
	}
	
	sets.midcast.Absorb = {
		ammo="Pemphredo Tathlum",
		head="Ignominy Burgeonet +2",
		neck="Erra Pendant",
		ear1="Crepuscular Earring",
		ear2="Malignance Earring",
		body="Carmine Scale Mail",
		hands="Pavor Gauntlets",
		ring1="Metamorph Ring +1",
		ring2="Kishar Ring",
		back="Chuparrosa Mantle",
		waist="Eschan Stone",
		legs="Fallen's Flanchard +3",
		feet="Ratri Sollerets"
	}
	
	sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Carmine Mask",
		neck="Erra Pendant",
		ear1="Crepuscular Earring",
		ear2="Malignance Earring",
		body="Flamma Korazin +2",
		hands="Flamma Manopolas +2",
		ring1="Metamorph Ring +1",
		ring2="Stikini Ring +1",
		waist="Eschan Stone",
		legs="Sakpata's Cuisses",
		feet="Ignominy Sollerets +3"
	}
	
	sets.midcast.Absorb.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Hjarrandi Helm",
		back="Chuparrosa Mantle"
	})
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {
		back="Niht Mantle"
	})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], sets.precast.FC)
	
	sets.midcast.Absorb['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
		head="Hjarrandi Helm",
		hands="Heathen's Gauntlets +1",
		feet="Ignominy Sollerets +3",
		ring2="Stikini Ring +1"
	})
	sets.midcast.Absorb['Absorb-TP'].Resistant = sets.midcast.Absorb.Resistant
	
	sets.midcast.Drain = {
		neck="Erra Pendant",
		ear1="Crepuscular Earring",
		ear2="Malignance Earring",
		head="Pixie Hairpin +1",
		body="Carmine Scale Mail",
		hands="Fallen's Finger Gauntlets +3",
		ring1="Archon Ring",
		ring2="Evanescence Ring",
		back="Niht Mantle",
		waist="Austerity Belt +1",
		legs="Fallen's Flanchard +3",
		feet="Ignominy Sollerets +3"
	}
	
	sets.midcast['Drain III'] = set_combine(sets.midcast.Drain, {
		feet="Ratri Sollerets"
	})
	
	sets.midcast['Drain III'].DarkSeal = set_combine(sets.midcast['Drain III'], {
		head="Fallen's Burgeonet",
		body="Carmine Scale Mail"
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Drain.LoseTP = set_combine(sets.midcast.Drain, {
		main="Dacnomania",
		sub="Kaja Grip",
		range="Ullr"
	})
	
	sets.midcast.Aspir.LoseTP = sets.midcast.Drain.LoseTP
	
		
    --------------------------------------
    -- Weapon Skills
    --------------------------------------
	
	
	sets.precast.WS = {
		ammo="Seething Bomblet +1",
		head="Flamma Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
		body="Ignominy Cuirass +3",
		hands="Emicho Gauntlets +1",
		ring1="Karieyh Ring +1",
		ring2="Regal Ring",
		back=ankouSTRWS,
		waist="Fotia Belt",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2"
	}

	sets.precast.WS['Torcleaver'] = {
		ammo="Knobkierrie",
		head="Odyssean Helm",
		neck="Abyssal Bead Necklace +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Ignominy Cuirass +3",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Niqmaddu Ring",
		back=ankouVITWS,
		waist="Fotia Belt",
		legs="Fallen's Flanchard +3",
		feet="Sulevia's Leggings +2"
	}
	
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {
		head="Flamma Zucchetto +2",
		feet="Flamma Gambieras +2"
	})
	
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS['Torcleaver'], {
		neck="Abyssal Bead Necklace +1",
		--ear1="Lugra earring +1",
	})
	
	sets.precast.WS['Scourge'].Acc = set_combine(sets.precast.WS['Scourge'], {
		head="Flamma Zucchetto +2",
		hands="Emicho Gauntlets +1",
		feet="Flamma Gambieras +2"
	})
	
	sets.precast.WS['Resolution'] = {
		ammo="Seething Bomblet +1",
		head="Sakpata's Helm",
		neck="Abyssal Bead Necklace +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=ankouSTRDA,
		waist="Fotia Belt",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2"
	}
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
		ammo="Seething Bomblet +1",
		ring1="Karieyh Ring +1"
	})

	sets.precast.WS['Quietus'] = {
		ammo="Knobkierrie",
		head="Valorous Mask",
		neck="Abyssal Bead Necklace +1",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Ignominy Cuirass +3",
		hands="Odyssean Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Beithir Ring",
		back=ankouSTRWS,
		waist="Fotia Belt",
		legs="Fallen's Flanchard +3",
		feet="Sulevia's Leggings +2"
	}
	sets.precast.WS['Quietus'].Acc = set_combine(sets.precast.WS['Quietus'], {
		head="Flamma Zucchetto +2",
		hands="Emicho Gauntlets +1",
		ammo="Seething Bomblet +1"
	})
	
	sets.precast.WS['Insurgency'] = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		neck="Abyssal Bead Necklace +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		body="Dagon Breastplate",
		hands="Sakpata's Gauntlets",
		ring1="Niqmaddu Ring",
		ring2="Hetairoi Ring",
		back=ankouSTRDA,
		waist="Windbuffet Belt +1",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2"
	}
	sets.precast.WS['Insurgency'].Acc = set_combine(sets.precast.WS['Insurgency'], {
		hands="Emicho Gauntlets +1",
		ear1="Telos Earring",
		ring2="Regal Ring",
		waist="Ioskeha Belt"
	})
	
	sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS['Scourge'], {
		waist="Prosilio Belt +1",
		ear2="Telos Earring",
		ring2="Beithir Ring"
	})
	sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS['Scourge'].Acc, {
		waist="Kentarch Belt +1",
		ear2="Telos Earring",
		ring2="Beithir Ring"
	})
	
	sets.precast.WS['Entropy'] = {
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		neck="Abyssal Bead Necklace +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Dagon Breastplate",
		hands="Odyssean Gauntlets",
		ring1="Shiva Ring +1",
		ring2="Metamorph Ring +1",
		back=ankouINTDA,
		waist="Fotia Belt",
		legs="Ignominy Flanchard +3",
		feet="Sulevia's Leggings +2",
	}
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {
		hands="Emicho Gauntlets +1",
		ammo="Seething Bomblet +1"
	})
	
	sets.precast.WS['Cross Reaper'] = {
		ammo="Knobkierrie",
		head="Valorous Mask",
		neck="Abyssal Bead Necklace +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Ignominy Cuirass +3",
		hands="Odyssean Gauntlets",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=ankouSTRWS,
		waist="Prosilio Belt +1",
		legs="Fallen's Flanchard +3",
		feet="Sulevia's Leggings +2"
	}
	sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'], {
		hands="Emicho Gauntlets +1"
	})
	
	sets.precast.WS['Infernal Scythe'] = {
		ammo="Knobkierrie",
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		body="Fallen's Cuirass +3",
		hands="Fallen's Finger Gauntlets +3",
		ring1="Karieyh Ring +1",
		ring2="Archon Ring",
		back=ankouSTRWS,
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
	
		
    --------------------------------------
    -- TP Sets
    --------------------------------------
    --------------------------------------
    -- Apocalypse
    --------------------------------------
	-- Apocalypse Melee Set
	-- 3-hit: 135
	-- 4-hit: 77
	-- 5-hit: 41
	-- 6-hit: 18
	sets.engaged = { 
		ammo="Coiste Bodhar", -- 3
		head="Flamma Zucchetto +2", -- 6
		neck="Abyssal Bead Necklace +1", -- 6
		ear1="Telos Earring", -- 5
		ear2="Schere Earring",
		body="Dagon Breastplate",
		hands="Sakpata's Gauntlets", -- 2
		ring1="Flamma Ring", -- 5
		ring2="Niqmaddu Ring",
		back=ankouTP, -- 10
		waist="Sailfi Belt +1",
		legs="Ignominy Flanchard +3", 
		feet="Flamma Gambieras +2" -- 6
		--------------------------------
		-- 43 (46) (5-hit)
		-- 1252 (1267) Accuracy
		-- 1947 Attack
		-- 25% Haste
		-- 32% (37%) DA, 12% TA, 3% QA
	}
	
	sets.engaged.DW = sets.engaged
	
	-- Apocalypse Melee Set /SAM (+15 STP)
	-- 3-hit: 120
	-- 4-hit: 62
	-- 5-hit: 26
	-- 6-hit: 3
	sets.engaged.SAM = set_combine(sets.engaged, {
		body="Valorous Mail",
		hands="Emicho Gauntlets +1",
		ear2="Crepuscular Earring",
		--------------------------------
		-- 62 (4-hit)
		-- 1278 Accuracy
		-- 1811 Attack
		-- 27% Haste
		-- 22% (27%) DA, 7% TA, 3% QA
	})
	
    --------------------------------------
    -- Caladbolg
    --------------------------------------
	-- Caladbolg Melee Set
	-- 3-hit: 174
	-- 4-hit: 105 
	-- 5-hit: 64
	-- 6-hit: 37
	sets.engaged.Caladbolg = set_combine(sets.engaged, { 
		body="Valorous Mail", -- 9
		legs="Odyssean Cuisses", -- 5
		ear2="Crepuscular Earring", -- 5
		hands="Emicho Gauntlets +1", -- 5
		waist="Ioskeha Belt",
		--------------------------------
		-- 65 (5-hit)
		-- 1200 Accuracy
		-- 1755 Attack
		-- 25% Haste
		-- 26% DA, 5% TA, 3% QA
		
		--Subtle Blow Set:
		--body="Dagon Breastplate",
		--hands="Sakpata's Gauntlets",
		--ring2="Niqmaddu Ring",
		--ring1="Chirich Ring +1",
		--neck="Clotharius Torque",
		--ear2="Dignitary's Earring",
		--waist="Tempus Fugit"
	})
	
	sets.engaged.DW.Caladbolg = sets.engaged.Caladbolg
	
	-- Caladbolg Melee Set /SAM (+15 STP)
	-- 3-hit: 159
	-- 4-hit: 90 
	-- 5-hit: 49
	-- 6-hit: 22
	sets.engaged.SAM.Caladbolg = set_combine(sets.engaged.Caladbolg, {
		legs="Ignominy Flanchard +3",
		hands="Sakpata's Gauntlets",
		body="Dagon Breastplate",
		ammo="Seething Bomblet +1",
		--waist="Sailfi Belt +1"
		--------------------------------
		-- 48 (51) (5-hit)
		-- 1214 (1202) Accuracy
		-- 1934 (1944) Attack
		-- 23% (26%) Haste
		-- 31% (36%) DA, 10% (12%) TA, 3% QA
	})
	
    --------------------------------------
    -- Ragnarok
    --------------------------------------
	-- Ragnarok Melee Set
	-- 3-hit: 174
	-- 4-hit: 105
	-- 5-hit: 64
	-- 6-hit: 37
	sets.engaged.Ragnarok = set_combine(sets.engaged.Caladbolg, {
	
		--------------------------------
		-- 65 (5-hit)
		-- 1260 Accuracy
		-- 1749 Attack
		-- 25% Haste
		-- 26% DA, 5% TA, 3% QA
	})
	
	sets.engaged.DW.Ragnarok = sets.engaged.Ragnarok
	
	
	-- Ragnarok Melee Set /SAM (+15 STP)
	-- 3-hit: 159
	-- 4-hit: 90
	-- 5-hit: 49
	-- 6-hit: 22
	sets.engaged.SAM.Ragnarok = set_combine(sets.engaged.SAM.Caladbolg, {
		
		--------------------------------
		-- 48 (51) (5-hit)
		-- 1274 (1262) Accuracy
		-- 1928 (1938) Attack
		-- 23% (26%) Haste
		-- 31% (36%) DA, 10% (12%) TA, 3% QA
	})
	
    --------------------------------------
    -- Naegling
    --------------------------------------
	-- Naegling Melee Set
	-- 12-hit: 15
	-- 11-hit: 22
	-- 10-hit: 34
	-- 9-hit: 49
	-- 8-hit: 67
	-- 7-hit: 91
	-- 6-hit: 123
	-- 5-hit: 167
	sets.engaged.Naegling = set_combine(sets.engaged, { 
		ammo="Seething Bomblet +1",
		neck="Ganesha's mala",
		body="Dagon Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Odyssean Cuisses"
	})
	
	--Naegling / Zantetsuken DW Set
	-- 12-hit: 12
	-- 11-hit: 22
	-- 10-hit: 34
	-- 9-hit: 49
	-- 8-hit: 67
	-- 7-hit: 91
	-- 6-hit: 123
	-- 5-hit: 167
	sets.engaged.DW.Naegling = set_combine(sets.engaged.Naegling, {})
	
	-- Naegling Melee Set /SAM (+15 STP)
	-- 12-hit: default
	-- 11-hit: 7
	-- 10-hit: 19
	-- 9-hit: 34
	-- 8-hit: 52
	-- 7-hit: 76
	-- 6-hit: 108
	-- 5-hit: 152
	sets.engaged.SAM.Naegling = set_combine(sets.engaged.Naegling, {})
	
    --------------------------------------
    -- Dolichenus
    --------------------------------------
	-- Dolichenus Melee Set
	-- 12-hit: 29
	-- 11-hit: 40
	-- 10-hit: 54
	-- 9-hit: 71
	-- 8-hit: 93
	-- 7-hit: 120
	-- 6-hit: 157
	sets.engaged.Dolichenus = set_combine(sets.engaged, { 
		ammo="Seething Bomblet +1",
		neck="Ganesha's mala",
		body="Dagon Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Odyssean Cuisses"
	})
	
	-- Dolichenus / Zantetsuken DW Set
	-- 12-hit: 20
	-- 11-hit: 30
	-- 10-hit: 43
	-- 9-hit: 59
	-- 8-hit: 79
	-- 7-hit: 105
	-- 6-hit: 139
	sets.engaged.DW.Dolichenus = set_combine(sets.engaged.Dolichenus, {})
	
	-- Dolichenus Melee Set /SAM (+15 STP)
	-- 12-hit: 14
	-- 11-hit: 25
	-- 10-hit: 39
	-- 9-hit: 56
	-- 8-hit: 78
	-- 7-hit: 105
	-- 6-hit: 142
	sets.engaged.SAM.Dolichenus = set_combine(sets.engaged.Dolichenus, {})
	
    --------------------------------------
    -- Lycurgos
    --------------------------------------
	-- Lycurgos Melee Set
	-- 3-hit: 221
	-- 4-hit: 141
	-- 5-hit: 93
	-- 6-hit: 61
	sets.engaged.Lycurgos = set_combine(sets.engaged, { 
		ammo="Seething Bomblet +1",
		neck="Ganesha's mala",
		body="Dagon Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Odyssean Cuisses"
	})
	
	sets.engaged.DW.Lycurgos = sets.engaged.Lycurgos
	
	-- Lycurgos Melee Set /SAM (+15 STP)
	-- 3-hit: 206
	-- 4-hit: 126
	-- 5-hit: 78
	-- 6-hit: 46
	sets.engaged.SAM.Lycurgos = set_combine(sets.engaged.Lycurgos, {})
	
    --------------------------------------
    -- Anguta
    --------------------------------------
	-- Anguta Melee Set (STP+10)
	-- 3-hit: 119
	-- 4-hit: 62
	-- 5-hit: 27
	-- 6-hit: 5
	sets.engaged.Anguta = set_combine(sets.engaged, {
		body="Valorous Mail", -- 9
		legs="Odyssean Cuisses", -- 5
		ear2="Crepuscular Earring", -- 5
		hands="Emicho Gauntlets +1",
		waist="Ioskeha Belt",
		--------------------------------
		-- 65 (4-hit)
		-- 1207 Accuracy
		-- 1758 Attack
		-- 25% Haste
		-- 26% DA, 5% TA, 3% QA
	})
	
	sets.engaged.DW.Anguta = sets.engaged.Anguta
	
	
	-- Anguta Melee Set /SAM (+25 STP)
	-- 3-hit: 104
	-- 4-hit: 47
	-- 5-hit: 12
	-- 6-hit: default
	sets.engaged.SAM.Anguta = set_combine(sets.engaged.Anguta, {
		legs="Ignominy Flanchard +3",
		hands="Sakpata's Gauntlets",
		body="Dagon Breastplate",
		ammo="Seething Bomblet +1",
		--waist="Sailfi Belt +1"
		--------------------------------
		-- 48 (51) (4-hit)
		-- 1221 (1202) Accuracy
		-- 1937 (1944) Attack
		-- 23% (26%) Haste
		-- 31% (36%) DA, 10% (12%) TA, 3% QA
	})

    --------------------------------------
    -- Accuracy
    --------------------------------------
   
	-- Accuracy Melee Set
	sets.engaged.Acc = set_combine(sets.engaged, { 
		ammo="Seething Bomblet +1",
		head="Flamma Zucchetto +2",
		neck="Abyssal Bead Necklace +1",
		body="Ignominy Cuirass +3",
		hands="Emicho Gauntlets +1",
		ear2="Dominance Earring +1",
		ear1="Telos Earring",
		ring1="Cacoethic ring +1",
		ring2="Regal Ring",
		back=ankouTP,
		waist="Ioskeha Belt",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2"
	})

    --------------------------------------
    -- Defensive/Idle Sets
    --------------------------------------
	sets.defense.PDT = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		neck="Vim Torque +1",
		ear1="Telos Earring",
		ear2="Schere Earring",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		ring1="Flamma Ring",
		ring2="Defending Ring",
		back=ankouTP,
		waist="Sailfi Belt +1",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	}
	
	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
	})
   
	sets.idle = set_combine(sets.defense.PDT, {
		head="",
		body="Lugra Cloak +1",
		neck="Vim Torque +1",
		ear2="Infused Earring",
		ring2="Sheltered Ring",
		ring1="Karieyh Ring +1",
		hands="Volte Moufles",
		legs="Volte Brayettes",
		waist="Flume Belt",
		ammo="Staunch Tathlum +1"
	})
   
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Weather = {waist="Hachirin-no-Obi"}
			   				              
end
				
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if spell.skill == 'Dark Magic' then
			if spellMap == 'Drain' and state.LoseTP.value == true then
				equip(sets.midcast.Drain.LoseTP)
			elseif spellMap == 'Aspir' and state.LoseTP.value == true then
				equip(sets.midcast.Aspir.LoseTP)
			end
			if state.Buff['Dark Seal'] and (spellMap == 'Absorb' or spell.english == 'Dread Spikes' or spell.english == 'Drain III') then
				equip(sets.buff['Dark Seal'])
				if (spell.english == 'Drain III') then
					equip(sets.midcast['Drain III'].DarkSeal)
				end
			end
		end
		if(spell.element == world.day_element or spell.element == world.weather_element) then
			equip(sets.Weather)
		end
	end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 and (player.sub_job == "RDM" or player.sub_job == "DRK" or player.sub_job == "WHM" or player.sub_job == "SCH") then
        idleSet = set_combine(idleSet, sets.idle.refresh)
    end
    return idleSet
end

function job_update(cmdParams, eventArgs)
    update_subjob_mode()
end

function update_subjob_mode()
    if player.sub_job == 'SAM'then
		state.CombatForm:set('SAM')
	elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
    end
end