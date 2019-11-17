// Settings for customisations

// Available AI Units
settings_units = ["I_L_Criminal_SG_F","I_L_Criminal_SMG_F","I_L_Hunter_F","I_L_Looter_Pistol_F","I_L_Looter_Rifle_F","I_L_Looter_SG_F","I_L_Looter_SMG_F","I_L_Uniform_01_tshirt_black_F","I_L_Uniform_01_tshirt_olive_F","I_L_Uniform_01_tshirt_skull_F","I_L_Uniform_01_tshirt_sport_F"];

// How long votes should last for, in seconds.
settings_votetime = 30;

// Minimum number of building positions required to be an available building (15 minimum recommended - don't have more AI than building positions!)
settings_buildingThreshold = 15;

// Arsenal Settings. True allows all weapons/magazines/items/backpacks, or an array of strings can allow only certain objects.
/*
For example, the following would allow only MX Black Rifles with NATO MTP uniforms and basic gear:
settings_arsenalWeapons = ["arifle_MX_Black_F","hgun_P07_F"];
settings_arsenalMagazines = ["Chemlight_green","30Rnd_65x39_caseless_black_mag","16Rnd_9x21_Mag","SmokeShell","HandGrenade""30Rnd_65x39_caseless_black_mag_Tracer","B_IR_Grenade"];
settings_arsenalItems = ["FirstAidKit","acc_pointer_IR","optic_Holosight_blk_F","NVGoggles","ItemWatch","ItemCompass","ItemRadio","ItemMap","MineDetector","H_HelmetB","U_B_CombatUniform_mcam","V_PlateCarrier1_rgr"];
settings_arsenalBackpacks = ["B_AssaultPack_mcamo"];
*/
settings_arsenalWeapons = true;
settings_arsenalMagazines = true;
settings_arsenalItems = true;
settings_arsenalBackpacks = true;