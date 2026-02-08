---------------------------------------
-- Last Revised: February 23rd, 2021 --
---------------------------------------
-- Added Gleti's Armor Set
---------------------------------------------
-- Gearswap Commands Specific to this File --
---------------------------------------------
-- Universal Ready Move Commands -
-- //gs c Ready one
-- //gs c Ready two
-- //gs c Ready three
-- //gs c Ready four
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 cycles backwards through designated Jug Pets
-- alt+F11 toggles Monster Correlation between Neutral and Favorable
-- alt+= switches between Pet-Only (Axe Swaps) and Master (no Axe Swap) modes
-- ctrl+= switches between Reward Modes (Theta / Roborant)
-- alt+` can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-------------------------------
-- General Gearswap Commands --
-------------------------------
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Correlation/etc reset to default options.
-- F12 will list your current options.
--
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false

    get_combat_form()
    get_melee_groups()
end

function user_setup()
    state.OffenseMode:options('Normal', 'HighBuff')
    state.WeaponskillMode:options('Normal','WSHighBuff')
    state.HybridMode:options('Normal', 'SubtleBlow')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise', 'Refresh')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'PetMDT')


    -- Set up Monster Correlation Modes and keybind Alt+F11
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
    send_command('bind !f11 gs c cycle CorrelationMode')

    -- Set up Axe Swapping Modes and keybind alt+=
    state.AxeMode = M{['description']='Axe Mode', 'WeaponLocked', 'WeaponUnlocked'}
    send_command('bind != gs c cycle AxeMode')

    -- Set up Reward Modes and keybind ctrl+=
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Roborant'}
    send_command('bind ^= gs c cycle RewardMode')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    -- Set up Treasure Modes and keybind Alt+`
    state.TreasureMode = M{['description']='Treasure Mode', 'Tag', 'Normal'}
    send_command('bind !` gs c cycle TreasureMode')

    -- 'Out of Range' distance; Melee WSs will auto-cancel
    target_distance = 8

	-- Categorized list of Ready moves
	physical_ready_moves = S{'Foot Kick','Whirl Claws','Sheep Charge','Lamb Chop','Head Butt','Wild Oats',
		'Leaf Dagger','Claw Cyclone','Razor Fang','Crossthrash','Nimble Snap','Cyclotail','Rhino Attack',
		'Power Attack','Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick',
		'Blockhead','Brain Crush','Tail Blow','Scythe Tail','Ripper Fang','Chomp Rush','Needleshot',
		'Recoil Dive','Sudden Lunge','Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel',
		'Fantod','Tortoise Stomp','Sensilla Blades','Tegmina Buffet','Pentapeck','Sweeping Gouge',
		'Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash','Disembowel','Extirpating Salvo',
		'Mega Scissors','Rhinowrecker','Hoof Volley','Fluid Toss','Fluid Spread'}

	magic_atk_ready_moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
		'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Corrosive Ooze',
		'Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
		'Acid Spray','Infected Leech','Gloom Spray','Venom Shower'}

	magic_acc_ready_moves = S{'Sheep Song','Scream','Dream Flower','Roar','Predatory Glare','Gloeosuccus',
		'Palsy Pollen','Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
		'Sandpit','Sandblast','Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom',
		'Infrasonics','Chaotic Eye','Blaster','Purulent Ooze','Intimidate','Noisome Powder','Acid Mist',
		'Choke Breath','Jettatura','Nihility Song','Molting Plumage','Swooping Frenzy','Spider Web'}

	multi_hit_ready_moves = S{'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap',
		'Pecking Flurry'}

	tp_based_ready_moves = S{'Foot Kick','Dust Cloud','Snow Cloud','Sheep Song','Sheep Charge','Lamb Chop',
		'Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
		'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
		'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
		'Mandibular Bite','Metallic Body','Bubble Shower','Grapple','Spinning Top','Double Claw','Spore',
		'Filamented Hold','Blockhead','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics',
		'Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive','Water Wall',
		'Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
		'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
		'Corrosive Ooze','Tortoise Stomp','Aqua Breath','Sensilla Blades','Tegmina Buffet','Sweeping Gouge',
		'Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Gloom Spray',
		'Disembowel','Extirpating Salvo','Rhinowrecker','Venom Shower','Fluid Toss','Fluid Spread','Digest'}

	-- List of Pet Buffs and Ready moves exclusively modified by Pet TP Bonus gear.
	pet_buff_moves = S{'Wild Carrot','Bubble Curtain','Scissor Guard','Secretion','Rage','Harden Shell',
		'TP Drainkiss','Fantod','Rhino Guard','Zealous Snort','Frenzied Rage','Digest'}

	-- List of Jug Modes that will cancel if Call Beast is used (Bestial Loyalty-only jug pets, HQs generally).
	call_beast_cancel = S{'Vis. Broth','Ferm. Broth','Bubbly Broth','Windy Greens','Bug-Ridden Broth','Tant. Broth',
		'Glazed Broth','Slimy Webbing','Deepwater Broth','Venomous Broth','Heavenly Broth'}

	-- List of abilities to reference for applying Treasure Hunter gear.
	abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish',
		'Violent Flourish','Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II',
		'Sleep','Sleep II','Drain','Aspir','Dispel','Stun','Steal','Mug'}

	enmity_plus_moves = S{'Provoke','Berserk','Warcry','Aggressor','Holy Circle','Sentinel','Last Resort',
		'Souleater','Vallation','Swordplay'}
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

    -- Unbinds the Reward, Correlation, AxeMode and Treasure hotkeys.
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind @f8')
    send_command('unbind ^f11')
end

-- BST gearsets
function init_gear_sets()
    -------------------------------------------------
    -- AUGMENTED GEAR AND GENERAL GEAR DEFINITIONS --
    -------------------------------------------------

    Pet_Idle_AxeMain = "Aymur"
    Pet_Idle_AxeSub = "Izizoeksi"
    Pet_DT_AxeMain = "Ankusa Axe"
    Pet_DT_AxeSub =  {name="Digirbalag", augments={'Pet: Damage taken -5%','Pet: STR+3','Pet: Accuracy+12 Pet: Rng. Acc.+12','Pet: Attack+6 Pet: Rng.Atk.+6',}} 
    Pet_TP_AxeMain = "Skullrender"
    Pet_TP_AxeSub = "Skullrender"
--    Pet_Regen_AxeMain = "Buramgh +1"
--    Pet_Regen_AxeSub = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}

    Ready_Atk_Axe = "Aymur"
    Ready_Atk_Axe2 = "Agwu's Axe"
    Ready_Atk_TPBonus_Axe = "Aymur"
    Ready_Atk_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: Acc.+22 Pet: Rng.Acc.+22','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: TP Bonus+200',}}	--Replace with Ikenga at rank 23

    Ready_Acc_Axe = "Agwu's Axe"
    Ready_Acc_Axe2 = "Arktoi"

    Ready_MAB_Axe = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+22','Pet: TP Bonus+200',}}
    Ready_MAB_Axe2 = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+20','Pet: TP Bonus+200',}}
    Ready_MAB_TPBonus_Axe = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+22','Pet: TP Bonus+200',}}
    Ready_MAB_TPBonus_Axe2 = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+20','Pet: TP Bonus+200',}}

    Reward_Axe = "Farsha"
    Reward_Axe2 = {name="Kumbhakarna", augments={'Pet: Mag. Evasion+20','Pet: "Regen"+3','MND+17',}}
