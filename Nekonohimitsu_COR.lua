-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()

	--Alt-F9 to Cycle
    state.RangedMode:options('Normal', 'Acc')
	--F9 to Cycle
	state.OffenseMode:options('Normal', 'Acc')
	
	--This matches the Offense or Ranged modes according to WS used if it can.
	state.WeaponskillMode:options('Normal', 'Acc')
	
	state.WeaponMode = M{['description'] = 'Weapon Mode'}
	state.WeaponMode:options('Melee', 'PhysRange', 'MagRange')
	
	--Whether you want to attempt a double roll removal with your Fold
	state.DoubleFold = M(false, 'Double Fold')
	
	--Enables Luzaf's Roll to double roll range
	state.LongRangeDoubleUp = M(false, 'Long Range Double-Up')
	
	-- This is a flag to specify if you are using QD for Damage or TP.
	-- True means you prefer TP, False means prefer damage. Default is damage.
	state.QDTP = M(false, 'QD TP Mode')
	
	-- This is a flag to specify if you are using QD to Boost elemental damage.
	-- True means you want to wear AF Feet, False means to focus on damage. Default is damage.
	state.QDDmgBoost = M(false, 'QD Dmg Boost Mode')
	
	-- Since we only know Flurry is on, this flag is to tell the LUA
	-- if the Flurry you have on is 1 or 2. Default to Flurry II.
	state.Flurry2 = M(true, 'Flurry II Buff')
end

function init_gear_sets()	
	camuDT = {name="Camulus's Mantle", augments={'Damage Taken-5%'}}
	camuSnapshot = {name="Camulus's Mantle", augments={'"Snapshot"+10'}}
	camuRacc = {name="Camulus's Mantle", augments={'AGI+10', 'AGI+20', 'Rng. Acc.+20 /Rng. Atk.+20', '"Store TP"+10'}}
	camuDa = {name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	camuMabWsd = {name="Camulus's Mantle", augments={'AGI+20', 'Mag. Acc.+10', 'Mag. Acc.+20/Mag. Dmg.+20', 'Weapon skill damage +10%'}}
	camuRatkWsd = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%'}}
	
	weaponTable = {
		['Melee'] = {main='Naegling', sub='Blurred Knife +1', range='Anarchy +2'},
		['PhysRange'] = {main='Kustawi +1', sub='Nusku Shield', range='Fomalhaut'},
		['MagRange'] = {main='Naegling', sub='Tauret', range='Death Penalty'},
		['DefaultShield'] = {sub='Nusku Shield'}
	}
	
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
	sets.DoubleFold = {hands="Lanun Gants +3"}
	sets.LongRangeDoubleUp = {ring1="Luzaf's Ring"}
		
	sets.precast.FC = {
		head="Carmine Mask",
		neck="Orunmila's Torque",
		ear1="Loquac. Earring",
		ear2="Enchntr. Earring +1",
		body="Dread Jupon",
		hands="Leyline Gloves",
		ring1="Kishar ring",
		ring2="Prolix Ring",
		feet="Carmine Greaves"
	}
	
-- Preshot Set--
	sets.precast.RA = {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		ammo="Chrono Bullet"
		,head="Taeon Chapeau" -- 10% / 0%
		,body="Pursuer's Doublet" --6% / 0%
		,hands="Carmine Finger Gauntlets +1" --8% / 11%
		,back=camuSnapshot -- 10% / 0%
		,waist="Impulse Belt" --3% / 0%
		,legs="Adhemar Kecks +1" -- 10% / 0%
		,feet="Meghanada Jambeaux +2" -- 10% / 0%
		,neck="Commodore Charm +1" -- 3% / 0%
		--Result: 70% Snapshot, 41% Rapid Shot
	}
	
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		--Flurry 1: 15%
		body="Laksamana's Frac +3", -- 0% / 20%
		waist="Yemaya Belt" -- 0% / 5%
		--Result: 76% Snapshot, 66% Rapid Shot
	})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, {
		--Cap: 70% Snapshot, 99% Rapid Shot
		--Gifts: 10% / 30%
		--Flurry 2: 30%
		head="Chasseur's Tricorne +1", -- 0% / 14%
		legs="Pursuer's Pants" -- 0% / 19%
		--Result: 71% Snapshot, 99% Rapid Shot
	})
					
	sets.precast.CorsairRoll = {
		main="Rostam",
		range="Compensator",
		head="Lanun Tricorne +3",
		neck="Regal Necklace",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Chasseur's Gants +1",
		ring1="Gelatinous Ring +1",
		ring2="Defending Ring",
		back=camuDT,
		waist="Flume Belt",
		legs="Desultor Tassets",
		feet="Lanun Bottes +3"
	}
	
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
		head="Chasseur's Tricorne +1"
	})
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
		legs="Chasseur's Culottes +1"
	})
	
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
		feet="Chasseur's Bottes +1"
	})
	
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
		body="Chasseur's Frac +1"
	})
	
	sets.precast.CorsairRoll["Allies Roll"] = set_combine(sets.precast.CorsairRoll, {
		hands="Chasseur's Gants +1"
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
		legs="Herculean Trousers",
		feet="Lanun Bottes +3"
	}
	
	sets.precast.CorsairShot.TP = set_combine(sets.precast.CorsairShot, {
		head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Crepuscular Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Ilabrat Ring",
		ring2="Crepuscular ring",
		back=camuRacc,
		waist="Goading Belt",
		legs="Chasseur's Culottes +1",
		feet="Malignance Boots"
	})
	
	sets.QDDmg = {head="Laksamana's Tricorne +3", feet="Chasseur's Bottes +1", body="Mirke Wardecors"}
	
	sets.precast.CorsairShot['Light Shot'] = {
		ammo="Animikii Bullet",
		head="Laksa. Tricorne +3",
		neck="Commodore Charm +1",
		ear1="Crepuscular Earring",
		ear2="Dignitary's Earring",
		body="Mummu Jacket +2",
		hands="Laksamana's Gants +3",
		ring1="Metamorph Ring +1",
		ring2="Regal Ring",
		back=camuMabWsd,
		waist="K. Kachina Belt +1",
		legs="Mummu Kecks +2",
		feet="Laksamana's Bottes +3"
	}
	sets.precast.CorsairShot['Dark Shot'] = sets.precast.CorsairShot['Light Shot']
-- Shooting Base Set --
	sets.midcast.RA = {
		ammo="Chrono Bullet"
		,head="Malignance Chapeau"
		,ear1="Telos Earring"
		,ear2="Enervating Earring"
		,neck="Iskur Gorget"
		,body="Malignance Tabard"
		,hands="Malignance Gloves"
		,ring1="Ilabrat Ring"
		,ring2="Dingir Ring"
		,back=camuRacc
		,waist="Tellen Belt"
		,legs="Adhemar Kecks +1"
		,feet="Malignance Boots"
	}
					
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		head="Malignance Chapeau"
		,body="Laksamana's Frac +3"
		,ring1="Regal Ring"
		,ring2="Hajduk Ring +1"
		,hands="Malignance Gloves"
		,waist="Kwahu Kachina Belt +1"
		,ear2="Beyla Earring"
	})

