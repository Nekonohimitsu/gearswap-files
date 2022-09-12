-- Initialization function for this job file.
 
local jobs = T{ 'Nekonohimitsu_BLU', 'Nekonohimitsu_BRD_Gear', 'Nekonohimitsu_COR', 'Nekonohimitsu_DRK', 'Nekonohimitsu_GEO', 'Nekonohimitsu_PLD_Gear', 'Nekonohimitsu_RDM', 'Nekonohimitsu_SCH', 'WHM_Gear' }
 
mysets = {}
 
for k,v in pairs(jobs) do
    include(v .. '.lua')
    get_sets()
    mysets[v] = sets
    sets = {}
 end
 
 
function get_sets()
    for k,v in pairs(mysets) do sets[k] = v end
end