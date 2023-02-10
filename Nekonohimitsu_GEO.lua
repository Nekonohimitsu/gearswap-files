-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+- ]           Magic Burst Mode Toggle
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


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
    indi_timer = ''
    indi_duration = 180
    newLuopan = 0

    state.Buff.Entrust = buffactive.Entrust or false
    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

    state.CP = M(false, "Capacity Points Mode")

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}

    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
	state.HybridMode:options('DT','Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
	send_command('bind !- gs c toggle MagicBurst')
end


function user_unload()
	send_command('unbind !- gs c toggle MagicBurst')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	nantoPet = {name="Nantosuelta's Cape", augments={"Pet: Regen+10"}}
	nantoMatk = {name = "Nantosuelta's Cape", augments={'"Mag.Atk.Bns."+10'}}
	vanyaHoodConserveMp = {name="Vanya Hood", augments={'"Conserve MP"+6'}}
	grioFC = {name="Grioavolr", augments={"Fast Cast +7%"}}
	gadaIndiDur = {name="Gada", augments={"Indi. eff. dur. +10%"}}
	gadaEnhDur = {name="Gada", augments={"Enh. Mag. eff. dur. +5"}}
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +3", hands="Bagua Mitaines +3"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +3", back="Nantosuelta's Cape",}
	sets.precast.JA['Concentric Pulse'] = {head="Bagua Galero +3"}

    -- Fast cast sets for spells

    sets.precast.FC = {
        ranged="Dunna", --3
        main=grioFC, --11
		--sub="Clerisy Strap +1", -- 3
        sub="Clerisy Strap", --2
        head="Amalric Coif +1", --11
        body="Agwu's Robe", --8
        hands="Volte Gloves", --6, 
        legs="Geomancy Pants +3", --13
        feet="Volte Gaiters", --6
        neck="Orunmila's Torque", --5
        ear2="Malignance Earring", --4
        ring1="Kishar Ring", --4
        ring2="Lebeche Ring",
        back="Perimede Cape",
        waist="Witful Belt", --3(3)
    }

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Chanter's Shield"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Niqmaddu Ring",
		ring2="Karieyh Ring +1",
		back=nantoMatk,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
    }
	
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		neck="Republican Platinum Medal",
		waist="Grunfeld Rope",
		ring1="Rufescent Ring",
		--back=strWsdNanto
	})

    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {}) -- Haste

   sets.midcast.Geomancy = {
        main="Idris",
        sub="Chanter's Shield",
		ammo="Dunna",
		head="Azimuth Hood +3",
        body="Vedic Coat",
		hands="Azimuth Gloves +2",
		legs="Vanya Slops",
		feet="Azimuth Gaiters +3",
        neck="Bagua Charm +1",
		--neck="Bagua Charm +2",
        ring2="Defending Ring",
        ring1="Mephitas's Ring +1",
        waist="Shinjutsu-no-obi +1",
		back="Fi Follet Cape +1"
        }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		head="Azimuth Hood +3",
		neck="Incanter's Torque",
		legs="Bagua Pants +3",
        feet="Azimuth Gaiters +3",
        back="Lifestream Cape"
    })

    sets.midcast.Cure = {
        main="Tamaxchi", --22
        sub="Sors Shield", --3/(-5)
        head=vanyaHoodConserveMp, --10
        body="Zendik Robe",
        hands="Bagua Mitaines +3",
        legs="Geomancy Pants +3",
        feet="Vanya Clogs", --12
        neck="Incanter's Torque",
        ear1="Calamitous Earring",
        ring1="Lebeche Ring", --3/(-5)
        ring2="Naji's Loop",
        waist="Hachirin-no-Obi"
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
    })

    sets.midcast.Cursna = set_combine(sets.precast.FC, {
        neck="Debilis Medallion",
        ring1="Haoma's Ring",
        ring2="Haoma's Ring",
		--ring2="Menelaus's Ring",
		hands="Hieros Mittens",
		back="Oretania's Cape +1",
		feet="Vanya Clogs"
    })

    sets.midcast['Enhancing Magic'] = {
        main=gadaEnhDur,
        sub="Ammurapi Shield",
        head="Befouled Crown",
        body="Telchine Chas.",
        neck="Incanter's Torque",
		ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1="Stikini Ring",
		ring2="Stikini Ring +1",
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main=gadaEnhDur,
        sub="Ammurapi Shield",
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
		legs="Telchine Braconi",
		feet="Telchine Pigaches",
		waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga"
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry Earring",
		legs="Shedir Seraweels"
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		main="Vadose Rod",
		sub="Ammurapi Shield",
		head="Amalric Coif +1",
		legs="Shedir Seraweels",
		hands="Regal Cuffs",
		waist="Emphatikos Rope",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect


    sets.midcast.MndEnfeebles = {
        main="Contemplator +1",
        sub="Kaja Grip",
		--head="Azimuth Hood +3",
        head="Geomancy Galero +3",
		--body="Azimuth Coat +3",
        body="Geomancy Tunic +3",
		--hands="Azimuth Gloves +3",
		hands="Azimuth Gloves +2",
		--legs="Azimuth Tights +3",
        legs="Geomancy Pants +3",
		--feet="Azimuth Gaiters +3",
        feet="Geomancy Sandals +3",
        neck="Bagua Charm +1",
        ear1="Malignance Earring",
        ear2="Azimuth Earring +1",
		--ear2="Azimuth Earring +2",
        ring1="Metamorph Ring +1",
        ring2="Stikini Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
	}) -- INT/Magic accuracy
	
	sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.IntEnfeebles, {
		ring1="Evanescence Ring",
		neck="Erra Pendant"
        })

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Ammurapi Shield",
        head="Bagua Galero +3",
		neck="Erra Pendant",
		body="Geomancy Tunic +3",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
		waist="Fucho-no-Obi",
		feet="Agwu's Pigaches"
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        head="Agwu's Cap",
		--body="Azimuth Coat +3",
        body="Agwu's Robe",
		hands="Agwu's Gages",
        legs="Agwu's Slops",
        feet="Agwu's Pigaches",
		neck="Sibyl Scarf",
        ear2="Malignance Earring",
        ear1="Regal Earring",
		--ear2="Azimuth Earring +2",
        ring1="Metamorph Ring +1",
        ring2="Freke Ring",
        back=nantoMatk,
        waist="Acuity Belt +1",
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    })

    sets.magic_burst = {
		head="Ea Hat +1"
    }

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
        head=empty,
        body="Crepuscular Cloak",
        ring2="Archon Ring",
    })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Mpaca's Staff",
        sub="Oneiros Grip",
		range="Dunna",
        head="Volte Beret",
		neck="Sibyl Scarf",
        ear1="Odnowa Earring +1",
        ear2="Azimuth Earring +1",
		--ear2="Azimuth Earring +2",
		--body="Azimuth Coat +3",
        body="Jhakri Robe +2",
        hands="Bagua Mitaines +3",
        ring1="Defending Ring",
		--ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        legs="Assid. Pants +1",
        feet="Volte Gaiters",
        back=nantoPet,
        waist="Carrier's Sash",
    }

    sets.resting = set_combine(sets.idle, {
		
    })

    sets.idle.DT = set_combine(sets.idle, {
		head="Azimuth Hood +3", -- 11% / 0% / 0%
		neck="Loricate Torque +1", -- 6% / 0% / 0%
		ear1="Odnowa Earring +1", -- 3% / 0% / 2%
		--ear2="Azimuth Earring +2", -- 7% / 0% / 0%
		ring1="Defending Ring", -- 10% / 0% / 0%
		legs="Agwu's Slops", -- 7% / 0% / 0%
		feet="Azimuth Gaiters +3", -- 10% / 0% / 0% --Remove when Azimuth Earring +2 obtained.
		back=nantoPet, -- 5% / 0% / 0%
		------------------------------------------
		-- 52% / 0% / 2%
    })

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        main="Idris", 
        sub="Genmei Shield", 
		ammo="Dunna", 
		head="Azimuth Hood +3",
        body="Jhakri Robe +2", 
		--body="Telchine Chas.",
        hands="Geo. Mitaines +3",
		--hands="Telchine Gloves",
        legs="Assiduity Pants +1",
		--legs="Telchine Braconi",
        feet="Bagua Sandals +3",
        neck="Bagua Charm +1",
		--neck="Bagua Charm +2",
        ear1="Odnowa Earring +1",
		--ear1="Azimuth Earring +2",
        ear2="Azimuth Earring +1",
		--ear2="Hypaspist Earring",
        ring1="Defending Ring",
		--ring1="Stikini Ring +1",
        ring2="Stikini Ring +1",
        back=nantoPet, 
        waist="Isa Belt" 
        })
		
		
        -- Pet: -DT (37.5% to cap) / Pet: Regen
    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        main="Idris", 
        sub="Genmei Shield",
		ammo="Dunna", 
		head="Azimuth Hood +3",
        body="Nyame Mail", 
        hands="Geo. Mitaines +3", 
        legs="Agwu's Slops", 
        feet="Bagua Sandals +3", 
        neck="Bagua Charm +1",
		--neck="Bagua Charm +2",
		--ear1="Azimuth Earring +2",
        ring1="Defending Ring", 
		ring2="Shadow Ring",
        back=nantoPet, 
        waist="Isa Belt" 
		-- 45 DT, 13% PDT, 5% MDT
        })

    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle.DT.Pet, {
		head="Nyame Helm",
		neck="Warder's Charm +1",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		ring2="Shadow Ring",
		ear2="Sanare Earring"
	})
    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {feet="Geo. Sandals +3"}

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = set_combine(sets.idle.DT.Pet, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		ear1="Crepuscular Earring",
		ear2="Telos Earring",
		neck="Combatant's Torque",
		--back=dexDaNanto,
		waist="Goading Belt",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1"
    })
	sets.engaged.DT = set_combine(sets.engaged, {
		hands="Geomancy Mitaines +3",
		ring2="Defending Ring",
		neck="Bagua Charm +1"
	})


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring1="Purity Ring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and state.Buff.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Aspir' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and not spell.english == "Impact" then
            equip(sets.magic_burst)
        end
        if is_matching_day_weather(spell) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Geomancy' then
        if state.Buff.Entrust and spell.english:startswith('Indi-') then
            equip({main=gadaIndiDur})
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

function is_matching_day_weather(spell)
	if spell.element == world.weather_element then
		return true
	elseif spell.element == world.day_element then
		if elements.weak_to[spell.element] == world.weather_element then
			return false
		end
	end
	return false
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Auto.value then
        msg = ' Auto: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spellMap == 'Aspir' then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 1)
end