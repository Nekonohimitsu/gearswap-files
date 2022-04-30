-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
	--F9 to Cycle
	state.OffenseMode:options('Normal', 'Acc', 'SubtleBlow')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.CastingMode:options('Normal', 'Resistant', 'DT')
	state.HybridMode:options('Normal', 'DT')
	state.IdleMode:options('Normal', 'Regen', 'Refresh')
	
	if not buffactive['Auspice'] then
		classes.CustomMeleeGroups:append('NoAuspice')
	end
	
	-- specify state.CombatWeapon via gs c set CombatWeapon ...
	
	--This matches the Offense or Ranged modes according to WS used if it can.
	state.WeaponskillMode:options('Normal', 'DT', 'Acc', 'Acc.DT')
    state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false
	
	state.LoseTP = M(false, 'TP Lost for Spells')
	storedMain = ""
	storedSub= ""
	
	weaponList = S{'Caladbolg','Apocalypse','Loxotic','Lycurgos',
		'Naegling','Ragnarok','Redemption','Anguta'}	
		
	debuffWSList = S{'Skullbreaker', 'Brainshaker', 'Shield Break', 'Armor Break',
		'Weapon Break', 'Shockwave'}
	
	update_subjob_mode()
	update_combat_weapon()
end

function init_gear_sets()	
	ankouTP = {name="Ankou's mantle", augments={'DEX+20', 'DEX+10', '"Dbl.Atk."+10'}}	
	ankouSTRWS = {name="Ankou's mantle", augments={'Weapon skill damage +10%', 'STR+20', 'STR+10'}}
	ankouSTRDA = {name="Ankou's mantle", augments={'"Dbl.Atk."+10', 'STR+20', 'STR+10'}}
	ankouINTDA = {name="Ankou's mantle", augments={'"Dbl.Atk."+10', 'INT+20', 'INT+10'}}
	ankouVITWS = {name="Ankou's mantle", augments={'Weapon skill damage +10%', 'VIT+20', 'VIT+10'}}

	
	define_spell_and_ja_sets()
	define_ws_sets()
	define_engaged_sets()
	define_idle_dt_sets()   
end

