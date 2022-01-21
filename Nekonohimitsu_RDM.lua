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
    state.Buff.Saboteur = buffactive.saboteur or false
    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II', 'Poison', 'Poisonga'}	
	pure_macc_spells = S{'Break', 'Silence', 'Sleep', 'Sleep II', 'Sleepga', 'Breakga'} 
	no_cap_enh_skill = S{'Temper', 'Temper II', 'Enfire', 'Enblizzard',
	'Enaero', 'Enstone', 'Enthunder', 'Enwater', 'Enfire II', 'Enblizzard II', 'Enaero II', 'Enstone II', 'Enthunder II', 'Enwater II'}
	duration_only = S{'Dia', 'Dia II', 'Dia III', 'Bio', 'Bio II', 'Bio III'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	
    state.MagicBurst = M(false, 'Magic Burst')
	update_combat_form()
end


-- Define sets and vars used by this job file.
function init_gear_sets()	
	maccMatkSucCape = {name="Sucellos's Cape", augments={'INT+20', 'INT+10'}}
	mevaSucCape = {name="Sucellos's Cape", augments={'MND+20', 'Eva.+20/Mag. Eva.+20'}}
	storeTPSucCape = {name="Sucellos's Cape", augments={'"Store TP"+10'}}
	savageSucCape = {name="Sucellos's Cape", augments={'STR+20', 'STR+10'}}
	critSucCape = {name="Sucellos's Cape", augments={'DEX+20', 'Crit.hit rate+10'}}
	mndWsdSucCape = {name="Sucellos's Cape", augments={'MND+20', 'Weapon skill damage +10%'}}
	mndDaSucCape = {name="Sucellos's Cape", augments={'MND+20', '"Dbl.Atk."+10'}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
    sets.precast.FC = {ammo="Impatiens",
			head="Atrophy Chapeau +3",
			hands="Volte Gloves", legs="Volte Brais",
			ring1="Lebeche Ring", back="Perimede Cape", waist="Witful Belt", feet="Volte Gaiters",
			body="Vitiation Tabard +3"}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Crepuscular Cloak",
		main=grioFC,
		sub="Clerisy Strap",
		ear2="Malignance Earring",
		ring2="Kishar Ring"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	   
				
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {main="Tamaxchi", sub="Sors Shield", ammo="Pemphredo Tathlum", head="Kaykaus Mitra +1", neck="Orunmila's Torque",
			ear2="Malignance Earring", ear1="Enervating Earring", body="Kaykaus Bliaut", hands="Kaykaus Cuffs +1", ring1="Lebeche Ring", 
			ring2="Prolix Ring", back="Fi Follet Cape +1", waist="Witful Belt", legs="Vanya Slops", feet="Kaykaus Boots +1"}
        
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure
	sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
		main="Chatoyant Staff", sub="Clerisy Strap", waist="Hachirin-no-Obi"
	})
	
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {ring1="Haoma's Ring",
		ring2="Haoma's Ring", neck="Debilis Medallion", feet="Gendewitha Galoshes +1",
		ear1="Beatific Earring", ear2="Meili Earring", legs="Carmine Cuisses +1", head="Kaykaus Mitra +1",
		waist="Bishop's Sash", body="Vitiation Tabard +3", hands="Hieros Mittens",
		back="Oretania's Cape +1"})
    
	--Used for Pure MACC Spells (Sleep, Break, Silence, etc)
    sets.midcast.MndEnfeebles = {main="Contemplator +1", sub="Enki Strap", range="Ullr", ammo="", head="Vitiation Chapeau +3", neck="Duelist's Torque +1",
			 ear1="Regal Earring", ear2="Snotra Earring", body="Atrophy Tabard +3", hands="Kaykaus Cuffs +1", ring1="Metamorph Ring +1", ring2="Stikini Ring +1",
			 back="Aurist's Cape +1", waist="Luminary Sash", legs="Chironic Hose", feet="Vitiation Boots +3"}		 
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
		ear2="Malignance Earring",
		hands="Regal Cuffs"
	})
	
	--Duration only spells (Dia, Bio)
	sets.midcast.DurationEnfeebles = {ring1="Kishar Ring", ear1="Snotra Earring", neck="Duelist's Torque +1", hands="Regal Cuffs", head="Vitiation Chapeau +3", waist="Obstinate Sash"}
	
	--Used for spells where potency varies (Slow, Paralyze, Blind, Frazzle, etc)
	sets.midcast.EffectMndEnfeebles = set_combine(sets.midcast.MndEnfeebles, {main="Daybreak", sub="Ammurapi Shield", 
		range="", ammo="Regal Gem", body="Lethargy Sayon +1", hands="Volte Gloves",
		feet="Vitiation Boots +3", back=mevaSucCape, legs="Volte Brais"
	})
	
	sets.midcast.EffectIntEnfeebles = set_combine(sets.midcast.IntEnfeebles, {range="", head="Volte Beret", 
		hands="Volte Gloves", ammo="Regal Gem", ring2="Freke Ring", body="Lethargy Sayon +1",
		feet="Vitiation Boots +3", legs="Volte Brais", main="Rubicundity", sub="Ammurapi Shield", 
		legs="Volte Brais", waist="Acuity Belt +1", back=maccMatkSucCape
	})
	
	sets.midcast.EffectMndEnfeebles.Resistant = sets.midcast.MndEnfeebles
	sets.midcast.EffectIntEnfeebles.Resistant  = sets.midcast.IntEnfeebles
	
	--Used for spells where potency varies with Enfeebling Magic Skill
	sets.midcast.SkillMndEnfeebles = set_combine(sets.midcast.EffectMndEnfeebles, {
		main="Contemplator +1", sub="Mephitis Grip", ear1="Vor Earring", ear2="Enfeebling Earring",
		waist="Rumination Sash", feet="Vitiation Boots +3",
		hands="Lethargy Gantherots +1", ring1="Stikini Ring",
		legs="Chironic Hose", head="Vitiation Chapeau +3", ring2="Stikini Ring +1"
	})
	sets.midcast.SkillIntEnfeebles = set_combine(sets.midcast.EffectIntEnfeebles, {
		main="Contemplator +1", sub="Mephitis Grip", ear1="Vor Earring",  ear2="Enfeebling Earring",
		waist="Rumination Sash", feet="Vitiation Boots +3",
		hands="Lethargy Gantherots +1", ring1="Stikini Ring",
		legs="Chironic Hose", head="Vitiation Chapeau +3", ring2="Stikini Ring +1"
	})
	sets.midcast.SkillMndEnfeebles.Resistant = sets.midcast.EffectMndEnfeebles.Resistant
	sets.midcast.SkillIntEnfeebles.Resistant = sets.midcast.EffectIntEnfeebles.Resistant
	
			 
	sets.midcast['Dispel'] = set_combine(sets.midcast.IntEnfeebles, {neck="Duelist's Torque +1"})
	sets.midcast.Dispelga = set_combine(sets.midcast['Dispel'], {main="Daybreak", sub="Ammurapi Shield"})
    sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {head=empty,body="Crepuscular Cloak"})
    sets.midcast.Stun = set_combine(sets.midcast.IntEnfeebles, {
		head="Atrophy Chapeau +3",
		body="Vitiation Tabard +3",
		legs="Volte Brais",
		feet="Volte Gaiters"
	})
    
    sets.midcast['Elemental Magic'] = {
			main="Bunzi's Rod",
			sub="Ammurapi Shield",
			ammo="Pemphredo Tathlum",
			head="Cath Palug Crown",
			neck="Sanctity Necklace",
			ear1="Regal Earring",
			ear2="Malignance Earring",
			body="Amalric Doublet +1",
			hands="Amalric Gages +1",
			ring1="Shiva Ring +1",
			ring2="Freke Ring",
			back=maccMatkSucCape,
			waist="Sacro Cord",
			legs="Amalric Slops",
			feet="Vitiation Boots +3"
			}
	
	sets.magic_burst = {
		neck="Mizukage-no-Kubikazari",
        hands="Amalric Gages +1", --(5)
		ring1="Locus Ring",
        ring2="Mujin Band", --(5)
        }


    sets.midcast.Drain = set_combine(sets.midcast.IntEnfeebles, {
		ring1="Evanescence Ring", main="Rubicundity", sub="Ammurapi Shield",
		ring2="Archon Ring", waist="Fucho-no-Obi", head="Pixie Hairpin +1", feet=merlinicCrackowsDrainAspir})

    sets.midcast.Aspir = sets.midcast.Drain

    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {head="Telchine Cap", body="Vitiation Tabard +3", hands="Atrophy Gloves +3", back=mevaSucCape, legs="Telchine Braconi",
							main="Colada", sub="Ammurapi Shield", feet="Lethargy Houseaux +1", neck="Duelist's Torque +1", waist="Embla Sash"}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga", feet="Bunzi's Sabots"})
	
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.EnhancingDuration, {ring1="Stikini Ring", ring2="Stikini Ring +1"})

    sets.midcast.GainSpell = set_combine( sets.midcast['Enhancing Magic'] , {hands="Vitiation Gloves +3"})
	
	sets.midcast.NoCapEnhancingMagic = set_combine(sets.midcast['Enhancing Magic'], {
		head="Befouled Crown", neck="Incanter's Torque", ear2="Andoaa Earring", 
		hands="Vitiation Gloves +3", back="Ghostfyre Cape", waist="Olympus Sash", legs="Atrophy Tights +3",
		main="Pukulatmuj +1", ear1="Mimir Earring", sub="Forfend +1"
	})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", body="Atrophy Tabard +3", legs="Lethargy Fuseau +1"})

    sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh, {waist="Gishdubar Sash"})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
		ear1="Earthcry Earring",
		legs="Shedir Seraweels"
		})
	
	sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
		legs="Shedir Seraweels",
		hands="Regal Cuffs"})
        
    sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration, {head="Lethargy Chappel +1", legs="Lethargy Fuseau +1"})

    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
    
    -- Idle sets
    sets.idle = {		
		main="Daybreak",
		sub="Sacro Bulwark",
		ammo="Homiliary",
		head="Vitiation Chapeau +3",
		neck="Loricate Torque +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		body="Jhakri Robe +2",
		hands="Volte Gloves",
		ring1="Defending Ring",
		ring2="Stikini Ring +1",
		back=mevaSucCape,
		waist="Carrier's Sash",
		legs="Volte Brais",
		feet="Volte Gaiters"}
    
    -- Resting sets
    sets.resting = sets.idle
	
    sets.idle.Town = sets.idle
    
    sets.idle.Weak = sets.idle
	
    sets.idle.PDT = sets.idle

    sets.idle.MDT = sets.idle
    
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {head="Bunzi's Hat",
		body="Malignance Tabard", hands="Bunzi's Gloves", ammo="Staunch Tathlum +1",
		back=mevaSucCape, feet="Bunzi's Sabots",
		waist="Slipor Sash", ring2="Purity Ring", legs="Atrophy Tights +3",
		ear1="Sanare Earring"
	})

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {range="", ammo="Ginsen", head="Malignance Chapeau",
					body="Malignance Tabard", neck="Clotharius Torque", 
					ear1="Telos Earring", ear2="Sherida Earring", hands="Malignance Gloves",
					ring1="Chirich Ring +1", ring2="Chirich Ring +1", back=storeTPSucCape,
					waist="Windbuffet Belt +1", legs="Ayanmo Cosciales +2",
					feet="Malignance Boots"}
	sets.engaged.DW = set_combine(sets.engaged, {waist="Reiki Yotai", ear1="Suppanomimi"})
	
	sets.engaged.Acc = set_combine(sets.engaged, {ear1="Telos Earring", neck="Combatant's Torque", waist="Grunfeld Rope"})
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {ear1="Telos Earring", neck="Combatant's Torque"})

    sets.engaged.Defense = {}
	
	-- WS Sets
	sets.precast.WS['Evisceration'] = {head="Malignance Chapeau", neck="Fotia Gorget", ear1="Dominance Earring +1", ear2="Sherida Earring", 
				hands="Malignance Gloves", ring1="Ilabrat Ring", ring2="Begrudging Ring", back=critSucCape, waist="Fotia Belt",
				legs="Carmine Cuisses +1", feet="Thereoid Greaves", body="Ayanmo Corazza +2", ammo="Yetshila"}
	sets.precast.WS['Chant du Cygne'] = sets.precast.WS['Evisceration'] 
	
	sets.precast.WS['Savage Blade'] = {head="Nyame Helm", neck="Duelist's Torque +1", ear1="Ishvara Earring", ear2="Moonshade Earring",
				body="Nyame Mail", hands="Nyame Gauntlets", ring1="Karieyh Ring +1", ring2="Rufescent Ring", back=savageSucCape, 
				waist="Prosilio Belt +1", legs="Nyame Flanchard", feet="Nyame Sollerets", ammo="Voluspa Tathlum"}
	sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Seraph Blade'] = {head="Nyame Helm", neck="Baetyl Pendant", ear1="Moonshade Earring", ear2="Malignance Earring",
				body="Amalric Doublet +1", hands="Jhakri Cuffs +2", ring1="Freke Ring", ring2="Karieyh Ring +1", back=mndWsdSucCape, waist="Sacro Cord",
				legs="Nyame Flanchard", feet="Vitiation Boots +3", ammo="Pemphredo Tathlum"}
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Seraph Blade']
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Seraph Blade'], {ear1="Regal Earring", ring1="Archon Ring", head="Pixie Hairpin +1"})
	
	sets.precast.WS['Requiescat'] = {head="Vitiation Chapeau +3", neck="Duelist's Torque +1", ear1="Regal Earring", ear2="Moonshade Earring", 
				body="Vitiation Tabard +3", hands="Bunzi's Gloves", ring2="Rufescent Ring", ring1="Metamorph Ring +1", back=mndDaSucCape, 
				waist= "Grunfeld Rope", legs="Carmine Cuisses +1", feet="Bunzi's Sabots", ammo="Coiste Bodhar"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
	end
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur and not pure_macc_spells:contains(spell.english) and not duration_only:contains(spell.english) then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
		if no_cap_enh_skill:contains(spell.english) then
			equip(sets.midcast.NoCapEnhancingMagic)
		else 
			equip(sets.midcast.EnhancingDuration)
			if buffactive.composure and spell.target.type == 'PLAYER' then
				equip(sets.buff.ComposureOther)
				if spellMap == 'Refresh' then
					equip(sets.midcast.Refresh)
				end
			elseif spellMap == 'Refresh' then
				equip(sets.midcast.RefreshSelf)
			elseif spell.name == 'Aquaveil' then
				equip(sets.midcast.Aquaveil)
			end
		end 
    elseif spellMap == 'Cure' then
		if spell.target.type == 'SELF' then
			equip(sets.midcast.CureSelf)
		elseif (spell.element == world.day_element or spell.element == world.weather_element) then 
			equip(sets.midcast.CureWeather)
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
			if duration_only:contains(spell.english) then
				return "DurationEnfeebles"
			else
				if spell.type == "WhiteMagic" then
					if pure_macc_spells:contains(spell.english) then
						return "MndEnfeebles"
					elseif enfeebling_magic_skill:contains(spell.english) then
						return "SkillMndEnfeebles"
					else
						return "EffectMndEnfeebles"
					end	
				else 
					if pure_macc_spells:contains(spell.english) then
						return "IntEnfeebles"
					elseif enfeebling_magic_skill:contains(spell.english) then
						return "SkillIntEnfeebles"
					else
						return "EffectIntEnfeebles"
					end	
				end
			end 
        end
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function update_combat_form()
-- Check for H2H or single-wielding
	if player.sub_job == "DNC" or player.sub_job == "NIN" then
		state.CombatForm:set('DW')
	else
		state.CombatForm:reset()
	end
end