--    Reward_back = {name="Artio's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}

    Pet_PDT_head = "Nyame Helm"
    Pet_PDT_body = "Totemic Jackcoat +3"
    Pet_PDT_hands = "Gleti's Gauntlets"
    Pet_PDT_legs = "Nukumi quijotes +3"
    Pet_PDT_feet = "Gleti's Boots"

    Pet_MDT_head = "Nyame Helm"
    Pet_MDT_body = "Totemic Jackcoat +3"
    Pet_MDT_hands = "Gleti's Gauntlets"
    Pet_MDT_legs = "Nukumi Quijotes +3"
    Pet_MDT_feet = "Gleti's Boots"
    Pet_MDT_back = "Engulfer Cape +1"
	
    Pet_DT_head = "Nyame Helm"
    Pet_DT_body = "Totemic Jackcoat +3"
    Pet_DT_hands = "Gleti's Gauntlets"
    Pet_DT_legs = "Nukumi quijotes +3"
    Pet_DT_feet = "Gleti's Boots"

    Pet_Regen_head = {name="Valorous Mask", augments={'Pet: "Regen"+5','Pet: Accuracy+13 Pet: Rng. Acc.+13',}}
    Pet_Regen_body = {name="Valorous Mail", augments={'Pet: Accuracy+27 Pet: Rng. Acc.+27','Pet: "Regen"+5','Pet: Attack+4 Pet: Rng.Atk.+4',}}
    Pet_Regen_hands = {name="Valorous Mitts", augments={'Pet: Accuracy+29 Pet: Rng. Acc.+29','Pet: "Regen"+5','Pet: DEX+7','Pet: Attack+15 Pet: Rng.Atk.+15',}}
    Pet_Regen_legs = {name="Valorous Hose", augments={'Pet: "Regen"+5','Pet: Attack+1 Pet: Rng.Atk.+1',}}
--    Pet_Regen_feet = "Emicho Gambieras +1"
    Pet_Regen_back = {name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','"Regen"+5'}}

    Ready_Atk_head = "Nyame Helm"
    Ready_Atk_body = "Nyame Mail"
    Ready_Atk_hands = "Nukumi Manoplas +2"
    Ready_Atk_legs = "Nyame Flanchard"
    Ready_Atk_feet = "Gleti's Boots"

    Ready_Acc_head = "Gleti's Mask"
    Ready_Acc_body = "Nyame Mail"
    Ready_Acc_hands = "Gleti's Gauntlets"
    Ready_Acc_legs = "Nyame Flanchard"
    Ready_Acc_feet = "Gleti's Boots"

    Ready_MAB_head = {name="Valorous Mask", augments={'Pet: "Mag.Atk.Bns."+25','Pet: INT+14','Pet: Accuracy+14 Pet: Rng. Acc.+14',}}
    Ready_MAB_body = {name="Valorous Mail", augments={'Pet: "Mag.Atk.Bns."+28','Pet: Haste+2','Pet: CHR+12','Pet: Attack+1 Pet: Rng.Atk.+1',}}
    Ready_MAB_hands = {name="Valorous Mitts", augments={'Pet: "Mag.Atk.Bns."+30','Pet: "Dbl. Atk."+5','Pet: Accuracy+11 Pet: Rng. Acc.+11',}}
    Ready_MAB_legs = {name="Valorous Hose", augments={'Pet: "Mag.Atk.Bns."+29','Pet: INT+4','Pet: Accuracy+15 Pet: Rng. Acc.+15',}}
    Ready_MAB_feet = {name="Valorous Greaves", augments={'Pet: "Mag.Atk.Bns."+30','"Dbl.Atk."+2','Pet: INT+9','Pet: Accuracy+15 Pet: Rng. Acc.+15',}}

    Ready_MAcc_head = "Nyame Helm"
    Ready_MAcc_body = "Nyame Mail"
    Ready_MAcc_hands = "Nyame Gauntlets"
    Ready_MAcc_legs = "Nyame Flanchard"
    Ready_MAcc_feet = "Gleti's Boots"
    Ready_MAcc_back = {name="Artio's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: Haste+10','Pet: Magic dmg. taken-10%',}}

    Ready_DA_Axe = "Skullrender"
    Ready_DA_Axe2 = "Skullrender"
    Ready_DA_head = "Emicho Coronet"
    Ready_DA_body = "Ankusa Jackcoat +3"
--    Ready_DA_hands = "Emicho Gauntlets +1"
    Ready_DA_legs = "Emicho Hose"
    Ready_DA_feet ={ name="Valorous Greaves", augments={'Pet: "Dbl. Atk."+5',}}

    Pet_Melee_head = "Tali'ah Turban +2"
    Pet_Melee_body = "Ankusa Jackcoat +3"
    Pet_Melee_hands = "Emicho Gauntlets"
    Pet_Melee_legs = "Ankusa Trousers +3"
    Pet_Melee_feet = {name="Valorous Greaves", augments={'Pet: "Dbl. Atk."+5',}}

    Hybrid_head = {name="Valorous Mask", augments={'Pet: Accuracy+30',' Pet: Rng. Acc.+30','"Dbl.Att."+1','Pet: STR+8,'}}
    Hybrid_body = Pet_PDT_body
    Hybrid_hands = Pet_PDT_hands
    Hybrid_legs = "Gleti's Breeches"
    Hybrid_feet = "Gleti's Tights"

    DW_head = "Malignance Chapeau"
    DW_body ="Nyame Mail"
    DW_hands = "Malignance Gloves"
    DW_legs = "Malignance Tights"
    DW_feet = "Malignance Boots"
    DW_back = {name="Artio's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','"Dual Wield"+10','Pet: Phys. dmg. taken-10%',}}

    MAB_head = "Nyame Helm"
    MAB_body = "Nyame Mail"
    MAB_hands = "Nyame Gauntlets"
    MAB_legs = "Nyame Flanchard"
    MAB_feet = "Nyame Sollerets"

    FC_body = "Sacro Breastplate"
    FC_hands = "Leyline Gloves"


    MAcc_head = "Malignance Chapeau"
    MAcc_body = "Nyame Mail"
    MAcc_hands = "Malignance Gloves"
    MAcc_legs = "Malignance Tights"
    MAcc_feet = "Malignance Boots"

 --   PDT_back = {name="Artio's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity-10','Phys. dmg. taken-10%',}}

    MEva_head = "Malignance Chapeau"
    MEva_body = "Nyame Mail"
    MEva_hands = "Malignance Gloves"
    MEva_legs = "Malignance Tights"
    MEva_feet = "Malignance Boots"

--    MEva_back = {name="Artio's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Fast Cast +10','Occ. inc. resist. to stat. ailments+10',}}
--Probably need to make this one add to fast cast

    CB_head = {name="Acro Helm", augments={'Call Beast" ability delay -5',}}
    CB_body = "Mirke Wardecors"
    CB_hands = "Ankusa Gloves +3"
    CB_legs = {name="Acro Breeches", augments={'Call Beast" ability delay -5',}}
    CB_feet = "Adaman Sollerets"

--    Cure_Potency_back = {name="Artio's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Spell interruption rate down-10%',}}

    STP_back = {name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}


    STR_WS_back = {name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    Primal_back = {name="Artio's Mantle", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','Weapon skill damage +10%',}}

    STP_head = {name="Valorous Mask", augments={'Attack+27','"Store TP"+8','Accuracy+1',}}
    STP_feet = {name="Valorous Greaves", augments={'Accuracy+23 Attack+23','"Store TP"+8','AGI+4',}}

    Regain_head = "Gleti's Mask"
    Regain_body = "Gleti's Cuirass"
    Regain_hands = "Gleti's Gauntlets"
    Regain_legs = "Gleti's Breeches"
    Regain_feet = "Gleti's Boots"

    Enmity_plus_feet = "Heyoka Leggings"
 --   Enmity_plus_back = {name="Artio's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Enmity+10','Phys. dmg. taken-10%',}}

    sets.Enmity = {ammo="Paeapua",
        head="Halitus Helm",
		neck="Unmoving Collar +1",
		ear1="Trux Earring",
		ear2="Cryptic Earring",
        body="Emet Harness +1",
		hands="Macabre Gauntlets +1",
		ring1="Supershear Ring",
		ring2="Eihwaz Ring",
--        back=Enmity_plus_back,
		waist="Trance Belt",
		legs="Zoar Subligar +1",
        feet=Enmity_plus_feet}

    ---------------------
    -- JA PRECAST SETS --
    ---------------------
    -- Most gearsets are divided into 3 categories:
    -- 1. Default - No Axe swaps involved.
    -- 2. NE (Not engaged) - Axe/Shield swap included, for use with Pet Only mode.
    -- 3. NEDW (Not engaged; Dual-wield) - Axe swaps included, for use with Pet Only mode.

    sets.precast.JA.Familiar = {legs="Ankusa Trousers +3"}
    sets.precast.JA['Call Beast'] = {head=CB_head,
        body=CB_body,hands=CB_hands,
        legs=CB_legs,feet=CB_feet}
    sets.precast.JA['Bestial Loyalty'] = sets.precast.JA['Call Beast']

    sets.precast.JA.Tame = {
		head="Totemic Helm +3",
--		ear1="Tamer's Earring",
--		legs="Stout Kecks"
		}

    sets.precast.JA.Spur = {back="Artio's Mantle",feet="Nukumi Ocreae +2"}
    sets.precast.JA.SpurNE = set_combine(sets.precast.JA.Spur, {main="Skullrender"})
    sets.precast.JA.SpurNEDW = set_combine(sets.precast.JA.Spur, {main="Skullrender",sub="Skullrender"})

    sets.precast.JA['Feral Howl'] = {
		ammo="Pemphredo Tathlum",
        head=MAcc_head,neck="Beastmaster Collar +1",
		ear1="Hermetic Earring",
		ear2="Dignitary's Earring",
        body="Ankusa Jackcoat +3",
		hands=MAcc_hands,
		ring1="Rahab Ring",
		ring2="Sangoma Ring",
        back=Primal_back,
		waist="Eschan Stone",
		legs=MAcc_legs,
		feet=MAcc_feet
		}
		
    sets.precast.JA['Feral Howl'] = set_combine(sets.Enmity, {body="Ankusa Jackcoat +3"})

    sets.precast.JA['Killer Instinct'] = set_combine(sets.Enmity, {head="Ankusa Helm +3"})

    sets.precast.JA.Reward = {
        head="Khimaira Bonnet",
		neck="Aife's Medal",
		ear1="Lifestorm Earring",
		ear2="Influx earring",
        body="Totemic Jackcoat +3",
		hands="Malignance Gloves",
		ring1="Stikini Ring +1",
		ring2="Metamorph Ring +1",
--        back=Reward_back,
		waist="Engraved Belt",
		legs="Ankusa Trousers +3",
		feet="Ankusa Gaiters +3"
		}
		
    sets.precast.JA.RewardNE = set_combine(sets.precast.JA.Reward, {
		main=Reward_Axe,
--		sub="Matamata Shield +1"
		})
    sets.precast.JA.RewardNEDW = set_combine(sets.precast.JA.RewardNE, {sub=Reward_Axe2})

    sets.precast.JA.Charm = {
		ammo="Voluspa Tathlum",
        head="Totemic Helm +3",
		neck="Unmoving Collar +1",
--		ear1="Enchanter's Earring",
		ear2="Enchanter's Earring +1",
        body="Ankusa Jackcoat +3",
		hands="Ankusa Gloves +3",
		ring1="Dawnsoul Ring",
		ring2="Dawnsoul Ring",
        back=Primal_back,
--		waist="Aristo Belt",
		legs="Ankusa Trousers +3",
		feet="Ankusa Gaiters +3"
		}

    ---------------------------
    -- PET SIC & READY MOVES --
    ---------------------------

    sets.ReadyRecast = {legs="Gleti's Breeches"}
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +2"}
    sets.midcast.Pet.Neutral = {head=Ready_Atk_head}
    sets.midcast.Pet.Favorable = {head="Nukumi Cabasset +2"}

    sets.midcast.Pet.Normal = {
		ammo="Hesperiidae",
        neck="Shulmanu Collar",
		ear1="Domesticator's Earring",
		ear2="Hija Earring",
        body=Ready_Atk_body,
		hands=Ready_Atk_hands,
		ring1="Varar Ring +1",
		ring2="Cath Palug Ring",
        back=DW_back,
		waist="Klouskap Sash",
		legs=Ready_Atk_legs,
		feet=Ready_Atk_feet}

 --   sets.midcast.Pet.MedAcc = set_combine(sets.midcast.Pet.Normal, {
 --     ear2="Enmerkar Earring",
 --       body=Ready_Acc_body,
 --       back=DW_back,waist="Incarnation Sash",legs=Ready_Acc_legs})

	sets.midcast.Pet.HighBuff = set_combine(sets.midcast.Pet.Normal, {
		ear1="Ferine Earring",ear2="Enmerkar Earring",
		body=Ready_Acc_body,
		back=DW_back,waist="Klouskap Sash",legs=Ready_Acc_legs,feet=Ready_Acc_feet})

--    sets.midcast.Pet.MaxAcc = set_combine(sets.midcast.Pet.Normal, {ammo="Voluspa Tathlum",
 --       head="Gleti's Mask",neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Kyrene's Earring",
 --       body="Heyoka Harness",hands="Gleti's Gauntlets",
 --       back=DW_back,waist="Klouskap Sash",legs="Heyoka Subligar",feet="Gleti's Boots"})

    sets.midcast.Pet.MagicAtkReady = {}

    sets.midcast.Pet.MagicAtkReady.Normal = {ammo="Voluspa Tathlum",
        head=Ready_MAB_head,
		neck="Adad Amulet",
		ear2="Nukumi Earring +1",
		ear1="Hija Earring",
        body=Ready_MAB_body,
		hands=Ready_MAB_hands,
		ring1="Tali'ah Ring",
		ring2="Cath Palug Ring",
        back="Argochampsa Mantle",
		waist="Incarnation Sash",
		legs=Ready_MAB_legs,feet=Ready_MAB_feet}

    sets.midcast.Pet.MagicAccReady = set_combine(sets.midcast.Pet.Normal, {
		ammo="Voluspa Tathlum",
        head=Ready_MAcc_head,
		neck="Beastmaster Collar +1",
		ear1="Alabaster Earring",
		ear2="Nukumi Earring +1",
        body=Ready_MAcc_body,
		hands=Ready_MAcc_hands,
		ring1="Tali'ah Ring",
		ring2="Murky Ring",
		waist="Incarnation Sash",
        back=Ready_MAcc_back,
		legs=Ready_MAcc_legs,
		feet=Ready_MAcc_feet})

    sets.midcast.Pet.MultiStrike = set_combine(sets.midcast.Pet.Normal, {
		ammo="Hesperiidae",
		head={ name="Emicho Coronet", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
		body={ name="Valorous Mail", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: STR+6','Pet: Accuracy+12 Pet: Rng. Acc.+12',}},
		hands="Nukumi Manoplas +2",
		legs={ name="Emicho Hose", augments={'Pet: Accuracy+15','Pet: Attack+15','Pet: "Dbl. Atk."+3',}},
		feet={ name="Valorous Greaves", augments={'Pet: "Dbl. Atk."+5',}},
		neck={ name="Bst. Collar +1", augments={'Path: A',}},
		waist="Incarnation Sash",
		left_ear="Sroda Earring",
		right_ear={ name="Nukumi Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Pet: "Dbl. Atk."+6',}},
		left_ring="Tali'ah Ring",
		right_ring="C. Palug Ring",
		back=DW_back,})

    sets.midcast.Pet.Buff = set_combine(sets.midcast.Pet.TPBonus, {
 --       body="Emicho Haubert +1"
 })

    --------------------------------------
    -- SINGLE WIELD PET-ONLY READY SETS --
    --------------------------------------

    -- Physical Ready Attacks w/o TP Modifier for Damage (ex. Sickle Slash, Whirl Claws, Swooping Frenzy, etc.)
    sets.midcast.Pet.ReadyNE = {}
    sets.midcast.Pet.ReadyNE.Normal = set_combine(sets.midcast.Pet.Normal, {main=Ready_Atk_Axe})
--    sets.midcast.Pet.ReadyNE.MedAcc = set_combine(sets.midcast.Pet.MedAcc, {main=Ready_Atk_Axe})
--    sets.midcast.Pet.ReadyNE.HighAcc = set_combine(sets.midcast.Pet.HighAcc, {main=Ready_Atk_Axe})
--    sets.midcast.Pet.ReadyNE.MaxAcc = set_combine(sets.midcast.Pet.MaxAcc, {main=Ready_Acc_Axe})

    -- Physical TP Bonus Ready Attacks (ex. Razor Fang, Tegmina Buffet, Tail Blow, Recoil Dive, etc.)
    sets.midcast.Pet.ReadyNE.TPBonus = {}
    sets.midcast.Pet.ReadyNE.TPBonus.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_TPBonus_Axe})
--    sets.midcast.Pet.ReadyNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_TPBonus_Axe})
--    sets.midcast.Pet.ReadyNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_TPBonus_Axe})
 --   sets.midcast.Pet.ReadyNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe})

    -- Multihit Ready Attacks w/o TP Modifier for Damage (Pentapeck, Chomp Rush)
    sets.midcast.Pet.MultiStrikeNE = set_combine(sets.midcast.Pet.MultiStrike, {main=Ready_Atk_Axe2})

    -- Multihit TP Bonus Ready Attacks (Sweeping Gouge, Tickling Tendrils, Pecking Flurry, Wing Slap)
    sets.midcast.Pet.MultiStrikeNE.TPBonus = set_combine(sets.midcast.Pet.MultiStrike, {main=Ready_Atk_TPBonus_Axe})

    -- Magical Ready Attacks w/o TP Modifier for Damage (ex. Molting Plumage, Venom, Stink Bomb, etc.)
    sets.midcast.Pet.MagicAtkReadyNE = {}
    sets.midcast.Pet.MagicAtkReadyNE.Normal = set_combine(sets.midcast.Pet.MagicAtkReady.Normal, {main=Ready_MAB_Axe})

    -- Magical TP Bonus Ready Attacks (ex. Fireball, Cursed Sphere, Corrosive Ooze, etc.)
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus = {}
    sets.midcast.Pet.MagicAtkReadyNE.TPBonus.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_TPBonus_Axe})

    -- Magical Ready Enfeebles (ex. Roar, Sheep Song, Infrasonics, etc.)
    sets.midcast.Pet.MagicAccReadyNE = set_combine(sets.midcast.Pet.MagicAccReady, {main="Aymur"})

    -- Pet Buffs/Cures (Bubble Curtain, Scissor Guard, Secretion, Rage, Rhino Guard, Zealous Snort, Wild Carrot)
    sets.midcast.Pet.BuffNE = set_combine(sets.midcast.Pet.Buff, {main=Ready_Atk_TPBonus_Axe})

    -- Axe Swaps for when Pet TP is above a certain value.
    sets.UnleashAtkAxeShield = {}
    sets.UnleashAtkAxeShield.Normal = {main=Ready_Atk_Axe}
--    sets.UnleashAtkAxeShield.MedAcc = {main=Ready_Atk_Axe}
--    sets.UnleashAtkAxeShield.HighAcc = {main=Ready_Atk_Axe}
--    sets.UnleashMultiStrikeAxeShield = {main=Ready_DA_Axe}

    sets.UnleashMABAxeShield = {}
    sets.UnleashMABAxeShield.Normal = {main=Ready_MAB_Axe}
--    sets.UnleashMABAxeShield.MedAcc = {main=Ready_MAB_Axe}
--    sets.UnleashMABAxeShield.HighAcc = {main=Ready_MAB_Axe}

    ------------------------------------
    -- DUAL WIELD PET-ONLY READY SETS --
    ------------------------------------

    -- DW Axe Swaps for Physical Ready Attacks w/o TP Modifier for Damage (ex. Sickle Slash, Whirl Claws, Swooping Frenzy, etc.)
    sets.midcast.Pet.ReadyDWNE = {}
    sets.midcast.Pet.ReadyDWNE.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2})
--    sets.midcast.Pet.ReadyDWNE.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_Axe,sub=Ready_Acc_Axe})
--    sets.midcast.Pet.ReadyDWNE.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_Axe,sub=Ready_Acc_Axe})
--    sets.midcast.Pet.ReadyDWNE.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe,sub=Ready_Acc_Axe2})

    -- DW Axe Swaps for Physical TP Bonus Ready Attacks (ex. Razor Fang, Tegmina Buffet, Tail Blow, Recoil Dive, etc.)
    sets.midcast.Pet.ReadyDWNE.TPBonus = {}
    sets.midcast.Pet.ReadyDWNE.TPBonus.Normal = set_combine(sets.midcast.Pet.ReadyNE.Normal, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Atk_Axe2})