--------------------------------------
-- Job Abilities & Spells
--------------------------------------
function define_spell_and_ja_sets()

	sets.precast.FC = {	--72% FC
		-- Carmine Mask +1 will give 3% additional FC.
		ammo="Sapience Orb",
		--head="Carmine Mask +1" -- Path D
		head="Carmine Mask", -- Path D
		neck="Orunmila's Torque",
		ear1="Malignance Earring",
		ear2="Loquacious Earring",
		body="Sacro Breastplate",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back=ankouINTMACC,
		legs="Eschite Cuisses",
		feet=gear.OdyGreavesFC
	}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head="",
		body="Crepuscular Cloak",
	})
	
	sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
	sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +3"}
	sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +3"}
	sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +3"}
	sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +3"}
	sets.precast.JA.Jump = {
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		neck="Vim Torque +1",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		hands="Emicho Gauntlets +1",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=ankouTP,
		waist="Goading Belt",
		legs="Ratri Cuisses",
		feet="Carmine Greaves"
	}
	
	-- Dark Magic
	sets.midcast['Dark Magic'] = {
		-- Ankou's Mantle (INT+20 MACC+30) provides 40 more MACC over Niht
		-- Carmine Mask / Body +1 provide 11 more MACC over Crepuscular Cloak
		-- Raetic Bangles +1 provide 6 more MACC over Fallen +3
		ammo="Pemphredo Tathlum",
		--head="Carmine Mask +1", -- Path D
		head="",
		neck="Erra Pendant",
		ear1="Malignance Earring",
		ear2="Crepuscular Earring",
		--body="Carmine Scale Mail +1", -- Path A or C
		body="Crepuscular Cloak",
		--hands="Raetic Bangles +1",
		hands="Fallen's Finger Gauntlets +3",
		ring1="Stikini Ring +1",
		ring2="Metamorph Ring +1",
		--back=ankouINTMACC
		back="Niht Mantle",
		waist="Eschan Stone",
		legs="Fallen's Flanchard +3",
		feet="Ignominy Sollerets +3"
	}
	
	sets.midcast['Dark Magic'].DT = set_combine(sets.midcast['Dark Magic'], {
		head="Sakpata's Helm", -- 7%
		body="Nyame Mail", -- 9%
		hands="Sakpata's Gauntlets", --8%
		legs="Nyame Flanchard", -- 8%
		feet="Nyame Sollerets", -- 7%
		ring1="Defending Ring" -- 10%
	})
	
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
		head="Ignominy Burgeonet +3",
		body="Nyame Mail", -- Remove when get Carmine Body +1
		hands="Pavor Gauntlets",
		ring2="Kishar Ring",
		back="Chuparrosa Mantle",
		--feet="Ratri Sollerets +1"
		feet="Ratri Sollerets"
	})
	
	sets.midcast.Absorb.DT = set_combine(sets.midcast.Absorb, {
		ammo="Staunch Tathlum +1", --3%
		body="Nyame Mail", -- 9%
		hands="Sakpata's Gauntlets", --8%
		ring2="Defending Ring", -- 10%
		back=ankouINTDA, -- 5%
		legs="Nyame Flanchard", -- 8%
		feet="Nyame Sollerets" --7%
	})
	
	sets.midcast.Absorb.Resistant = sets.midcast['Dark Magic']
	
	sets.midcast.Absorb['Absorb-TP'] = set_combine(sets.midcast['Dark Magic'], {
		hands="Heathen's Gauntlets +1"
	})
	sets.midcast.Absorb['Absorb-TP'].DT = sets.midcast['Dark Magic'].DT
	sets.midcast.Absorb['Absorb-TP'].Resistant = sets.midcast['Dark Magic']
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		-- Carmine Body +1 will add another 3 Dark Magic Skill and 12 MACC.
		-- Dark Earring will add another 3 Dark Magic Skill.
		head="Pixie Hairpin +1",
		--ear1="Dark Earring",
		ear1="Malignance Earring",
		ear2="Mani Earring",
		--body="Carmine Scale Mail +1", -- Path A or C
		body="Carmine Scale Mail",
		hands="Fallen's Finger Gauntlets +3",
		ring1="Archon Ring",
		ring2="Evanescence Ring",
		back="Niht Mantle",
		waist="Austerity Belt +1",
		legs="Eschite Cuisses"
	})
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Drain.DT = set_combine(sets.midcast.Drain, {
		body="Nyame Mail", -- 9%
		legs="Nyame Flanchard", -- 8%
		feet="Nyame Sollerets", -- 7%
		ring1="Defending Ring", -- 10%
		ear2="Odnowa Earring +1", -- 3%
		ammo="Staunch Tathlum +1" -- 3%
	})
	sets.midcast.Aspir.DT = sets.midcast.Drain.DT
	
	sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {
		ear1="Malignance Earring",
		legs="Fallen's Flanchard +3",
	})
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant
	
	sets.midcast['Drain III'] = set_combine(sets.midcast.Drain, {
		--Upgrading to Ratri +1 will give 5% more duration and 10 more MACC.
		--feet="Ratri Sollerets +1",
		feet="Ratri Sollerets"
	})
		
	-- Enfeebling Magic
	sets.midcast['Enfeebling Magic'] = {
		-- Carmine Mask +1 and Crepuscular Mail will add 24 MACC.
		-- Raetic Bangles +1 will add 17 MACC.
		-- R25 Sakpata's Leggs will add 4 MACC.
		ammo="Pemphredo Tathlum",
		--head="Carmine Mask +1", -- Path D
		head="",
		neck="Erra Pendant",
		ear1="Crepuscular Earring",
		ear2="Malignance Earring",
		--body="Crepuscular Mail",
		body="Crepuscular Cloak",
		--hands="Raetic Bangles +1",
		hands="Sakpata's Gauntlets",
		ring1="Metamorph Ring +1",
		ring2="Stikini Ring +1",
		back=ankouINTDA,
		waist="Eschan Stone",
		--"Sakpata's Cuisses", -- When R25
		legs="Nyame Flanchard",
		feet="Ignominy Sollerets +3"
	}
	sets.midcast['Enfeebling Magic'].DT = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Sakpata's Helm", -- 7%
		neck="Loricate Torque +1", -- 6%
		body="Nyame Mail", -- 9%
		hands="Sakpata's Gauntlets", -- 8%
		back=ankouINTDA, --5%
		legs="Nyame Flanchard", -- 8%
		feet="Nyame Sollerets" -- 7%
	})
	
	sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
		head="",
		body="Crepuscular Cloak",
	})
	sets.midcast.Impact.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {
		head="",
		body="Crepuscular Cloak", -- (+16% DT)
		ring1="Defending Ring", --10%
		ear1="Odnowa Earring +1", -- 3%
		ammo="Staunch Tathlum +1", -- 3%
	})
	
	-- Buffs
	sets.midcast['Endark II'] = {
		-- Casso Sash will give +5 more Dark Skill
		-- Dark Earring will give +3 more Dark Skill
		-- Carmine Body +1 will give +3 more Dark Skill
		-- Ratri +1 will give 5% more duration
		head="Ignominy Burgeonet +3",
		neck="Erra Pendant",
		ear1="Mani Earring",
		--ear2="Dark Earring",
		--body="Carmine Scale Mail +1", -- Path A or C
		body="Carmine Scale Mail",
		hands="Fallen's Finger Gauntlets +3",
		ring2="Evanescence Ring",
		ring1="Stikini Ring +1",
		back="Niht Mantle",
		--waist="Casso Sash",
		legs="Eschite Cuisses",
		--feet="Ratri Sollerets +1",
		feet="Ratri Sollerets"
	}
	sets.midcast['Endark II'].DT = set_combine(sets.midcast['Endark II'], {
		ammo="Staunch Tathlum +1", -- 3%
		ear2="Odnowa Earring +1", -- 3%
		body="Nyame Mail", -- 9%
		ring1="Defending Ring", -- 10%
		--back="Moonlight Cape", -- 6%
		waist="Flume Belt", -- 4% PDT
		legs="Nyame Flanchard", -- 8%
		feet="Nyame Sollerets", -- 7%
	})
	
	sets.MaxHPDread = {
		body="Heathen's Cuirass +1",
	}
	
	sets.midcast['Dread Spikes'] = set_combine(sets.MaxHPDread, {
		ammo="Egoist's Tathlum",
		--head="Ratri Sallet +1",
		head="Hjarrandi Helm",
		--neck="Unmoving Collar +1",
		neck="Bloodbead Gorget",
		ear1="Odnowa Earring +1",
		ear2="Tuisto Earring",
		--hands="Ratri Gadlings +1",
		hands="Sakpata's Gauntlets",
		ring1="Moonlight Ring",
		ring2="Gelatinous Ring +1",
		--back="Moonlight Cape",
		back="Engulfer Cape +1",
		--waist="Steppe Sash",
		waist="Carrier's Sash",
		--legs="Ratri Cuisses +1",
		legs="Ratri Cuisses",
		--feet="Ratri Sollerets +1",
		feet="Ratri Sollerets"
	})
	
	sets.midcast['Dread Spikes'].DT = set_combine(sets.midcast['Dread Spikes'], {
		ammo="Staunch Tathlum +1", --3% Remove when Moonlight Cape
		head="Sakpata's Helm", -- 7%
		ear1="Odnowa Earring +1", -- 3%
		hands="Sakpata's Gauntlets", -- 8%
		ring2="Gelatinous Ring +1", -- 7% PDT
		--back="Moonlight Cape", -- 6%
		waist="Flume Belt", -- 4% PDT
		legs="Sakpata's Cuisses", -- 9%
		feet="Nyame Sollerets", --7%
	})
	
	sets.midcast['Dread Spikes'].LoseTP = {
		--main="Crepuscular Scythe",
		--sub="Utu Grip"
	}
	
	--------------------------------------
	-- Override Sets
	-- This is equipped on top of the active set. Don't use set_combine
	-- unless you want to lock to a particular set. Otherwise, it will 
	-- place this gear on top of the set being used for the spell at cast time.
	--------------------------------------
	-- Upgrading to Fallen's Burgeonet +3 will give 37 more MACC.
	sets.buff['Dark Seal'] = {head="Fallen's Burgeonet"}
	
	sets.midcast['Drain III'].DarkSeal = set_combine(sets.buff['Dark Seal'], {
		body="Carmine Scale Mail" -- temporary while Drain III uses cloak.
	})
	
	sets.midcast.Drain.LoseTP = {
		--Misanthropy will add another 10 MACC.
		--main="Misanthropy",
		main="Dacnomania",
		sub="Kaja Grip",
		range="Ullr"
	}
	sets.midcast.Aspir.LoseTP = sets.midcast.Drain.LoseTP
	
