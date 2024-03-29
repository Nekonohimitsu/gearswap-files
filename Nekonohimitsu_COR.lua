-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
	weaponTable = {
		['Melee'] = {main='Naegling', sub="Gleti's Knife", range='Anarchy +2'},
		['PhysRange'] = {main='Kustawi +1', sub='Nusku Shield', range='Fomalhaut'},
		['MagRange'] = {main='Naegling', sub='Tauret', range='Death Penalty'},
		['MeleeShield'] = {main='Naegling', sub="Nusku Shield", range='Anarchy +2'},
		['PhysRangeShield'] = {main='Kustawi +1', sub='Nusku Shield', range='Fomalhaut'},
		['MagRangeShield'] = {main='Naegling', sub='Nusku Shield', range='Death Penalty'}
	}

	currentRoll = ""

	rollMaps = {
		["Corsair's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 9, ['Effect'] = "EXP+"},
		["Ninja's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "EVA+"},
		["Hunter's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "ACC+"},
		["Chaos Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "ATK+"},
		["Magus's Roll"] = {['Lucky'] = 2, ['Unlucky'] = 6, ['Effect'] = "MDB+"},
		["Healer's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "Cure Rec+"},
		["Drachen Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "Pet: ACC+"},
		["Choral Roll"] = {['Lucky'] = 2, ['Unlucky'] = 6, ['Effect'] = "SIRD+"},
		["Monk's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "SB+"},
		["Beast Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "Pet: ATK+"},
		["Samurai Roll"] = {['Lucky'] = 2, ['Unlucky'] = 6, ['Effect'] = "STP+"},
		["Evoker's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 9, ['Effect'] = "Refresh+"},
		["Rogue's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 9, ['Effect'] = "Crit+"},
		["Warlock's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "MACC+"},
		["Fighter's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 9, ['Effect'] = "DA+"},
		["Puppet Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "Pet: MACC/MAB+"},
		["Gallant's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "DEF+"},
		["Wizard's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 9, ['Effect'] = "MATK+"},
		["Dancer's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "Regen+"},
		["Scholar's Roll"] = {['Lucky'] = 2, ['Unlucky'] = 6, ['Effect'] = "CMP+"},
		["Naturalist's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 7, ['Effect'] = "Enh Dur+"},
		["Runeist's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "MEVA+"},
		["Bolter's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 9, ['Effect'] = "Movement+"},
		["Caster's Roll"] = {['Lucky'] = 2, ['Unlucky'] = 7, ['Effect'] = "FC+"},
		["Courser's Roll"] = {['Lucky'] = 3, ['Unlucky'] = 9, ['Effect'] = "Snapshot+"},
		["Blitzer's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 9, ['Effect'] = "Delay-"},
		["Tactician's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 8, ['Effect'] = "Regain+"},
		["Allies' Roll"] = {['Lucky'] = 3, ['Unlucky'] = 10, ['Effect'] = "SCDmg+"},
		["Miser's Roll"] = {['Lucky'] = 5, ['Unlucky'] = 7, ['Effect'] = "SaveTP+"},
		["Companion's Roll"] = {['Lucky'] = 2, ['Unlucky'] = 10, ['Effect'] = "Pet:Regen/Regain+"},
		["Avenger's Roll"] = {['Lucky'] = 4, ['Unlucky'] = 8, ['Effect'] = "Counter+"},
	}
	
	
	--Alt-F9 to Cycle
    state.RangedMode:options('Normal', 'Acc', 'PDL')
	--F9 to Cycle
	state.OffenseMode:options('Normal', 'Acc')
	
	state.HybridMode:options('Normal', 'DT')
	
	-- This is a flag to specify if you are using QD for Damage or TP.
	state.QDMode = M{['description'] = 'QDMode', 'Damage', 'TP'}
	
	-- This is a flag to specify if you are using QD to Boost elemental damage.
	-- True means you want to wear Empy Feet, False means to focus on damage.
	-- This will equip on top of your QD set specified above (TP, Damage).
	state.QDDmgBoost = M(true, 'QD Dmg Boost Mode')
	
	--This matches the Offense or Ranged modes according to WS used if it can.
	state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
	
	state.WeaponMode = M{['description'] = 'Weapon Mode'}
	state.WeaponMode:options('Melee', 'PhysRange', 'MagRange')
	
	--Whether you want to attempt a double roll removal with your Fold
	state.DoubleFold = M(false, 'Double Fold')
	
	--Enables Luzaf's Roll to double roll range
	state.LongRangeDoubleUp = M(true, 'Long Range Double-Up')
	
	-- Since we only know Flurry is on, this flag is to tell the LUA
	-- if the Flurry you have on is 1 or 2. Default to Flurry II.
	state.Flurry2 = M(true, 'Flurry II Buff')
	
	-- Informs LUA when to use the PDL gear / sets
	state.PDL = M(true, 'Physical Damage Limit')
end

function init_gear_sets()	
	camuDT = {name="Camulus's Mantle", augments={'Damage Taken-5%'}}
	camuSnapshot = {name="Camulus's Mantle", augments={'"Snapshot"+10'}}
	camuRacc = {name="Camulus's Mantle", augments={'AGI+10', 'AGI+20', 'Rng. Acc.+20 /Rng. Atk.+20', '"Store TP"+10'}}
	camuDa = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	camuMabWsd = {name="Camulus's Mantle", augments={'AGI+20', 'AGI+10', 'Mag. Acc.+20/Mag. Dmg.+20', 'Weapon skill damage +10%'}}
	camuRatkWsd = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%'}}
	camuSavage = {name="Camulus's Mantle", augments={'STR+20', 'STR+10'}}

	mabHercHelm= {name="Herculean Helm", augments={'INT+4'}}
	mabAgiHercHelm = {name="Herculean Helm", augments={"AGI+9"}}
	
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
	sets.DoubleFold = {hands="Lanun Gants +3"}
	sets.LongRangeDoubleUp = {ring1="Luzaf's Ring"}
		
	sets.precast.FC = {}
	
-- Preshot Set--
	sets.precast.RA = {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		ammo="Chrono Bullet"
		,head="Chasseur's Tricorne +3" -- 0% / 16%
		,body="Oshosi Vest" --12% / 0%
		,hands="Carmine Finger Gauntlets +1" --8% / 11%
		,ring1="Crepuscular Ring" -- 3%
		,back=camuSnapshot -- 10% / 0%
		,waist="Impulse Belt" -- 3% / 0%
		,legs="Adhemar Kecks +1" -- 10% / 13%
		,feet="Meghanada Jambeaux +2" -- 10% / 0%
		,neck="Commodore Charm +2", -- 4% / 0%
		--Result: 70% Snapshot, 75% Rapid Shot
	}
	
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		--Flurry 1: 15%
		body="Laksamana's Frac +3", -- 0% / 20%
		waist="Yemaya Belt" -- 0% / 5%
		--Result: 73% Snapshot, 95% Rapid Shot
	})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		--Flurry 2: 30%
		ring1="Defending Ring", -- 0% / 0%
		legs="Pursuer's Pants" -- 0% / 19%
		--Result: 74% Snapshot, 101% Rapid Shot
	})
					
	sets.precast.CorsairRoll = {
		main="Rostam",
		range="Compensator",
		head="Lanun Tricorne +3",
		neck="Regal Necklace",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Chasseur's Frac +3",
		hands="Chasseur's Gants +3",
		ring1="Purity Ring",
		ring2="Defending Ring",
		back=camuDT,
		waist="Flume Belt",
		legs="Desultor Tassets",
		feet="Nyame Sollerets"
	}
	
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
		head="Chasseur's Tricorne +3"
	})
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
		legs="Chasseur's Culottes +3"
	})
	
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
		feet="Chasseur's Bottes +3"
	})
	
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
		body="Chasseur's Frac +3"
	})
	
	sets.precast.CorsairRoll["Allies Roll"] = set_combine(sets.precast.CorsairRoll, {
		hands="Chasseur's Gants +3"
	})
		
	sets.precast.CorsairShot = {
		ammo="Hauksbok Bullet",
		head=mabHercHelm,
		neck="Baetyl Pendant",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Lanun Frac +3",
		hands="Carmine Finger Gauntlets +1",
		ring1="Dingir Ring",
		ring2="Fenrir Ring +1",
		back=camuMabWsd,
		waist="Eschan Stone",
		--waist="Skrymir Cord +1",
		legs="Herculean Trousers",
		feet="Chasseur's Bottes +3"
	}
	
	sets.precast.CorsairShot.TP = set_combine(sets.precast.CorsairShot, {
		head="Ikenga's Hat",
		neck="Vim Torque +1",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
		--ear2="Dedition Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Chirich Ring +1",
		ring2="Crepuscular ring",
		back=camuRacc,
		waist="Tellen Belt",
		legs="Chasseur's Culottes +3",
		feet="Malignance Boots"
	})
	
	sets.QDDmg = {head="Laksamana's Tricorne +3", feet="Chasseur's Bottes +3", body="Mirke Wardecors"}
	
	sets.precast.CorsairShot['Light Shot'] = {
		ammo="Animikii Bullet",
		head="Laksa. Tricorne +3",
		neck="Commodore Charm +2",
		ear1="Crepuscular Earring",
		ear2="Dignitary's Earring",
		--ear2="Chasseur's Earring +2",
		body="Chasseur's Frac +3",
		hands="Laksamana's Gants +3",
		ring1="Metamorph Ring +1",
		ring2="Regal Ring",
		back=camuMabWsd,
		waist="K. Kachina Belt +1",
		legs="Chasseur's Culottes +3",
		feet="Laksamana's Bottes +3"
	}
	sets.precast.CorsairShot['Dark Shot'] = sets.precast.CorsairShot['Light Shot']
	
	-- Shooting Base Set --
	sets.midcast.RA = {
		ammo="Chrono Bullet"
		,head="Ikenga's Hat"
		,ear1="Telos Earring"
		,ear2="Enervating Earring"
		,neck="Iskur Gorget"
		,body="Ikenga's Vest"
		,hands="Malignance Gloves"
		,ring1="Ilabrat Ring"
		,ring2="Dingir Ring"
		,back=camuRacc
		,waist="Tellen Belt"
		,legs="Chasseur's Culottes +3"
		,feet="Malignance Boots"
	}
					
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		waist="Kwahu Kachina Belt +1"
		,ear2="Beyla Earring"
	})
	
	sets.midcast.RA.PDL = set_combine(sets.midcast.RA, {
	})

-- Triple Shot Set --
   sets.TripleShot = set_combine(sets.midcast.RA, {
			head="Oshosi Mask +1",
			body="Chasseur's Frac +3",
			hands="Lanun Gants +3",
			legs="Oshosi Trousers +1",
			feet="Oshosi Leggings +1"
   })
   
   sets.precast.WS = {
	ammo="Chrono Bullet",
	head="Lanun Tricorne +3",
	neck="Fotia Gorget",
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	body="Laksamana's Frac +3",
	hands="Nyame Gauntlets",
	ring1="Dingir Ring",
	ring2="Regal Ring",
	back=camuRatkWsd,
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Lanun Bottes +3"
	}
   
   sets.precast.WS['Wildfire'] = {
	ammo="Living Bullet",
	head="Nyame Helm",
	neck="Commodore Charm +2",
	ear1="Crematio Earring",
	ear2="Friomisi Earring",
	body="Lanun Frac +3",
	hands="Nyame Gauntlets",
	ring1="Ilabrat Ring",
	ring2="Dingir ring",
	--ring1="Epaminondas's Ring",
	back=camuMabWsd,
	waist="Eschan Stone",
	--waist="Skrymir Cord +1",
	legs="Nyame Flanchard",
	feet="Lanun Bottes +3"
   }
   
   sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
	head="Pixie Hairpin +1",
	ring1="Archon Ring",
	ear1="Moonshade Earring",
	waist="Svelt. Gouriz +1"
   })
   
   sets.precast.WS['Last Stand'] = {
	ammo="Chrono Bullet",
	head="Lanun Tricorne +3",
	neck="Fotia Gorget",
	ear2="Ishvara Earring",
	ear1="Moonshade Earring",
	--ear2="Chasseur's Earring +2",
	body="Ikenga's Vest",
	hands="Chasseur's Gants +3",
	ring1="Dingir Ring",
	--ring1="Epaminondas's Ring",
	ring2="Regal Ring",
	back=camuRatkWsd,
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Lanun Bottes +3"
   }
   
   sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
   })
   
   sets.precast.WS['Last Stand'].PDL = set_combine(sets.precast.WS['Last Stand'], {
   })
   
   sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
   sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
   
   sets.precast.WS['Savage Blade'] = {
	head="Nyame Helm",
	neck="Commodore Charm +2",
	ear2="Ishvara Earring",
	--ear2="Commodore Earring +2",
	ear1="Moonshade Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	ring1="Cornelia's Ring",
	ring2="Sroda Ring",
	back=camuSavage,
	waist="Sailfi Belt +1",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
   }
   
   sets.precast.WS['Hot Shot'] = {
	 ammo="Chrono Bullet",
	 head="Nyame Helm",
	 neck="Fotia Gorget",
	 ear1="Moonshade Earring",
	 ear2="Friomisi Earring",
	 body="Nyame Mail",
	 hands="Nyame Gauntlets",
	 ring1="Cornelia's Ring",
	 ring2="Dingir Ring",
	 back=camuRatkWsd,
	 waist="Fotia Belt",
	 legs="Nyame Flanchard",
	 feet="Lanun Bottes +3"
   }
   
   sets.precast.WS['Requiescat'] = {
	head="Adhemar Bonnet +1",
	neck="Fotia Gorget",
	ear1="Telos Earring",
	ear2="Moonshade Earring",
	body="Adhemar Jacket +1",
	hands="Nyame Gauntlets",
	ring1="Rufescent Ring",
	ring2="Regal Ring",
	back=camuDa,
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
   }
   
   sets.engaged = {
	head="Malignance Chapeau",
	neck="Clotharius Torque",
	ear1="Telos Earring",
	ear2="Suppanomimi",
	body="Adhemar Jacket +1",
	hands="Adhemar Wristbands +1",
	ring1="Chirich Ring +1",
	ring2="Epona's Ring",
	back=camuDa,
	waist="Windbuffet Belt +1",
	legs="Samnuha Tights",
	feet="Herculean Boots"
   }
   
   sets.engaged.Acc = set_combine(sets.engaged, {
		body="Malignance Tabard",
   })
   
   sets.engaged.DT = set_combine(sets.engaged, {
		-- BASE: 10%
		body="Malignance Tabard", -- 9%
		hands="Malignance Gloves", -- 5%
		ring1="Defending Ring", -- 10%
		waist="Flume Belt", -- P4%
		legs="Nyame Flanchard", -- 7%
		--legs="Malignance Tights", -- 7%
		feet="Malignance Boots" -- 4%
		--------------------------------
		-- DT-46%, PDT-4(50)%
   })
   
   sets.defense.PDT = {
		head="Malignance Chapeau"
		,neck="Warder's Charm +1"
		,ear1="Hearty Earring"
		,ear2="Sanare Earring"
		,body="Malignance Tabard"
		,hands="Malignance Gloves"
		,ring1="Purity Ring"
		,ring2="Defending Ring"
		,back=camuDT
		,waist="Flume Belt"
		,legs="Nyame Flanchard" --,legs="Malignance Tights"
		,feet="Malignance Boots"
   }
   sets.defense.MDT = sets.defense.PDT
   
   sets.idle = set_combine(sets.defense.PDT, {
			neck="Loricate Torque +1",
			ear1="Odnowa Earring +1",
			ear2="Etiolation Earring",
			body="Mekosuchinae harness",
			ring1="Sheltered Ring",
			ring2="Karieyh Ring +1",
   })
   
   sets.idle.refresh = set_combine(sets.idle, { 
			ring2="Stikini Ring +1"
   })
   
   sets.Kiting = {legs="Carmine Cuisses +1"}
   sets.Weather = {waist="Hachirin-no-Obi"}
			   				              
end

function job_post_precast(spell, action, spellMap, eventArgs)
		if (spell.english == 'Double-Up' or spell.type == 'CorsairRoll') then
		rangeText = "8 yalms"
		if spell.type == 'CorsairRoll' then 
			currentRoll = spell.english
		end
		if state.LongRangeDoubleUp.value == true then
			equip(sets.LongRangeDoubleUp)
			rangeText = "16 yalms"
		end
		if (currentRoll ~= "") then
			add_to_chat(060, "Lucky: " .. rollMaps[currentRoll].Lucky .. ", Unlucky: " .. rollMaps[currentRoll].Unlucky .. " (" .. rollMaps[currentRoll].Effect .. ", " .. rangeText .. ")")
		end
	elseif spell.english == 'Fold' and state.DoubleFold.value == true then
		equip(sets.DoubleFold)
	elseif spell.english == 'Ranged' and buffactive['Flurry'] then
		if (state.Flurry2.value == true) then
			equip(sets.precast.RA.Flurry2)
		else
			equip(sets.precast.RA.Flurry)
		end
	end
	if spell.type == 'CorsairShot' and spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot' and state.QDMode.value == 'TP' then
		equip(sets.precast.CorsairShot.TP)
	end
	
	if (spell.element == world.day_element or spell.element == world.weather_element) then
		equip(sets.Weather)
	end
	if spell.type == 'CorsairShot' and state.QDDmgBoost.value == true then
		equip(sets.QDDmg)
	end
end
				
function job_post_midcast(spell, action, spellMap, eventArgs)
	if buffactive['Triple Shot'] and spell.english == 'Ranged' then
		equip(sets.TripleShot)
	end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- Change weapons back to normal after roll
	if spell.type == 'CorsairRoll' then
		update_weapons()
	end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Weapon Mode' then
		update_weapons()
	end
end

function update_weapons()
	if(weaponTable[state.WeaponMode.value]) then
		if (can_dual_wield()) then
			equip(weaponTable[state.WeaponMode.value])
		else
			equip(weaponTable[state.WeaponMode.value.."Shield"])
		end
	end
end

function can_dual_wield()
    if (player.sub_job == 'NIN' or player.sub_job == 'DNC') and not buffactive['SJ Restriction'] then
		return true
    end
	return false
end

function customize_idle_set(idleSet)
    if player.mpp < 51 and (player.sub_job == "RDM" or player.sub_job == "DRK" or player.sub_job == "WHM" or player.sub_job == "SCH") then
        idleSet = set_combine(idleSet, sets.idle.refresh)
    end
    return idleSet
end

function job_buff_change(buff, gain)
	if (buff == 'Double-Up Chance' and not gain) then
		currentRoll = ""
	end
end