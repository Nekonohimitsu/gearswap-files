-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm',
		'Saurian Slide'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

	-- Physical spells with a debuff to stick
    blue_magic_maps.PhysicalMacc = S{
        'Frypan','Head Butt','Sudden Lunge',
		'Sweeping Gouge','Tail slap','Whirl of Rage'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Spectral Floe','Subduction','Tearing Gust','Tem. Upheaval',
		'Tenebral Crush','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast', 'Nectarous Deluge', 'Scouring Spate'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse',
		'Entomb',
		'Uproot'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades', 'Anvil Lightning'
    }
	
	blue_magic_maps.MagicalStr = S{'Searing Tempest', 'Blinding Fulgor', 'Polar Roar'}
	
	blue_magic_maps.MagicalAgi = S{'Crashing Thunder', 'Molting Plumage', 'Palling Salvo', 'Silent Storm'}
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blitzstrahl','Blood Drain','Blood Saber','Cesspool', 'Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Cruel Joke','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Temporal Shift','Thunderbolt','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Mighty Guard','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Mighty Guard','Tearing Gust','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'PDL', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'LoseTP', 'LoseTPRes')
    state.IdleMode:options('Normal', 'Refresh')
	
	if not buffactive['Auspice'] then
		classes.CustomMeleeGroups:append('NoAuspice')
	end
	
	state.Learning = M(false, 'Learning Spells')
	
	storedMain = ""
	storedSub = ""
end

-- Set up gear sets.
function init_gear_sets()
	rosmertaMacc = {name="Rosmerta's Cape", augments={'INT+20', 'Mag. Acc+10', '"Fast Cast"+10%', 'Mag. Acc.+20/Mag. Dmg.+20'}}
	rosmertaTP = {name="Rosmerta's Cape", augments={'DEX+20', 'DEX+10', '"Dbl.Atk."+10'}}
	rosmertaSTRWS = {name="Rosmerta's Cape", augments={'Weapon skill damage +10%', 'STR+20', 'STR+10'}}

    define_spell_and_ja_sets()
	define_idle_dt_sets()  
	define_ws_sets()
	define_engaged_sets()
end