end

--------------------------------------
-- TP Sets
--------------------------------------
function define_engaged_sets() 
	--sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode]
	--[state.DefenseMode][classes.CustomMeleeGroups (any number)]
	sets.engaged = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		neck="Abyssal Beads +1",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring2="Niqmaddu Ring",
		ring1="Hetairoi Ring",
		back=ankouTP,
		waist="Sailfi Belt +1",
		legs="Ignominy Flanchard +3",
		feet="Flamma Gambieras +2"
	}
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Sakpata's Helm", --7%
		body="Sakpata's Breastplate", --10%
		hands="Sakpata's Gauntlets", --8%
		ring1="Moonlight Ring", -- 5%
		back=ankouTP, -- 5%
		legs="Sakpata's Cuisses", -- 9%
		feet="Sakpata's Leggings" -- 6%
	})
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Seething Bomblet +1",
		neck="Combatant's Torque",
		ear2="Dominance Earring +1",
		ring1="Regal Ring",
		ring2="Cacoethic Ring +1",
		back=ankouTP,
		waist="Ioskeha Belt",
		hands="Emicho Gauntlets +1",
		--back="Grounded Mantle +1",
		--waist="Kentarch Belt +1"
	})
	
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {
		-- Ioskeha +1 will give 5 more ACC and 1% more DA.
		ammo="Seething Bomblet +1",
		neck="Combatant's Torque",
		ear2="Dominance Earring +1",
		ring1="Cacoethic Ring +1",
		--waist="Ioskeha Belt +1",
		waist="Ioskeha Belt",
	})
	
	sets.engaged.SubtleBlow = set_combine(sets.engaged, {
		body="Dagon Breastplate", -- 10 II
		hands="Sakpata's Gauntlets", -- 8
		ring2="Niqmaddu Ring", -- 5 II
		ring1="Chirich Ring +1", -- 10
		feet="Sakpata's Leggings", -- 13
		neck="Abyssal Beads +1",
	})
	sets.engaged.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow, {
		-- Base: 31, 15 II
		ear1="Assuage Earring", -- 3
		ear2="Dignitary's Earring", -- 5
		neck="Bathy Choker", -- 10
	})
	
	sets.engaged.SubtleBlow.DT = set_combine(sets.engaged.DT, {
		ammo="Seething Bomblet +1",
		ear2="Odnowa Earring +1",
		body="Dagon Breastplate", -- 10 II
		ring2="Niqmaddu Ring", -- 5 II
		hands="Sakpata's Gauntlets", -- 8
		feet="Sakpata's Leggings", -- 13
		ring1="Chirich Ring +1", -- 10
		neck="Abyssal Beads +1",
	})
	sets.engaged.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT, {
		ear1="Odnowa Earring +1",
		ammo="Seething Bomblet +1",
		-- Base: 31, 15 II
		ear1="Assuage Earring", -- 3
		ear2="Dignitary's Earring", -- 5
		neck="Bathy Choker", -- 10
	})
	
	sets.engaged.SAM = set_combine(sets.engaged, {})
	sets.engaged.SAM.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.SAM.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.SAM.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.SAM.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.SAM.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.SAM.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SAM.SubtleBlow.DT.NoAuspice, {})
	
	define_caladbolg_sets()
	define_apoc_sets()
	define_loxotic_sets()
	define_lycurgos_sets()
	define_naegling_sets()
	define_ragnarok_sets()
	define_redemption_sets()
	define_anguta_sets()