-- Triple Shot Set --
   sets.TripleShot = set_combine(sets.midcast.RA, {
			head="Oshosi Mask +1",
			body="Chasseur's Frac +1",
			hands="Lanun Gants +3",
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
	head=mabAgiHercHelm,
	neck="Commodore Charm +1",
	ear1="Crematio Earring",
	ear2="Friomisi Earring",
	body="Lanun Frac +3",
	hands="Nyame Gauntlets",
	ring1="Ilabrat Ring",
	ring2="Dingir ring",
	back=camuMabWsd,
	waist="Eschan Stone",
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
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	body="Laksamana's Frac +3",
	hands="Meghanada Gloves +2",
	ring1="Dingir Ring",
	ring2="Regal Ring",
	back=camuRatkWsd,
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Lanun Bottes +3"
   }
   
   sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
	head="Malignance Chapeau",
	neck="Iskur Gorget",
	ear1="Telos Earring",
	ring2="Cacoethic Ring +1",
	waist="K. Kachina Belt +1",
	feet="Meghanada Jambeaux +2"
   })
   
   sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
   sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
   
   sets.precast.WS['Savage Blade'] = {
	head="Nyame Helm",
	neck="Commodore Charm +1",
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	ring1="Karieyh Ring +1",
	ring2="Regal Ring",
	back=camuDa,
	waist="Prosilio Belt +1",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
   }
   
   sets.precast.WS['Requiescat'] = {
	head="Adhemar Bonnet +1",
	neck="Fotia Gorget",
	ear1="Telos Earring",
	ear2="Moonshade Earring",
	body="Adhemar Jacket +1",
	hands="Nyame Gauntlets",
	ring1="Ilabrat Ring",
	ring2="Regal Ring",
	back=camuDa,
	waist="Fotia Belt",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"
   }
   
   sets.engaged = {
	head="Adhemar Bonnet +1",
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
	head="Malignance Chapeau",
	body="Malignance Tabard",
	hands="Adhemar Wristbands +1",
	legs="Meghanada Chausses +2",
	waist="Grunfeld Rope",
	ring2="Regal Ring",
	ear2="Crepuscular Earring",
	neck="Combatant's Torque"
   })
   
   sets.defense.PDT = {
			head="Malignance Chapeau"
			,neck="Loricate Torque +1"
			,body="Malignance Tabard"
			,hands="Malignance Gloves"
			,ear1="Genmei Earring"
			,ring1="Purity Ring"
			,ring2="Defending Ring"
			,back=camuDT
			,waist="Flume Belt"
			,legs="Mummu Kecks +2"
			,feet="Malignance Boots"
   }
   sets.defense.MDT = sets.defense.PDT
   
   sets.idle = set_combine(sets.defense.PDT, {
			ring1="Sheltered Ring"
			,ring1="Karieyh Ring +1"
   })
   
   sets.idle.refresh = set_combine(sets.idle, {
			body="Mekosuchinae harness"
			,ring1="Stikini Ring +1"
   })
   
   sets.Kiting = {legs="Carmine Cuisses +1"}
   sets.Weather = {waist="Hachirin-no-Obi"}
			   				              
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if (spell.english == 'Double-Up' or spell.type == 'CorsairRoll') and state.LongRangeDoubleUp.value == true then
		equip(sets.LongRangeDoubleUp)
	elseif spell.english == 'Fold' and state.DoubleFold.value == true then
		equip(sets.DoubleFold)
	elseif spell.english == 'Ranged' and buffactive['Flurry'] then
		if (state.Flurry2.value == true) then
			equip(sets.precast.RA.Flurry2)
		else
			equip(sets.precast.RA.Flurry)
		end
	end
	if (spell.element == world.day_element or spell.element == world.weather_element) then
		equip(sets.Weather)
	end
	if spell.type == 'CorsairShot' and spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot' and state.QDTP.value == true then
		equip(sets.precast.CorsairShot.TP)
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
		if(weaponTable[state.WeaponMode.value]) then
			equip(weaponTable[state.WeaponMode.value])
		end
	end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 and (player.sub_job == "RDM" or player.sub_job == "DRK" or player.sub_job == "WHM" or player.sub_job == "SCH") then
        idleSet = set_combine(idleSet, sets.idle.refresh)
    end
    return idleSet
end