--    sets.midcast.Pet.ReadyDWNE.TPBonus.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Acc_Axe2})
--    sets.midcast.Pet.ReadyDWNE.TPBonus.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Acc_Axe2})
--    sets.midcast.Pet.ReadyDWNE.TPBonus.MaxAcc = set_combine(sets.midcast.Pet.ReadyNE.MaxAcc, {main=Ready_Acc_Axe,sub=Ready_Acc_Axe2})

    -- DW Axe Swaps for Multihit Ready Attacks w/o TP Modifier for Damage (Pentapeck, Chomp Rush)
    sets.midcast.Pet.MultiStrikeDWNE = set_combine(sets.midcast.Pet.MultiStrikeNE, {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2})

    -- DW Axe Swaps for Multihit TP Bonus Ready Attacks (Sweeping Gouge, Tickling Tendrils, Pecking Flurry, Wing Slap)
    sets.midcast.Pet.MultiStrikeDWNE.TPBonus = set_combine(sets.midcast.Pet.MultiStrikeNE, {main=Ready_Atk_TPBonus_Axe,sub=Ready_Atk_TPBonus_Axe2})

    -- DW Axe Swaps for Magical Ready Attacks w/o TP Modifier for Damage (ex. Molting Plumage, Stink Bomb, Venom, etc.)
    sets.midcast.Pet.MagicAtkReadyDWNE = {}
    sets.midcast.Pet.MagicAtkReadyDWNE.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2})

    -- DW Axe Swaps for Magical TP Bonus Ready Attacks (ex. Fireball, Cursed Sphere, Corrosive Ooze, etc.)
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus = {}
    sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus.Normal = set_combine(sets.midcast.Pet.MagicAtkReadyNE.Normal, {main=Ready_MAB_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe2})


    -- DW Axe Swaps for Magical Ready Enfeebles (ex. Roar, Sheep Song, Infrasonics, etc.)
    sets.midcast.Pet.MagicAccReadyDWNE = set_combine(sets.midcast.Pet.MagicAccReadyNE, {main="Aymur",sub="Agwu's Axe"})

    -- DW Axe Swaps for Pet Buffs/Cures (Bubble Curtain, Scissor Guard, Secretion, Rage, Rhino Guard, Zealous Snort, Wild Carrot)
    sets.midcast.Pet.BuffDWNE = set_combine(sets.midcast.Pet.BuffNE, {main=Ready_Atk_TPBonus_Axe,sub=Ready_MAB_TPBonus_Axe})

    -- Axe Swaps for when Pet TP is above a certain value.
    sets.UnleashAtkAxes = {}
    sets.UnleashAtkAxes.Normal = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