end

function define_caladbolg_sets()
	-- 3-hit: 174
	-- 4-hit: 105 
	-- 5-hit: 64
	-- 6-hit: 37
	-- sets.engaged: 31 STP, 66
	sets.engaged.Caladbolg = set_combine(sets.engaged, {
		-- neck="Abyssal Beads +1",
		-- ear2="Crepuscular Earring",
		-- body="Valorous Mail",
		-- ring2="Flamma Ring",
		-- legs="Odyssean Cuisses"
	})
	-- sets.engaged.DT: 30 STP, 37
	sets.engaged.Caladbolg.DT = set_combine(sets.engaged.DT, {
		neck="Abyssal Beads +1"
	})
	-- sets.engaged.Acc: 31 STP, 66
	sets.engaged.Caladbolg.Acc = set_combine(sets.engaged.Acc, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		ring1="Flamma Ring",
		legs="Odyssean Cuisses"
	})
	-- sets.engaged.Acc.DT: 30 STP, 30
	sets.engaged.Caladbolg.Acc.DT = set_combine(sets.engaged.Acc.DT, {
	})
	-- sets.engaged.SubtleBlow: 39 STP, 39
	sets.engaged.Caladbolg.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {
	})
	sets.engaged.Caladbolg.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Caladbolg.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Caladbolg.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	
	-- 3-hit: 159
	-- 4-hit: 90 
	-- 5-hit: 49
	-- 6-hit: 22
	sets.engaged.SAM.Caladbolg = set_combine(sets.engaged, {
		neck="Abyssal Beads +1",
		body="Valorous Mail"
	})
	sets.engaged.SAM.Caladbolg.DT = set_combine(sets.engaged.Caladbolg.DT, {
		--ear2="Dedition Earring", -- 8
		--ring1="Flamma Ring" -- 5
	})
	sets.engaged.SAM.Caladbolg.Acc = set_combine(sets.engaged.Caladbolg.Acc, {})
	sets.engaged.SAM.Caladbolg.Acc.DT = set_combine(sets.engaged.Caladbolg.Acc.DT, {})
	sets.engaged.SAM.Caladbolg.SubtleBlow = set_combine(sets.engaged.Caladbolg.SubtleBlow, {})
	sets.engaged.SAM.Caladbolg.SubtleBlow.NoAuspice = set_combine(sets.engaged.Caladbolg.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Caladbolg.SubtleBlow.DT = set_combine(sets.engaged.Caladbolg.SubtleBlow.DT, {})
	sets.engaged.SAM.Caladbolg.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Caladbolg.SubtleBlow.DT.NoAuspice, {})
	
end

function define_apoc_sets()    
	-- 3-hit: 135
	-- 4-hit: 77
	-- 5-hit: 41
	-- 6-hit: 18
	sets.engaged.Apocalypse = set_combine(sets.engaged, {
		neck="Abyssal Beads +1",
		ear2="Schere Earring"
	})
	sets.engaged.Apocalypse.DT = set_combine(sets.engaged.DT, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring"
	})
	sets.engaged.Apocalypse.Acc = set_combine(sets.engaged.Acc, {
		ring2="Chirich Ring +1",
		ear2="Schere Earring"
	})
	sets.engaged.Apocalypse.Acc.DT = set_combine(sets.engaged.Acc.DT, {
		ear2="Crepuscular Earring",
		ring1="Chirich Ring +1"
	})
	sets.engaged.Apocalypse.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {
		ear2="Crepuscular Earring"
	})
	sets.engaged.Apocalypse.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {
		legs="Odyssean Cuisses",
		ear2="Schere Earring"

	})
	sets.engaged.Apocalypse.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Apocalypse.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
		
	-- 3-hit: 120
	-- 4-hit: 62
	-- 5-hit: 26
	-- 6-hit: 3
	sets.engaged.SAM.Apocalypse = set_combine(sets.engaged.Apocalypse, {
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		legs="Odyssean Cuisses"
	})
	sets.engaged.SAM.Apocalypse.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.SAM.Apocalypse.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.SAM.Apocalypse.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.SAM.Apocalypse.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.SAM.Apocalypse.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Apocalypse.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.SAM.Apocalypse.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