function define_spell_and_ja_sets()
	
    -- Sets to enhance JAs
    sets.buff.Diffusion = {
		feet="Luhlaza Charuqs +2", -- Duration +5% per merit (max +45%)
	}
	sets.buff['Burst Affinity'] = {
		--legs="Assimilator's Shalwar +3", -- WSC+0.16
		feet="Hashishin Basmak +3", -- WSC+0.21
	}
	sets.buff['Chain Affinity'] = {
		head="Hashishin Kavuk +3", -- DMG+28
		--feet="Assimilator's Charuqs +3", -- DMG+24
	}
	sets.buff.Efflux = {
		legs="Hashishin Tayt +3", -- TP Bonus +800
		back=rosmertaSTRWS -- TP Bonus +250
	}
    sets.precast.JA['Azure Lore'] = {
		hands="Luhlaza Bazubands +2", -- Extend duration by 10s.
	}
 
    -- Fast cast sets for spells
    sets.precast.FC = {
		-- Total: FC: 70%, Quicken: 3%
		-- Total (Goal): FC: 80%, Quicken: 3%
		ammo="Sapience Orb", -- 2%
		ear1="Loquacious Earring", -- 2%
		ear2="Etiolation Earring", -- 1%
		ring1="Kishar Ring", -- 4%
		ring2="Prolix Ring", -- 2%
		waist="Witful Belt", -- 3%
		neck="Orunmila's Torque", -- 5%
		back=rosmertaMacc, -- 10%
		feet="Carmine Greaves", -- 7%
		head="Carmine Mask", -- 12% (Amalric Coif +1 is 11%)
		hands="Leyline Gloves", -- 8%
		--legs="Pinga Pants", -- 11%
		legs="Ayanmo Cosciales +2", -- 6%
		--body="Pinga Tunic", -- 13%
		body="Luhlaza Jubbah +2", -- 8%
	}
    
    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC)
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
		ammo="Coiste Bodhar",
		head="Gleti's Mask",
		neck="Mirage Stole +1",
		ear1="Telos Earring",
		ear2="Hashishin Earring +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Ilabrat Ring",
		ring2="Beithir Ring",
		back=rosmertaTP,
		waist="Sailfi Belt +1",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"
	}

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalMacc = set_combine(sets.midcast['Blue Magic'].Physical, {})

    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
		ammo="Ghastly Tathlum +1",
		head="Hashishin Kavuk +3",
		neck="Sibyl Scarf",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		body="Hashishin Mintan +3",
		hands="Hashishin Bazubands +3",
		ring1="Shiva Ring +1",
		ring2="Metamorph Ring +1",
		back=rosmertaMacc,
		waist="Sacro Cord",
		legs="Luhlaza Shalwar +2",
		feet="Hashishin Basmak +3"
	}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
    sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
    sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
	sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"
	})

    sets.midcast['Blue Magic'].MagicAccuracy = {
		ammo="Pemphredo Tathlum",
		head="Hashishin Kavuk +3",
		neck="Mirage Stole +1",
		ear1="Dignitary's Earring",
		ear2="Hashishin Earring +1",
		body="Hashishin Mintan +3",
		hands="Hashishin Bazubands +3",
		ring1="Stikini Ring +1",
		ring2="Metamorph Ring +1",
		back="Aurist's Cape +1",
		waist="Acuity Belt +1",
		legs="Hashishin Tayt +3",
		feet="Hashishin Basmak +3"
	}
	
	sets.midcast['Blue Magic'].MagicAccuracy.Resistant = set_combine(sets.midcast['Blue Magic'], {})
	
	sets.MaccWeapons = {
		main="Sakpata's Sword", -- R25: MACC+50 Skill+248
		sub="Bunzi's Rod", -- R25: MACC+50 Skill+255
	}
	
	sets.midcast['Blue Magic'].MagicAccuracy.LoseTP = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, sets.MaccWeapons)
	
	sets.midcast['Blue Magic'].MagicAccuracy.LoseTPRes = set_combine(sets.midcast['Blue Magic'].MagicAccuracy.Resistant, sets.MaccWeapons)

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {
		ammo="Egoist's Tathlum",
		head="Luhlaza Keffiyeh +2",
		neck="Unmoving Collar +1",
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Supershear Ring",
		ring2="Gelatinous Ring +1",
		back="Moonlight Cape",
		waist="Platinum Moogle Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}

    -- Other Types --
	
    sets.midcast['Blue Magic'].Healing = {
		--head="Pinga Crown",
		--body="Pinga Tunic",
		ring1="Naji's Loop",
		hands="Telchine Gloves"
		--legs="Pinga Pants",
		--feet="Pinga Pumps"
	}
        
    sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
		ammo="Egoist's Tathlum",
		neck="Unmoving Collar +1",
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
		ring2="Gelatinous Ring +1",
		back="Moonlight Cape",
		waist="Platinum Moogle Belt",
	})
	
	sets.midcast['Blue Magic']['Battery Charge'] = {
		head="Amalric Coif +1",
		waist="Gishdubar Sash"
	}


    sets.midcast['Blue Magic'].SkillBasedBuff = {
		ammo="Mavi Tathlum",
		head="Luhlaza Keffiyeh +2",
		neck="Mirage Stole +1",
		--ear1="Njordr Earring",
		ear2="Hashishin Earring +1",
		body="Magus Jubbah +1",
		--body="Assimilator's Jubbah +3",
		--hands="Rawhide Gloves",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Cornflower Cape",
		legs="Hashishin Tayt +3",
		feet="Luhlaza Charuqs +2"
	}

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
		back="Oretania's Cape +1",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		hands="Hieros Mittens",
		neck="Debilis Medallion",
		waist="Gishdubar Sash"
	})
    
    sets.self_healing = {
		waist="Gishdubar Sash",
	}
end
function define_ws_sets()
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Hashishin Kavuk +3",
		neck="Mirage Stole +1",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Karieyh Ring +1",
		ring2="Cornelia's Ring",
		back=rosmertaSTRWS,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	}
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.PDL = set_combine(sets.precast.WS, {
		ammo="Crepuscular Pebble",
		body="Gleti's Cuirass",
		legs="Gleti's Breeches",
		ring1="Sroda Ring"
	})
	
	sets.precast.WS['Chant du Cygne'] = {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		neck="Mirage Stole +1",
		ear1="Dominance Earring +1",
		--ear1="Mache Earring +1",
		ear2="Moonshade Earring",
		--ear2="Odr Earring",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Epona's Ring",
		ring2="Begrudging Ring",
		back=rosmertaTP, 
		waist="Fotia Belt",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"
	}