--    sets.UnleashAtkAxes.MedAcc = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
--    sets.UnleashAtkAxes.HighAcc = {main=Ready_Atk_Axe,sub=Ready_Atk_Axe2}
--    sets.UnleashMultiStrikeAxes = {main=Ready_DA_Axe,sub=Ready_DA_Axe2}

    sets.UnleashMABAxes = {}
    sets.UnleashMABAxes.Normal = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}
--    sets.UnleashMABAxes.MedAcc = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}
--    sets.UnleashMABAxes.HighAcc = {main=Ready_MAB_Axe,sub=Ready_MAB_Axe2}

    ---------------
    -- IDLE SETS --
    ---------------

    sets.idle = {ammo="Staunch Tathlum",
        head="Gleti's Mask",
		neck="Bathy Choker +1",
		ear1="Tuisto Earring",ear2="Odnowa Earring +1",
        body=Regain_body,
		hands=Regain_hands,
		ring1="Paguroidea Ring",
		ring2="Warden's Ring",
        back=Pet_Regen_back,
		waist="Platinum Moogle Belt",
		legs=Regain_legs,
		feet="Skadi's Jambeaux +1"}

    sets.idle.Refresh = set_combine(sets.idle, {
--		head="Null Masque",
		body="Jumalik Mail",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1"})
		
    sets.idle.Reraise = set_combine(sets.idle, {
--		head="Twilight Helm",
--		body="Twilight Mail"
})

    sets.idle.Pet = set_combine(sets.idle, {back=Pet_Regen_back})

    sets.idle.PetRegen = set_combine(sets.idle.Pet, {
--		neck="Empath Necklace",
--		feet=Pet_Regen_feet
})

    sets.idle.Pet.Engaged = {
		ammo="Hesperiidae",
        head=Pet_Melee_head,
		neck="Shulmanu Collar",
		ear1="Domesticator's Earring",
		ear2="Enmerkar Earring",
        body=Pet_Melee_body,
		hands=Pet_Melee_hands,
		ring1="Varar Ring",
		ring2="Varar Ring +1",
        back=DW_back,
		waist="Incarnation Sash",
		legs=Pet_Melee_legs,
		feet=Pet_Melee_feet}

 --   sets.idle.Pet.Engaged.PetSBMNK = set_combine(sets.idle.Pet.Engaged, {
 --       ear1="Gelai Earring",
--		body=Pet_SB_body,
  --      waist="Isa Belt"})

 --   sets.idle.Pet.Engaged.PetSBNonMNK = set_combine(sets.idle.Pet.Engaged, {
 --       ear1="Gelai Earring",
--		body=Pet_SB_body,
 --       waist="Isa Belt"})

		sets.idle.Pet.Engaged.PetSTP = set_combine(sets.idle.Pet.Engaged, {
			ring1="Varar Ring",
			ring2="Varar Ring +1"
			})

    sets.resting = {}

    ------------------
    -- DEFENSE SETS --
    ------------------

    -- Pet PDT and MDT sets:
    sets.defense.PetPDT = {
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Enmerkar Earring",
		ear2="Handler's Earring +1",
        body="Totemic Jackcoat +3",
		hands="Gleti's Gauntlets",
		ring1="Cath Palug ring",
		ring2="Varar Ring +1",
        back=DW_back,
		waist="Isa Belt",
		legs="Nukumi Quijotes +3",
		feet="Gleti's Boots"}

    sets.defense.PetMDT = {
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Enmerkar Earring",
		ear2="Nukumi Earring +1",
        body="Totemic Jackcoat +3",
		hands="Gleti's Gauntlets",
		ring1="Cath Palug ring",
		ring2="Varar Ring +1",
        back=Primal_back,
		waist="Isa Belt",
		legs="Nukumi Quijotes +3",
		feet="Gleti's Boots"}

    -- Master PDT and MDT sets:
    sets.defense.PDT = {
		ammo="Hesperiidae",
        head="Gleti's Mask",
		neck="Beastmaster Collar +1",
		ear1="Alabaster Earring",
		ear2="Hypaspist Earring",
        body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Murky Ring",
		ring2="Fortified Ring",
        back="Shadow Mantle",
		waist="Engraved Belt",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"}

    sets.defense.Reraise = set_combine(sets.defense.PDT, {
--		head="Twilight Helm",
--		body="Twilight Mail"
		})

    sets.defense.HybridPDT = {
		ammo="Staunch Tathlum",
        head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Enmerkar Earring",
		ear2="Nukumi Earring +1",
		body="Nyame Mail",
		hands=Pet_PDT_hands,
		ring1="Cath Palug ring",
		ring2="Varar Ring +1",
		back=Primal_back,
		waist="Isa Belt",
		legs=Pet_PDT_legs,
		feet=Pet_PDT_feet
		}

    sets.defense.MDT = {
		ammo="Vanir Battery",
        head=MEva_head,
		neck="Inquisitor Bead Necklace",
		ear1="Eabani Earring",
		ear2="Nukumi Earring +1",
        body="Nyame Mail",
		hands=MEva_hands,
		ring1="Shadow Ring",
		ring2="Varar Ring +1",
        back="Engulfer Cape +1",
		waist="Asklepian Belt",
		legs=MEva_legs,
		feet=MEva_feet}

    sets.defense.MEva = {ammo="Staunch Tathlum",
		head=MEva_head,neck="Warder's Charm +1",
		ear1="Hearty Earring",
		ear2="Eabani Earring",
		body="Nyame Mail",
		hands=MEva_hands,
		ring1="Vengeful Ring",
		ring2="Purity Ring",
		back=Pet_Regen_back,
		waist="Engraved Belt",
		legs=MEva_legs,
		feet=MEva_feet
		}

    sets.defense.Killer = {    
		ammo="Staunch Tathlum",
		head="Ankusa Helm +3",
		body="Nukumi Gausape +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Beast Earring",
		right_ear="Bird Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Murky Ring",
		back=Ready_MACC_back,
		}

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -------------------------------------------------------
    -- Single-wield Pet Only Mode Idle/Defense Axe Swaps --
    -------------------------------------------------------

    sets.idle.NE = {
		main="Aymur",
		sub="Adapa Shield",
		ammo="Staunch Tathlum",
        head=Regain_head,
		neck="Bathy Choker +1",
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
        body=Regain_body,
		hands=Regain_hands,
		ring1="Paguroidea Ring",
		ring2="Warden's Ring",
        back=STR_WS_back,
		waist="Platinum Moogle Belt",
		legs=Regain_legs,
		feet="Skadi's Jambeaux +1"}

    sets.idle.NE.PetEngaged = {
		main=Pet_TP_AxeMain,
		sub="Adapa Shield",
		ammo="Hesperiidae",
        head=Pet_Melee_head,
		neck="Shulmanu Collar",
		ear1="Domesticator's Earring",
		ear2="Enmerkar Earring",
        body=Pet_Melee_body,
		hands=Pet_Melee_hands,
		ring1="Varar Ring",
		ring2="Varar Ring +1",
        back=DW_back,
		waist="Incarnation Sash",
		legs=Pet_Melee_legs,
		feet=Pet_Melee_feet}

    sets.idle.NE.PetRegen = {main=Pet_Regen_AxeMain,sub="Adapa Shield",
--        neck="Empath Necklace",
--        feet=Pet_Regen_feet
}

    sets.defense.NE = {}

    sets.defense.NE.PDT = {
		main=Pet_DT_AxeMain,
		sub="Adapa Shield",
		ammo="Hesperiidae",
        head="Gleti's Mask",
		neck="Beastmaster Collar +1",
		ear1="Alabaster Earring",
		ear2="Hypaspist Earring",
        body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Murky Ring",
		ring2="Fortified Ring",
        back="Shadow Mantle",
		waist="Engraved Belt",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"}

    sets.defense.NE.MDT = {		
		main=Pet_DT_AxeMain,
		sub="Beatific Shield +1",
		ammo="Vanir Battery",
        head=MEva_head,
		neck="Inquisitor Bead Necklace",
		ear1="Eabani Earring",
		ear2="Nukumi Earring +1",
        body="Nyame Mail",
		hands=MEva_hands,
		ring1="Shadow Ring",
		ring2="Varar Ring +1",
        back="Engulfer Cape +1",
		waist="Asklepian Belt",
		legs=MEva_legs,
		feet=MEva_feet}

    sets.defense.NE.MEva = {
		main=Pet_DT_AxeMain,
		sub="Beatific Shield +1",
		ammo="Staunch Tathlum",
        head=MEva_head,
		neck="Warder's Charm +1",
		ear1="Hearty Earring",
		ear2="Eabani Earring",
        body="Nyame Mail",
		hands=MEva_hands,
		ring1="Vengeful Ring",
		ring2="Purity Ring",
        Pet_Regen_back,
		waist="Engraved Belt",
		legs=MEva_legs,
		feet=MEva_feet}

    sets.defense.NE.Killer = {
		main="Aymur",
		sub="Kaidate",		
		ammo="Staunch Tathlum",
		head="Ankusa Helm +3",
		body="Nukumi Gausape +2",
		hands="Malignance Gloves",
		legs="Totemic trousers +3",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Beast Earring",
		right_ear="Bird Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Murky Ring",
		back=Ready_MACC_back,
		}

    sets.defense.NE.PetPDT = {		
		main=Pet_DT_AxeMain,
		sub="Adapa Shield",
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Beastmaster Collar +1",
		ear1="Enmerkar Earring",
		ear2="Handler's Earring +1",
        body="Totemic Jackcoat +3",
		hands="Gleti's Gauntlets",
		ring1="Murky Ring",
		ring2="Varar Ring +1",
        back=DW_back,
		waist="Isa Belt",
		legs="Nukumi quijotes +3",
		feet="Ankusa Gaiters +3"}

    sets.defense.NE.PetMDT = {main=Pet_DT_AxeMain,sub="Beatific Shield +1",		
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Enmerkar Earring",
		ear2="Nukumi Earring +1",
        body="Totemic Jackcoat +3",
		hands="Gleti's Gauntlets",
		ring1="Cath Palug ring",
		ring2="Varar Ring +1",
        back=Primal_back,
		waist="Isa Belt",
		legs="Nukumi Quijotes +3",
		feet="Gleti's Boots"}

    -----------------------------------------------------
    -- Dual-wield Pet Only Mode Idle/Defense Axe Swaps --
    -----------------------------------------------------

    sets.idle.DWNE = {
		main=Pet_DT_AxeMain,sub=Pet_DT_AxeSub,
		ammo="Staunch Tathlum",
        head=Regain_head,
		neck="Bathy Choker +1",
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
        body=Regain_body,
		hands=Regain_hands,
		ring1="Paguroidea Ring",
		ring2="Warden's Ring",
        back=Pet_Regen_back,
		waist="Platinum Moogle Belt",
		legs=Regain_legs,
		feet="Skadi's Jambeaux +1"}

    sets.idle.DWNE.PetEngaged = {
		main=Pet_TP_AxeMain,
		sub=Pet_TP_AxeSub,
		ammo="Hesperiidae",
        head=Pet_Melee_head,
		neck="Shulmanu Collar",
		ear1="Domesticator's Earring",
		ear2="Enmerkar Earring",
        body=Pet_Melee_body,
		hands=Pet_Melee_hands,
		ring1="Varar Ring",
		ring2="Varar Ring +1",
        back=DW_back,
		waist="Incarnation Sash",
		legs=Pet_Melee_legs,
		feet=Pet_Melee_feet}

--    sets.idle.DWNE.PetRegen = {main=Pet_Regen_AxeMain,sub=Pet_Regen_AxeSub,
--        neck="Empath Necklace",
--        feet=Pet_Regen_feet
--}

    sets.defense.DWNE = {}

    sets.defense.DWNE.PDT = {
		main=Pet_DT_AxeMain,
		sub=Pet_DT_AxeSub,
		ammo="Crepuscular Pebble",
        head="Gleti's Mask",
		neck="Loricate Torque +1",
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
        body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Fortified Ring",
		ring2="Warden's Ring",
        back="Shadow Mantle",
		waist="Platinum Moogle Belt",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"}

    sets.defense.DWNE.MDT = {
		main=Pet_DT_AxeMain,
--		sub="Purgation",
		ammo="Vanir Battery",
        head=MEva_head,
		neck="Inquisitor Bead Necklace",
		ear1="Eabani Earring",
		ear2="Etiolation Earring",
        body="Nyame Mail",
		hands=MEva_hands,
		ring1="Shadow Ring",
		ring2="Purity Ring",
        back="Engulfer Cape +1",
		waist="Asklepian Belt",
		legs=MEva_legs,
		feet=MEva_feet}

    sets.defense.DWNE.MEva = {
		main=Pet_DT_AxeMain,
		sub=Pet_DT_AxeSub,
		ammo="Staunch Tathlum",
        head=MEva_head,
		neck="Warder's Charm +1",
		ear1="Hearty Earring",
		ear2="Eabani Earring",
        body="Nyame Mail",
		hands=MEva_hands,
		ring1="Vengeful Ring",
		ring2="Purity Ring",
        Pet_Regen_back,
		waist="Engraved Belt",
		legs=MEva_legs,
		feet=MEva_feet}

    sets.defense.DWNE.Killer = {		
		ammo="Staunch Tathlum",
		head="Ankusa Helm +3",
		body="Nukumi Gausape +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Plat. Mog. Belt",
		left_ear="Beast Earring",
		right_ear="Bird Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Murky Ring",
		back=Ready_MACC_back,}

    sets.defense.DWNE.PetPDT = {
		main=Pet_DT_AxeMain,
		sub=Pet_DT_AxeSub,
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Enmerkar Earring",
		ear2="Nukumi Earring +1",
        body=Pet_PDT_body,
		hands=Pet_PDT_hands,
		ring1="Cath Palug ring",
		ring2="Varar Ring",
        back=DW_back,
		waist="Isa Belt",
		legs=Pet_DT_legs,
		feet=Pet_DT_feet}

    sets.defense.DWNE.PetMDT = {
		main=Pet_DT_AxeMain,
		sub=Pet_DT_AxeSub,
		ammo="Hesperiidae",
        head="Anwig Salade",
		neck="Shepherd's Chain",
		ear1="Enmerkar Earring",
		ear2="Nukumi Earring +1",
        body="Totemic Jackcoat +3",
		hands=Pet_MDT_hands,
		ring1="Cath Palug ring",
		ring2="Varar Ring +1",
        back=Primal_back,
		waist="Isa Belt",
		legs=Pet_MDT_legs,
		feet=Pet_MDT_feet}

    --------------------
    -- FAST CAST SETS --
    --------------------

    sets.precast.FC = {
		ammo="Sapience Orb",
        neck="Orunmila's Torque",
		ear1="Loquacious Earring",
		ear2="Enchanter's Earring +1",
        hands=FC_hands,
--		back=MEva_back
		ring1="Prolix Ring",
		ring2="Rahab Ring"}

    sets.precast.FCNE = set_combine(sets.precast.FC, {main="Shukuyu's Scythe",
--		sub="Vivid Strap +1"
	})
    sets.precast.FC["Utsusemi: Ichi"] = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
    sets.precast.FC["Utsusemi: Ni"] = set_combine(sets.precast.FC, {neck="Magoraga Beads",ring1="Lebeche Ring"})

    ------------------
    -- MIDCAST SETS --
    ------------------

    sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		body=FC_body,
        neck="Orunmila's Torque",
		ear1="Loquacious Earring",
		ear2="Enchanter's Earring +1",
		hands=FC_hands,
--		back=MEva_back
		ring1="Prolix Ring",
		ring2="Rahab Ring"
		}

    sets.midcast.Cure = {
        ear1="Beatific Earring",
		ear2="Mendicant's Earring",
        body="Jumalik Mail",
		ring1="Menelaus's Ring",
		ring2="Asklepian Ring",
		waist="Gishdubar Sash"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Stoneskin = {  
        neck="Stone Gorget",
		ear1="Earthcry Earring",
		ear2="Lifestorm Earring",
--        hands="Stone Mufflers",
        }

    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {
		neck="Malison Medallion",
        ring1="Ephedra Ring",
		ring2="Ephedra Ring",
		waist="Gishdubar Sash"})

    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring2="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
        head=MAcc_head,
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		ear2="Dignitary's Earring",
        body=MAcc_body,
		hands=MAcc_hands,
		ring1="Rahab Ring",
		ring2="Sangoma Ring",
        back=Primal_back,
		waist="Eschan Stone",
		legs=MAcc_legs,
		feet=MAcc_feet}

    sets.midcast['Elemental Magic'] = {
		ammo="Pemphredo Tathlum",
        head=MAB_head,
		neck="Baetyl Pendant",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
        body=MAB_body,
		hands=MAB_hands,
		ring1="Acumen Ring",
	--	ring2="Fenrir Ring +1",
        back=Primal_back,
		waist="Eschan Stone",
		legs=MAB_legs,
		feet=MAB_feet}

    sets.midcast.Flash = sets.Enmity

    --------------------------------------
    -- SINGLE-WIELD MASTER ENGAGED SETS --
    --------------------------------------

    sets.engaged = {
		ammo="Coiste Bodhar",
        head="Malignance Chapeau",
		neck="Beastmaster Collar +1",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
        body="Gleti's Cuirass",
		hands="Malignance Gloves",
		ring1="Gere Ring",
		ring2="Epona's Ring",
        back=STP_back,
		waist="Sailfi Belt +1",
		legs="Malignance tights",
		feet="Malignance Boots"}

    sets.engaged.Aftermath = {
		ammo="Aurgelmir Orb",
        head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Crepuscular Earring",
		ear2="Telos Earring",
        body="Nyame Mail",
		hands="Malignance Gloves",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
        back=STP_back,
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"}

    sets.engaged.Hybrid = {
		ammo="Staunch Tathlum",
        head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
        body="Gleti's Cuirass",
		hands="Malignance Gloves",
		ring1="Moonbeam Ring",
		ring2="Defending Ring",
        back=STP_back,
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"}

    sets.engaged.SubtleBlow = {
		main="Aymur",
		sub="Deliverance",
		ammo="Amar Cluster",
        head="Malignance Chapeau",
		neck="Bathy Choker +1",
		ear1="Sherida Earring",
		ear2="Odnowa Earring +1",
        body="Sacro Breastplate",
		hands="Malignance Gloves",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
        back=STP_back,
--		waist="Sarissaphoroi Belt",
		legs="Malignance Tights",
		feet="Malignance Boots"}


    ------------------------------------
    -- DUAL-WIELD MASTER ENGAGED SETS --
    ------------------------------------

    sets.engaged.DW = {		
		ammo="Coiste Bodhar",
        head="Malignance Chapeau",
		neck="Beastmaster Collar +1",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
        body="Gleti's Cuirass",
		hands="Malignance Gloves",
		ring1="Gere Ring",
		ring2="Epona's Ring",
        back=STP_back,
		waist="Sailfi Belt +1",
		legs="Malignance tights",
		feet="Malignance Boots"}

    sets.engaged.DW.Aftermath = {
		ammo="Aurgelmir Orb",
        head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Crepuscular Earring",
		ear2="Telos Earring",
        body="Nyame Mail",
		hands="Malignance Gloves",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
        back=STP_back,
		waist="Sailfi Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"}

--    sets.engaged.DW.MedAcc = {ammo="Coiste Bodhar",
 --       head=DW_head,neck="Shulmanu Collar",ear1="Suppanomimi",ear2="Eabani Earring",
--        body=DW_body,hands=DW_hands,ring1="Gere Ring",ring2="Epona's Ring",
--        back=DW_back,waist="Sailfi Belt +1",legs=DW_legs,feet=DW_feet}

	sets.engaged.DW.HighBuff = {ammo="Coiste Bodhar",
		head=DW_head,neck="Shulmanu Collar",ear1="Suppanomimi",ear2="Eabani Earring",
		body=DW_body,hands=DW_hands,ring1="Gere Ring",ring2="Epona's Ring",
        back=DW_back,waist="Kentarch Belt +1",legs=DW_legs,feet=DW_feet}

 --   sets.engaged.DW.MaxAcc = {ammo="Aurgelmir Orb",
 --       head="Totemic Helm +3",neck="Shulmanu Collar",ear1="Suppanomimi",ear2="Eabani Earring",
 --       body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
--        back=DW_back,waist="Kentarch Belt +1",legs="Totemic Trousers +3",feet=DW_feet}

    sets.engaged.DW.SubtleBlow = {		
		main="Aymur",
		sub="Deliverance",
		ammo="Amar Cluster",
        head="Malignance Chapeau",
		neck="Bathy Choker +1",
		ear1="Sherida Earring",
		ear2="Odnowa Earring +1",
        body="Sacro Breastplate",
		hands="Malignance Gloves",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
        back=STP_back,
--		waist="Sarissaphoroi Belt",
		legs="Malignance Tights",
		feet="Malignance Boots"}

--    sets.ExtraSubtleBlow = {ear1="Sherida Earring"}

--    sets.engaged.DW.KrakenClub = {ammo="Aurgelmir Orb",
--        head="Totemic Helm +3",neck="Shulmanu Collar",ear1="Suppanomimi",ear2="Eabani Earring",
--        body="Totemic Jackcoat +3",hands="Totemic Gloves +3",ring1="Ilabrat Ring",ring2="Regal Ring",
--        back=DW_back,waist="Sailfi Belt +1",legs="Totemic Trousers +3",feet=DW_feet}

    --------------------
    -- MASTER WS SETS --
    --------------------

    -- AXE WSs --
    sets.precast.WS = {
		ammo="Aurgelmir Orb",
        head="Gleti's Mask",
		neck="Shulmanu Collar",
		ear1="Moonshade Earring",
		ear2="Telos Earring",
        body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		ring1="Regal Ring",
		ring2="Epona's Ring",
        back=STR_WS_back,
		waist="Sailfi Belt +1",
		legs="Gleti's Breeches",
		feet="Gleti's Boots"
		}

    sets.precast.WS['Rampage'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Sroda Ring",
        back=STR_WS_back,waist="Fotia Belt",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Calamity'] = {ammo="Crepuscular Pebble",
        head="Ankusa Helm +3",neck="Beastmaster Collar +1",ear1="Moonshade Earring",ear2="Nukumi Earring +1",
        body="Nukumi Gausape +2",hands="Totemic Gloves +3",ring1="Sroda Ring",ring2="Epaminondas's ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Mistral Axe'] = {    
		ammo="Crepuscular Pebble",
		head="Ankusa Helm +3",
		body="Nukumi Gausape +2",
		hands="Totemic Gloves +3",
		legs="Nyame Flanchard",
		feet="Nukumi Ocreae +2",
		neck={ name="Bst. Collar +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear={ name="Nukumi Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Pet: "Dbl. Atk."+6',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back=STR_WS_back,
		}

    sets.precast.WS['Decimation'] = {ammo="Coiste Bodhar",
        head="Ankusa Helm +3",neck="Beastmaster Collar +1",ear1="Sherida Earring",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Sroda Ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}
   
    sets.precast.WS['Bora Axe'] = {ammo="Crepuscular Pebble",
        head="Ankusa Helm +3",neck="Beastmaster Collar +1",ear1="Lugra Earring +1",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Gere Ring",ring2="Epaminondas's Ring",
        back=STR_WS_back,waist="Kentarch Belt +1",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Ruinator'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Sroda Ring",
        back=STR_WS_back,waist="Fotia Belt",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Onslaught'] = {ammo="Crepuscular Pebble",
        head="Ankusa Helm +3",neck="Beastmaster Collar +1",ear1="Lugra Earring +1",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Epona's ring",ring2="Gere Ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Primal Rend'] = {ammo="Oshasha's Treatise",
        head=MAB_head,neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=MAB_body,hands=MAB_hands,ring1="Acumen Ring",ring2="Epaminondas's ring",
        back=Primal_back,waist="Orpheus's Sash",legs=MAB_legs,feet=MAB_feet}
		
	sets.precast.WS['Blitz'] = {ammo="Crepuscular Pebble",
        head="Ankusa Helm +3",neck="Beastmaster Collar +1",ear1="Moonshade Earring",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Totemic Gloves +3",ring1="Sroda Ring",ring2="Epaminondas's ring",
        back=STR_WS_back,waist="Sailfi Belt +1",legs=MAB_legs,feet="Nukumi Ocreae +2"}

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {back=Primal_back})

    -- DAGGER WSs --
    sets.precast.WS['Evisceration'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Nukumi Earring +1",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Sroda Ring",
        back=STR_WS_back,waist="Fotia Belt",legs="Gleti's Breeches",feet="Nukumi Ocreae +2"}

    sets.precast.WS['Aeolian Edge'] = {ammo="Pemphredo Tathlum",
        head=MAB_head,neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=MAB_body,hands=MAB_hands,ring1="Acumen Ring",ring2="Beithir ring",
        back=Primal_back,waist="Eschan Stone",legs=MAB_legs,feet=MAB_feet}

    sets.precast.WS['Exenterator'] = {ammo="Coiste Bodhar",
        head="Gleti's Mask",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Telos Earring",
        body="Gleti's Cuirass",hands="Gleti's Gauntlets",ring1="Gere Ring",ring2="Epona's Ring",
        back=STR_WS_back,waist="Fotia Belt",legs="Gleti's Breeches",feet="Gleti's Boots"}

    -- SWORD WSs --
    sets.precast.WS['Savage Blade'] = {    
		ammo="Crepuscular Pebble",
		head="Ankusa Helm +3",
		body="Nukumi Gausape +2",
		hands="Totemic Gloves +3",
		legs="Nyame Flanchard",
		feet="Nukumi Ocreae +2",
		neck={ name="Bst. Collar +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear={ name="Nukumi Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Pet: "Dbl. Atk."+6',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back=STR_WS_back,
		}




    ----------------
    -- OTHER SETS --
    ----------------

    --Precast Gear Sets for DNC subjob abilities:
    sets.precast.Waltz = {
        neck="Unmoving Collar +1",ear1="Handler's Earring +1",ear2="Enchanter's Earring +1",
        ring1="Asklepian Ring",
        legs="Dashing Subligar"}
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}

    --Misc Gear Sets

--    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.buff['Killer Instinct'] = {body="Nukumi Gausape +2"}
    sets.THGear = {ammo="Perfect Lucky Egg",waist="Chaac Belt"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" and not spell.interrupted then
        equip_ready_gear(spell)
        if not buffactive['Unleash'] then
            equip(sets.ReadyRecast)
        end

        eventArgs.handled = true
    end

    if spell.english == 'Reward' then
        RewardAmmo = ''
        if state.RewardMode.value == 'Theta' then
            RewardAmmo = 'Pet Food Theta'
        elseif state.RewardMode.value == 'Roborant' then
            RewardAmmo = 'Pet Roborant'
        else
            RewardAmmo = 'Pet Food Theta'
        end

        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip({ammo=RewardAmmo}, sets.precast.JA.RewardNEDW)
            else
                equip({ammo=RewardAmmo}, sets.precast.JA.RewardNE)
            end
        else
            equip({ammo=RewardAmmo}, sets.precast.JA.Reward)
        end
    end

    if enmity_plus_moves:contains(spell.english) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.EnmityNEDW)
            else
                equip(sets.EnmityNE)
            end
        else
            equip(sets.Enmity)
        end
    end

    if spell.english == 'Spur' then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.precast.JA.SpurNEDW)
            else
                equip(sets.precast.JA.SpurNE)
            end
        else
            equip(sets.precast.JA.Spur)
        end
    end

    if spell.english == 'Charm' then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.precast.JA.CharmNEDW)
            else
                equip(sets.precast.JA.CharmNE)
            end
        else
            equip(sets.precast.JA.Charm)
        end
    end

    if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        if spell.english == "Call Beast" and call_beast_cancel:contains(JugInfo) then
            add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
            return
        end
        equip({ammo=JugInfo})
    end

    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_precast(spell)
    end

    if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        handle_equipping_gear(player.status)
        return
    end

    if spell.type == 'CorsairRoll' or spell.english == "Double-Up" then
        equip(sets.precast.LuzafRing)
    end

    if spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song' then
        if state.AxeMode.value == 'PetOnly' then
            equip(sets.precast.FCNE)
        else
            equip(sets.precast.FC)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    --If Killer Instinct is active during WS (except for Primal/Cloudsplitter where Sacro Body is superior), equip Nukumi Gausape +2.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        if spell.english ~= "Primal Rend" and spell.english ~= "Cloudsplitter" then
            equip(sets.buff['Killer Instinct'])
        end
    end

    if spell.english == "Calamity" or spell.english == "Mistral Axe" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraWSDMG)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraWSDMG)
            end
        end
    end

    if spell.english == "Primal Rend" or spell.english == "Cloudsplitter" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraMAB)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraMAB)
            end
        end
    end