end

function define_loxotic_sets()
	-- 4-hit: 156
	-- 5-hit: 105
	-- 6-hit: 71
	-- 7-hit: 46
	-- 8-hit: 28
	-- 9-hit: 14
	-- 10-hit: 3
	sets.engaged.Loxotic = set_combine(sets.engaged, {})
	sets.engaged.Loxotic.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Loxotic.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.Loxotic.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Loxotic.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Loxotic.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Loxotic.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Loxotic.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	-- 4-hit: 141
	-- 5-hit: 90
	-- 6-hit: 56
	-- 7-hit: 31
	-- 8-hit: 13
	sets.engaged.SAM.Loxotic = set_combine(sets.engaged.Loxotic, {})
	sets.engaged.SAM.Loxotic.DT = set_combine(sets.engaged.Loxotic.DT, {})
	sets.engaged.SAM.Loxotic.Acc = set_combine(sets.engaged.Loxotic.Acc, {})
	sets.engaged.SAM.Loxotic.Acc.DT = set_combine(sets.engaged.Loxotic.Acc.DT, {})
	sets.engaged.SAM.Loxotic.SubtleBlow = set_combine(sets.engaged.Loxotic.SubtleBlow, {})
	sets.engaged.SAM.Loxotic.SubtleBlow.NoAuspice = set_combine(sets.engaged.Loxotic.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Loxotic.SubtleBlow.DT = set_combine(sets.engaged.Loxotic.SubtleBlow.DT, {})
	sets.engaged.SAM.Loxotic.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Loxotic.SubtleBlow.DT.NoAuspice, {})
end

function define_lycurgos_sets()
	-- 3-hit: 221
	-- 4-hit: 141
	-- 5-hit: 93
	-- 6-hit: 61
	sets.engaged.Lycurgos = set_combine(sets.engaged, {})
	sets.engaged.Lycurgos.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Lycurgos.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.Lycurgos.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Lycurgos.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Lycurgos.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Lycurgos.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Lycurgos.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	-- 3-hit: 206
	-- 4-hit: 126
	-- 5-hit: 78
	-- 6-hit: 46
	sets.engaged.SAM.Lycurgos = set_combine(sets.engaged.Lycurgos, {})
	sets.engaged.SAM.Lycurgos.DT = set_combine(sets.engaged.Lycurgos.DT, {})
	sets.engaged.SAM.Lycurgos.Acc = set_combine(sets.engaged.Lycurgos.Acc, {})
	sets.engaged.SAM.Lycurgos.Acc.DT = set_combine(sets.engaged.Lycurgos.Acc.DT, {})
	sets.engaged.SAM.Lycurgos.SubtleBlow = set_combine(sets.engaged.Lycurgos.SubtleBlow, {})
	sets.engaged.SAM.Lycurgos.SubtleBlow.NoAuspice = set_combine(sets.engaged.Lycurgos.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Lycurgos.SubtleBlow.DT = set_combine(sets.engaged.Lycurgos.SubtleBlow.DT, {})
	sets.engaged.SAM.Lycurgos.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Lycurgos.SubtleBlow.DT.NoAuspice, {})
end

function define_naegling_sets()
	-- 5-hit: 167
	-- 6-hit: 123
	-- 7-hit: 91
	-- 8-hit: 67
	-- 9-hit: 49
	-- 10-hit: 34
	-- 11-hit: 22
	-- 12-hit: 12
	sets.engaged.Naegling = set_combine(sets.engaged, { 
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		ring2="Flamma Ring",
		legs="Odyssean Cuisses"
	})
	sets.engaged.Naegling.DT = set_combine(sets.engaged.DT, {
		neck="Abyssal Beads +1"
	})
	sets.engaged.Naegling.Acc = set_combine(sets.engaged.Acc, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		ring2="Flamma Ring",
		legs="Odyssean Cuisses"
	})
	sets.engaged.Naegling.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Naegling.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Naegling.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Naegling.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Naegling.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	-- 5-hit: 152
	-- 6-hit: 108
	-- 7-hit: 76
	-- 8-hit: 52
	-- 9-hit: 34
	-- 10-hit: 19
	-- 11-hit: 7
	sets.engaged.SAM.Naegling = set_combine(sets.engaged, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		ring2="Flamma Ring",
	})
	sets.engaged.SAM.Naegling.DT = set_combine(sets.engaged.Naegling.DT, {})
	sets.engaged.SAM.Naegling.Acc = set_combine(sets.engaged.Acc, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		ring2="Flamma Ring"
	})
	sets.engaged.SAM.Naegling.Acc.DT = set_combine(sets.engaged.Naegling.Acc.DT, {})
	sets.engaged.SAM.Naegling.SubtleBlow = set_combine(sets.engaged.Naegling.SubtleBlow, {})
	sets.engaged.SAM.Naegling.SubtleBlow.NoAuspice = set_combine(sets.engaged.Naegling.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Naegling.SubtleBlow.DT = set_combine(sets.engaged.Naegling.SubtleBlow.DT, {})
	sets.engaged.SAM.Naegling.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Naegling.SubtleBlow.DT.NoAuspice, {})
