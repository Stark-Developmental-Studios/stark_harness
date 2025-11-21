return {
    VersionCheck = true,
    Framework = 'qbx',            -- supported: 'qb' or 'qbx'
    Inventory = 'ox',             -- supported: 'qb', 'ps', or 'ox'
    Notify = 'ox',                -- supported: 'qb', 'ox', or 'lation'
    Progress = 'lation',          -- supported: 'qb', 'ox_bar', 'ox_circle', or 'lation'
    MechanicJobType = 'mechanic', -- Adjust According To Your Server's Auto Mechanic Job Type As Found In qb-core/shared/jobs.lua or qbx_core/shared/jobs.lua
    MechanicOnly = false,
    InstallationTime = 10000,
    HarnessUses = 20,
    RemoveWithItem = true,
}