end
function define_engaged_sets()
	sets.FullAccuracy = {
		ring1="Cacoethic Ring +1"
	}
	sets.MinSubtleBlow = {
		-- Assumes Auspice, requires 21 Subtle Blow
		legs="Gleti's Breeches", -- 15
		ring1="Chirich Ring +1", -- 6
	}
	sets.FullSubtleBlow = set_combine(sets.MinSubtleBlow, {
		-- Requires 50 Subtle Blow to cap
		-- Min set gives +21
		neck="Bathy Choker +1", -- 11
		ear1="Dignitary's Earring", -- 5
		ring2="Chirich Ring +1", -- 6
		ammo="Expeditious Pinion", -- 7
	})
	
	-- Normal TP Sets
    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Adhemar Bonnet +1",
		neck="Mirage Stole +1",
		ear1="Telos Earring",
		ear2="Suppanomimi",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		ring1="Epona's Ring",
		ring2="Chirich Ring +1",
		back=rosmertaTP,
		waist="Sailfi Belt +1",
		legs="Samnuha Tights",
		feet="Herculean Boots"
	}

    sets.engaged.Acc = set_combine(sets.engaged, sets.FullAccuracy)
	
	sets.engaged.SubtleBlow = set_combine(sets.engaged, sets.MinSubtleBlow)
	
	sets.engaged.SubtleBlow.NoAuspice = set_combine(sets.engaged, sets.FullSubtleBlow)
	
	-- Hybrid TP Sets
	
	sets.engaged.DT = set_combine(sets.engaged, {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		neck="Mirage Stole +1",
		ear1="Telos Earring",
		ear2="Suppanomimi",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Epona's Ring",
		ring2="Defending Ring",
		back=rosmertaTP,
		waist="Reiki Yotai",
		legs="Gleti's Breeches",
		feet="Malignance Boots"
	})

    sets.engaged.DT.Acc = set_combine(sets.engaged.DT, sets.FullAccuracy)
	
	sets.engaged.DT.SubtleBlow = set_combine(sets.engaged.DT, sets.MinSubtleBlow)
	
	sets.engaged.DT.SubtleBlow.NoAuspice = set_combine(sets.engaged.DT, sets.FullSubtleBlow)
end
function define_idle_dt_sets() 

    sets.latent_refresh = {waist="Fucho-no-obi"}
	
    -- Defense sets
    sets.defense.PDT = {
		-- Total: DEF+772, VIT+205, PDT-69%, MDT-43%, MDEF+52
		head="Gleti's Mask", -- DEF+152, VIT+30, PDT-6%, MDEF+13
		body="Nyame Mail", -- DEF+189, VIT+35, DT-9%, MDEF+8
		hands="Nyame Gauntlets", -- DEF+142, VIT+49, DT-7%, MDEF+4
		legs="Gleti's Breeches", -- DEF+165, VIT+37, PDT-8%, MDEF+14
		feet="Gleti's Boots", -- DEF+119, VIT+26, PDT-5%, MDEF+13
		neck="Loricate Torque +1", -- DT-6%, DEF+55,
		ammo="Staunch Tathlum +1", -- DT-3%
		ear2="Tuisto Earring", --DEF+20, VIT+10
		ear1="Odnowa Earring +1", -- DEF+30, VIT+3, MDT-2%, DT-3%,
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1", -- VIT+15, PDT-7%, MDT+1%
		waist="Platinum Moogle Belt",
		back=rosmertaTP, -- DT-5%
	}

    sets.defense.MDT = set_combine(sets.defense.PDT, {
		-- 45% DT, 5% MDT
		body="Hashishin Mintan +3",
		hands="Hashishin Bazubands +3",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		ear2="Etiolation Earring", 
		ring2="Shadow Ring",
		back="Moonlight Cape"
	})
    
    -- Idle sets
    sets.idle = {
		--Total: PDT-56%, MDT-35%, Regain+14, Refresh+4
		head="Gleti's Mask", -- PDT-6%, Regain+2
		neck="Loricate Torque +1", -- DT-6%
		body="Hashishin Mintan +3", -- DT-13%, Refresh+4
		hands="Gleti's Gauntlets", -- PDT-7%, Regain+2
		legs="Gleti's Breeches", -- PDT-8%, Regain+3
		feet="Gleti's Boots", --PDT-5%, Regain+2
		ring1="Karieyh Ring +1", --Regain+5
		ring2="Sheltered Ring",
		waist="Carrier's Sash",
		back=rosmertaTP, -- DT-5%
		ear1="Odnowa Earring +1", -- DT-3%, MDT-2%
		ear2="Etiolation Earring", -- MDT-3%
		ammo="Staunch Tathlum +1", -- DT-3%
	}
	
	sets.idle.Refresh = set_combine(sets.idle, {
		neck="Sibyl Scarf",
		ring1="Stikini Ring +1",
	})

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.Learning = { hands="Magus Bazubands +1" }
end 

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
	
	if (state.CastingMode.value == 'LoseTP' or state.CastingMode.value == 'LoseTPRes') then
		storedMain = player.equipment.main
		storedSub = player.equipment.sub
	end
end

function job_state_change(state, new_state_value, old_state_value)
    if (state == 'Learning Spells') then
		if (new_state_value == true) then
			-- If in learning mode, keep on gear intended to help with that, regardless of action.
			equip(sets.Learning)
			disable('hands')
		else
			enable('hands')
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
	if (storedMain ~= "" or storedSub ~= "") then
		equip({main=storedMain, sub=storedSub})
		storedMain=""
		storedSub=""
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	if (buff == 'Auspice') then 
		if gain then
			classes.CustomMeleeGroups:clear()
		else
			classes.CustomMeleeGroups:append('NoAuspice')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end