end

function define_ragnarok_sets()
	-- 3-hit: 174
	-- 4-hit: 105
	-- 5-hit: 64
	-- 6-hit: 37
	sets.engaged.Ragnarok = set_combine(sets.engaged.Caladbolg, {})
	sets.engaged.Ragnarok.DT = set_combine(sets.engaged.Caladbolg.DT, {})
	sets.engaged.Ragnarok.Acc = set_combine(sets.engaged.Caladbolg.Acc, {})
	sets.engaged.Ragnarok.Acc.DT = set_combine(sets.engaged.Caladbolg.Acc.DT, {})
	sets.engaged.Ragnarok.SubtleBlow = set_combine(sets.engaged.Caladbolg.SubtleBlow, {})
	sets.engaged.Ragnarok.SubtleBlow.NoAuspice = set_combine(sets.engaged.Caladbolg.SubtleBlow.NoAuspice, {})
	sets.engaged.Ragnarok.SubtleBlow.DT = set_combine(sets.engaged.Caladbolg.SubtleBlow.DT, {})
	sets.engaged.Ragnarok.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Caladbolg.SubtleBlow.DT.NoAuspice, {})
	
	-- 3-hit: 159
	-- 4-hit: 90
	-- 5-hit: 49
	-- 6-hit: 22
	sets.engaged.SAM.Ragnarok = set_combine(sets.engaged.SAM.Caladbolg, {})
	sets.engaged.SAM.Ragnarok.DT = set_combine(sets.engaged.SAM.Caladbolg.DT, {})
	sets.engaged.SAM.Ragnarok.Acc = set_combine(sets.engaged.SAM.Caladbolg.Acc, {})
	sets.engaged.SAM.Ragnarok.Acc.DT = set_combine(sets.engaged.SAM.Caladbolg.Acc.DT, {})
	sets.engaged.SAM.Ragnarok.SubtleBlow = set_combine(sets.engaged.SAM.Caladbolg.SubtleBlow, {})
	sets.engaged.SAM.Ragnarok.SubtleBlow.NoAuspice = set_combine(sets.engaged.SAM.Caladbolg.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Ragnarok.SubtleBlow.DT = set_combine(sets.engaged.SAM.Caladbolg.SubtleBlow.DT, {})
	sets.engaged.SAM.Ragnarok.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SAM.Caladbolg.SubtleBlow.DT.NoAuspice, {})
end

function define_redemption_sets()
	-- 3-hit: 140
	-- 4-hit: 80 
	-- 5-hit: 44
	-- 6-hit: 20
	sets.engaged.Redemption = set_combine(sets.engaged, {})
	sets.engaged.Redemption.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Redemption.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.Redemption.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Redemption.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Redemption.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Redemption.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Redemption.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	-- 3-hit: 125
	-- 4-hit: 65 
	-- 5-hit: 20
	-- 6-hit: 5
	sets.engaged.SAM.Redemption = set_combine(sets.engaged.Redemption, {})
	sets.engaged.SAM.Redemption.DT = set_combine(sets.engaged.Redemption.DT, {})
	sets.engaged.SAM.Redemption.Acc = set_combine(sets.engaged.Redemption.Acc, {})
	sets.engaged.SAM.Redemption.Acc.DT = set_combine(sets.engaged.Redemption.Acc.DT, {})
	sets.engaged.SAM.Redemption.SubtleBlow = set_combine(sets.engaged.Redemption.SubtleBlow, {})
	sets.engaged.SAM.Redemption.SubtleBlow.NoAuspice = set_combine(sets.engaged.Redemption.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Redemption.SubtleBlow.DT = set_combine(sets.engaged.Redemption.SubtleBlow.DT, {})
	sets.engaged.SAM.Redemption.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Redemption.SubtleBlow.DT.NoAuspice, {})
end