-- Equip Chaac Belt for TH+1 on common Subjob Abilities or Spells.
    if abilities_to_check:contains(spell.english) and state.TreasureMode.value == 'Tag' then
        equip(sets.THGear)
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        equip_ready_gear(spell)
        eventArgs.handled = true
    end

    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_aftercast(spell)
    end

    if player.status ~= 'Idle' and state.AxeMode.value == 'PetOnly' and spell.type ~= "Monster" then
        pet_only_equip_handling()
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        eventArgs.handled = true
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
    pet_only_equip_handling()
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle and melee sets.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if state.AxeMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if state.DefenseMode.value == "Physical" then
                idleSet = set_combine(idleSet, sets.defense.DWNE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                idleSet = set_combine(idleSet, sets.defense.DWNE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    idleSet = set_combine(idleSet, sets.idle.DWNE.PetEngaged)
                else
                    idleSet = set_combine(idleSet, sets.idle.DWNE)
                end
            end
        else
            if state.DefenseMode.value == "Physical" then
                idleSet = set_combine(idleSet, sets.defense.NE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                idleSet = set_combine(idleSet, sets.defense.NE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    idleSet = set_combine(idleSet, sets.idle.NE.PetEngaged)
                else
                    idleSet = set_combine(idleSet, sets.idle.NE)
                end
            end
        end
    end

    idleSet = apply_kiting(idleSet)
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.AxeMode.value ~= 'PetOnly' and state.DefenseMode.value == "None" then
        if player.equipment.main == 'Farsha' then
            meleeSet = set_combine(meleeSet, sets.engaged.Farsha)
        elseif player.equipment.sub == 'Kraken Club' then
            meleeSet = set_combine(meleeSet, sets.engaged.DW.KrakenClub)
        elseif state.HybridMode.value == 'SubtleBlow' then
            if player.sub_job == 'NIN' then
                meleeSet = set_combine(meleeSet, sets.engaged.DW.SubtleBlow)
            elseif player.sub_job == 'DNC' then
                meleeSet = set_combine(meleeSet, sets.engaged.DW.SubtleBlow, sets.ExtraSubtleBlow)
            else
                meleeSet = set_combine(meleeSet, sets.engaged.SubtleBlow)
            end
        end
    end

    pet_only_equip_handling()
    meleeSet = apply_kiting(meleeSet)
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    elseif stateField == 'Treasure Mode' then
        state.TreasureMode:set(newValue)
    elseif stateField == 'Reward Mode' then
        state.RewardMode:set(newValue)
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if default_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Gavialis'
        end
        if spell.english == "Rampage" and world.day_element == 'Earth' then
            return 'Gavialis'
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)

end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_melee_groups()
    pet_only_equip_handling()
end

-- Updates gear based on pet status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Idle' or newStatus == 'Engaged' then
        if state.DefenseMode.value ~= "Physical" and state.DefenseMode.value ~= "Magical" then
            handle_equipping_gear(player.status)
        end
    end

    customize_melee_set(meleeSet)
end 

function job_buff_change(status, gain, gain_or_loss)
    --Equip Frenzy Sallet if we're asleep and engaged.
    if (status == "sleep" and gain_or_loss) and player.status == 'Engaged' then
        if gain then
            equip(sets.FrenzySallet)
        else
            handle_equipping_gear(player.status)
        end
    end

   if (status == "Aftermath: Lv.3" and gain_or_loss) and player.status == 'Engaged' then
        if player.equipment.main == 'Aymur' and gain then
            job_update(cmdParams, eventArgs)
            handle_equipping_gear(player.status)
        else
            job_update(cmdParams, eventArgs)
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Ready Move Presets and Pet TP Evaluation Functions - Credit to Bomberto and Verda
-------------------------------------------------------------------------------------------------------------------

pet_tp=0
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ready' then
        if pet.status == "Engaged" then
            ready_move(cmdParams)
        else
            send_command('input /pet "Fight" <t>')
        end
        eventArgs.handled = true
    end
    if cmdParams[1]:lower() == 'gearhandle' then
        pet_only_equip_handling()
    end
    if cmdParams[1] == 'pet_tp' then
	    pet_tp = tonumber(cmdParams[2])
    end
    if cmdParams[1]:lower() == 'charges' then
        charges = 3
        ready = windower.ffxi.get_ability_recasts()[102]
	    if ready ~= 0 then
	        charges = math.floor(((30 - ready) / 10))
	    end
	    add_to_chat(28,'Ready Recast:'..ready..'   Charges Remaining:'..charges..'')
    end
end
 
function ready_move(cmdParams)
    local move = cmdParams[2]:lower()
    local ReadyMove = ''
    if move == 'one' then
        ReadyMove = ReadyMoveOne
    elseif move == 'two' then
        ReadyMove = ReadyMoveTwo
    elseif move == 'three' then
        ReadyMove = ReadyMoveThree
    else
        ReadyMove = ReadyMoveFour
    end
    send_command('input /pet "'.. ReadyMove ..'" <me>')
end

pet_tp = 0
--Fix missing Pet.TP field by getting the packets from the fields lib
packets = require('packets')
function update_pet_tp(id,data)
    if id == 0x068 then
        pet_tp = 0
        local update = packets.parse('incoming', data)
        pet_tp = update["Pet TP"]
        windower.send_command('lua c gearswap c pet_tp '..pet_tp)
    end
end
id = windower.raw_register_event('incoming chunk', update_pet_tp)

-------------------------------------------------------------------------------------------------------------------
-- Current Job State Display
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Corr.: '..state.CorrelationMode.value



    add_to_chat(28,'Ready Moves: 1.'.. ReadyMoveOne ..'  2.'.. ReadyMoveTwo ..'  3.'.. ReadyMoveThree ..'  4.'.. ReadyMoveFour ..'')
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function equip_ready_gear(spell)
    if physical_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if multi_hit_ready_moves:contains(spell.name) then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.MultiStrikeDWNE.TPBonus)
                    else
                        equip(sets.midcast.Pet.MultiStrikeDWNE)
                    end
                else
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.MultiStrikeNE.TPBonus)
                    else
                        equip(sets.midcast.Pet.MultiStrikeNE)
                    end
                end
            else
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.ReadyDWNE.TPBonus[state.OffenseMode.value])
                    else
                        equip(sets.midcast.Pet.ReadyDWNE[state.OffenseMode.value])
                    end
                else
                    if tp_based_ready_moves:contains(spell.name) then
                        equip(sets.midcast.Pet.ReadyNE.TPBonus[state.OffenseMode.value])
                    else
                        equip(sets.midcast.Pet.ReadyNE[state.OffenseMode.value])
                    end
                end
            end
        else
            if multi_hit_ready_moves:contains(spell.name) then
                equip(sets.midcast.Pet.MultiStrike)
            else
                equip(sets.midcast.Pet[state.OffenseMode.value])
            end
        end

        -- Equip Headgear based on Neutral or Favorable Correlation Modes:
        if state.OffenseMode.value ~= 'MaxAcc' then
            equip(sets.midcast.Pet[state.CorrelationMode.value])
        end
    end

    if magic_atk_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                if tp_based_ready_moves:contains(spell.name) then
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE.TPBonus[state.OffenseMode.value])
                else
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE[state.OffenseMode.value])
                end
            else
                if tp_based_ready_moves:contains(spell.name) then
                    equip(sets.midcast.Pet.MagicAtkReadyNE.TPBonus[state.OffenseMode.value])
                else
                    equip(sets.midcast.Pet.MagicAtkReadyNE[state.OffenseMode.value])
                end
            end
        else
            equip(sets.midcast.Pet.MagicAtkReady[state.OffenseMode.value])
        end
    end

    if magic_acc_ready_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.MagicAccReadyDWNE)
            else
                equip(sets.midcast.Pet.MagicAccReadyNE)
            end
        else
            equip(sets.midcast.Pet.MagicAccReady)
        end
    end

    if pet_buff_moves:contains(spell.name) then
        if state.AxeMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.BuffDWNE)
            else
                equip(sets.midcast.Pet.BuffNE)
            end
        else
            equip(sets.midcast.Pet.Buff)
        end
    end

    --If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +2.
    --Or if Pet TP, before bonuses, is more than a certain value then equip Unleash-specific Axes.
    if (physical_ready_moves:contains(spell.name) or magic_atk_ready_moves:contains(spell.name)) and state.OffenseMode.value ~= 'MaxAcc' then
        if tp_based_ready_moves:contains(spell.name) and PetJob == 'Warrior' then
            if pet_tp < 1300 then
                equip(sets.midcast.Pet.TPBonus)
            elseif pet_tp > 2000 and state.AxeMode.value == 'PetOnly' then
                if multi_hit_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMultiStrikeAxes)
                    else
                        equip(sets.UnleashMultiStrikeAxeShield)
                    end
                elseif physical_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashAtkAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashAtkAxeShield[state.OffenseMode.value])
                    end
                else
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMABAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashMABAxeShield[state.OffenseMode.value])
                    end
                end
            end
        elseif tp_based_ready_moves:contains(spell.name) and PetJob ~= 'Warrior' then
            if pet_tp < 1800 then
                equip(sets.midcast.Pet.TPBonus)
            elseif pet_tp > 2500 and state.AxeMode.value == 'PetOnly' then
                if multi_hit_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMultiStrikeAxes)
                    else
                        equip(sets.UnleashMultiStrikeAxeShield)
                    end
                elseif physical_ready_moves:contains(spell.name) then
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashAtkAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashAtkAxeShield[state.OffenseMode.value])
                    end
                else
                    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                        equip(sets.UnleashMABAxes[state.OffenseMode.value])
                    else
                        equip(sets.UnleashMABAxeShield[state.OffenseMode.value])
                    end
                end
            end
        end
    end
end

function pet_only_equip_handling()
    if player.status == 'Engaged' and state.AxeMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if state.DefenseMode.value == "Physical" then
                equip(sets.defense.DWNE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                equip(sets.defense.DWNE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    equip(sets.idle.DWNE.PetEngaged)
                else
                    equip(sets.idle.DWNE)
                end
            end
        else
            if state.DefenseMode.value == "Physical" then
                equip(sets.defense.NE[state.PhysicalDefenseMode.value])
            elseif state.DefenseMode.value == "Magical" then
                equip(sets.defense.NE[state.MagicalDefenseMode.value])
            else
                if pet.status == "Engaged" then
                    equip(sets.idle.NE.PetEngaged)
                else
                    equip(sets.idle.NE)
                end
            end
        end
    end
end

function get_melee_groups()
    classes.CustomMeleeGroups:clear()

    if buffactive['Aftermath: Lv.3'] then
        classes.CustomMeleeGroups:append('Aftermath')
    end
end

function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end