function define_anguta_sets()
	-- 3-hit: 119
	-- 4-hit: 62
	-- 5-hit: 27
	-- 6-hit: 5
	sets.engaged.Anguta = set_combine(sets.engaged, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		ring2="Flamma Ring",
		legs="Odyssean Cuisses"
	})
	sets.engaged.Anguta.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Anguta.Acc = set_combine(sets.engaged.Acc, {
		neck="Abyssal Beads +1",
		ear2="Crepuscular Earring",
		body="Valorous Mail",
		ring1="Flamma Ring",
		legs="Odyssean Cuisses"
	})
	sets.engaged.Anguta.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Anguta.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
	sets.engaged.Anguta.SubtleBlow.NoAuspice = set_combine(sets.engaged.SubtleBlow.NoAuspice, {})
	sets.engaged.Anguta.SubtleBlow.DT = set_combine(sets.engaged.SubtleBlow.DT, {})
	sets.engaged.Anguta.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.SubtleBlow.DT.NoAuspice, {})
	
	-- 3-hit: 104
	-- 4-hit: 47
	-- 5-hit: 12
	-- 6-hit: default
	sets.engaged.SAM.Anguta = set_combine(sets.engaged, {
		ear2="Schere Earring",
		neck="Abyssal Beads +1",
		ring2="Flamma Ring",
	})
	sets.engaged.SAM.Anguta.DT = set_combine(sets.engaged.Anguta.DT, {})
	sets.engaged.SAM.Anguta.Acc = set_combine(sets.engaged.Acc, {
		ear2="Schere Earring",
		neck="Abyssal Beads +1",
		body="Valorous Mail",
	})
	sets.engaged.SAM.Anguta.Acc.DT = set_combine(sets.engaged.Anguta.Acc.DT, {})
	sets.engaged.SAM.Anguta.SubtleBlow = set_combine(sets.engaged.Anguta.SubtleBlow, {})
	sets.engaged.SAM.Anguta.SubtleBlow.NoAuspice = set_combine(sets.engaged.Anguta.SubtleBlow.NoAuspice, {})
	sets.engaged.SAM.Anguta.SubtleBlow.DT = set_combine(sets.engaged.Anguta.SubtleBlow.DT, {})
	sets.engaged.SAM.Anguta.SubtleBlow.DT.NoAuspice = set_combine(sets.engaged.Anguta.SubtleBlow.DT.NoAuspice, {})
end

--------------------------------------
-- Weapon Skills
--------------------------------------
function define_ws_sets()
	-- Equipped for all WS in DebuffWSList
	sets.precast.DebuffWS = {
		ammo="Seething Bomblet +1",
		head="Sakpata's Helm",
		neck="Abyssal Beads +1",
		ear1="Crepuscular Earring",
		ear2="Dignitary's Earring",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring2="Metamorph Ring +1",
		ring1="Karieyh Ring +1",
		back=ankouTP,
		waist="Kentarch Belt +1",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	}

	--------------------------------------
	-- One/Two-Hit WS Sets
	--------------------------------------
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		neck="Abyssal Beads +1",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Niqmaddu Ring",
		back=ankouSTRWS,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ring2="Beithir Ring"
	})
	
	-- 2-hit, 50% STR / MND, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- 2-hit, 60% STR / MND, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- 1-hit, 50% STR / MND, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Judgment'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	--- 1-hit, 60% STR / MND, No ATK Mod, No fTP carry, Ignore Def varies with TP
	sets.precast.WS['Quietus'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Quietus'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- 1-hit, 50% STR / INT, 1.75 ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- 1-hit, 50% STR / INT, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS.Acc, {})
	
	-- 1-hit, 40% STR / INT, No ATK Mod, No fTP carry, No vary with TP
	sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {
		ear2="Schere Earring",
	})
	sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {
		ear2="Schere Earring",	
	})
	
	-- 1-hit, 100% STR, 2.0 ATK Mod, No fTP carry, Acc varies with TP, 100% Crit Rate
	sets.precast.WS['True Strike'] = set_combine(sets.precast.WS, {
		ear2="Schere Earring",
	})
	sets.precast.WS['True Strike'].Acc = set_combine(sets.precast.WS.Acc, {
		ear2="Schere Earring",	
	})
	
	-- 1-hit, 40% STR / VIT, No ATK Mod, No fTP carry, No vary with TP
	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {
		ear2="Schere Earring",	
	})
	sets.precast.WS['Scourge'].Acc = set_combine(sets.precast.WS.Acc, {
		ear2="Schere Earring",	
	})
	
	-- 1-hit, 80% VIT, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		back=ankouVITWS,
		waist="Fotia Belt"
	})
	sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS.Acc, {
		back=ankouVITWS,
		waist="Fotia Belt"
	})
	
	--------------------------------------
	-- Multi-Hit WS Sets
	--------------------------------------
	-- 4-hit, 85% INT, No ATK Mod, fTP carry, DMG varies with TP
	sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		ear1="",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Metamorph Ring +1",
		legs="Sakpata's Cuisses",
		back=ankouINTDA,
		waist="Fotia Belt"
	})
	sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {})
	
	-- 5-hit, 85% STR, 0.85 ATK Mod, fTP carry, DMG varies with TP
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		head="Sakpata's Helm",
		ear1="Schere Earring",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Regal Ring",
		back=ankouSTRDA,
		waist="Fotia Belt",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings"
	})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})
	
	-- 5-hit, 85% MND, No ATK Mod, fTP carry, DMG varies with TP
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Resolution'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	
	-- 4-hit, 20% STR / INT, No ATK Mod, No fTP carry, DMG varies with TP
	sets.precast.WS['Insurgency'] = set_combine(sets.precast.WS, {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Regal Ring",
		back=ankouSTRDA,
		waist="Fotia Belt",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
	})
	sets.precast.WS['Insurgency'].Acc = set_combine(sets.precast.WS['Insurgency'], {})
	
	--------------------------------------
	-- Magic WS Sets
	--------------------------------------
	sets.precast.MagicWS = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		--body="Fallen's Cuirass +3",
		--hands="Fallen's Finger Gauntlets +3",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Fenrir Ring +1",
		back=ankouSTRWS,
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}

	sets.precast.WS['Infernal Scythe'] = set_combine(sets.precast.MagicWS, {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"
	})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.MagicWS, {})
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.MagicWS, {})
	
end

--------------------------------------
-- Defensive/Idle Sets
--------------------------------------
function define_idle_dt_sets()
	sets.defense.PDT = {
		ammo="Staunch Tathlum +1", -- 3%
		head="Sakpata's Helm", -- 7%
		neck="Warder's Charm +1",
		ear1="Sanare Earring", 
		ear2="Hearty Earring",
		body="Sakpata's Breastplate", -- 10%
		hands="Sakpata's Gauntlets", -- 8%
		ring2="Moonlight Ring", -- 5%
		ring1="Shadow Ring",
		back=ankouTP, -- 5% 
		waist="Carrier's Sash",
		legs="Sakpata's Cuisses", -- 9%
		feet="Sakpata's Leggings" -- 6%
	}
	sets.defense.MDT = sets.defense.PDT
	
	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		--head="Crepuscular Helm",
		head="Twilight Helm",
		--body="Crepuscular Mail",
		body="Twilight Mail"
	})
   
	sets.idle = set_combine(sets.defense.PDT, {
		-- from base: 36%
		--head="Ratri Sallet +1",
		head="Valorous Mask",
		neck="Loricate Torque +1", -- 6%
		ear1="Odnowa Earring +1", -- 3%
		ear2="Genmei Earring", -- 2% PDT
		ring2="Sheltered Ring",
		ring1="Karieyh Ring +1",
		--back="Moonlight Cape", -- 6%
		back=ankouTP,
		waist="Flume Belt" -- 4% PDT
	})
	
	sets.idle.Regen = set_combine(sets.idle, {
		--head="Volte Salade",
		neck="Coatl Gorget +1",
		ear2="Infused Earring",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		ring2="Sheltered Ring",
		ring1="Defending Ring",
		legs="Volte Brayettes",
		--feet="Volte Sollerets"
	})
	
	sets.idle.Refresh = set_combine(sets.idle, {
		head="",
		body="Lugra Cloak +1",
		ring1="Stikini Ring +1",
		neck="Coatl Gorget +1",
	})
   
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.Weather = {waist="Hachirin-no-Obi"}
end

--------------------------------------
-- Special Logic
--------------------------------------		
function job_post_precast(spell, action, spellMap, eventArgs)
	if debuffWSList:contains(spell.name) then
		equip(sets.precast.DebuffWS)
	end
end

function job_midcast(spell, action, spellMap, eventArgs)
	if (spell.english == 'Dread Spikes') then
		if (player.max_hp == 9999) then
			equip(sets.MaxHPDread)
			eventArgs.handled = true
		end
	end
end
		
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		if spell.skill == 'Dark Magic' then
			if state.LoseTP.value then
				storedMain = player.equipment.main
				storedSub = player.equipment.sub
				if spellMap == 'Drain' then
					equip(sets.midcast.Drain.LoseTP)
				elseif spellMap == 'Aspir' then
					equip(sets.midcast.Aspir.LoseTP)
				elseif spell.english == 'Dread Spikes' then
					equip(sets.midcast['Dread Spikes'].LoseTP)
				end
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

function job_post_aftercast(spell, action, spellMap, eventArgs)
	if state.LoseTP.value then
		equip({main=storedMain, sub=storedSub})
		storedMain=""
		storedSub=""
	end
end

function job_update(cmdParams, eventArgs)
    update_subjob_mode()
	update_combat_weapon()
end

function job_buff_change(buff, gain)
	if (buff == 'Auspice') then 
		if gain then
			classes.CustomMeleeGroups:clear()
		else
			classes.CustomMeleeGroups:append('NoAuspice')
		end
	end
end

function update_subjob_mode()
    if player.sub_job == 'SAM' and not buffactive['SJ Restriction'] then
		state.CombatForm:set('SAM')
	-- elseif player.sub_job == 'NIN' or player.sub_job == 'DNC' then
		-- state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
    end
end

function update_combat_weapon()  
	if(weaponList:contains(player.equipment.main)) then
		if(state.CombatWeapon.value ~= player.equipment.main) then
			state.CombatWeapon:set(player.equipment.main)
			add_to_chat(002, 'Weapon Mode updated to: '.. state.CombatWeapon.value)
		end
	elseif player.equipment.main == 'Kaja Chopper' then
		if(state.CombatWeapon.value ~= 'Lycurgos') then
			state.CombatWeapon:set('Lycurgos')
			add_to_chat(002, 'Weapon Mode updated to: '.. state.CombatWeapon.value)
		end
	else
		state.CombatWeapon:reset()
		add_to_chat(002, 'Weapon Mode reset')
	end
end