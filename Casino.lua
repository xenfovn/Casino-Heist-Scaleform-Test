----- MAIN FUNCTIONS -----

local function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

local function CallScaleformMethod (scaleform, method, ...)
	local t
	local args = { ... }
	BeginScaleformMovieMethod(scaleform, method)
	for k, v in ipairs(args) do
		t = type(v)
		if t == 'string' then
			PushScaleformMovieMethodParameterString(v)
		elseif t == 'number' then
			if string.match(tostring(v), "%.") then
				PushScaleformMovieFunctionParameterFloat(v)
			else
				PushScaleformMovieFunctionParameterInt(v)
			end
		elseif t == 'boolean' then
			PushScaleformMovieMethodParameterBool(v)
		end
	end
	EndScaleformMovieMethod()
end

----- SETUP BOARD CODE -----

local function PrepBoard()
    CreateThread(function()
        scaleform = RequestScaleformMovie('CASINO_HEIST_BOARD_SETUP') --uParam0->f_709
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end
        print(scaleform)
        local model = GetHashKey("ch_prop_whiteboard"); -- 2054093856
        local pos = { x = -810.59, y = 170.46, z = 77.25 };
        local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
        local handle = CreateNamedRenderTargetForModel("arcadeplan_01", model)
        while true do
            SetTextRenderId(handle) -- set render target
            Set_2dLayer(4)
            SetScriptGfxDrawBehindPausemenu(1)
            DrawScaleformMovie(scaleform, 0.25, 0.5, 0.5, 1.0, 255, 255, 255, 255, 0)
            SetScaleformFitRendertarget(scaleform, true)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset
            SetScriptGfxDrawBehindPausemenu(0)
            Citizen.Wait(0)
        end
    end)
end

RegisterCommand('board', function()
    CreateThread(function()
        PrepBoard()
        Wait(100)
        -- TOP LEFT BULEPRINT
        CallScaleformMethod(scaleform, 'SET_BLUEPRINT_VISIBLE', true)
        -- TODO LIST
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line1', true)
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line2', true)
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line3', true)
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line4', false)
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line5', false)
        CallScaleformMethod(scaleform, 'ADD_TODO_LIST_ITEM', 'Line6', false)
        -- OPTIONAL LIST
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line1', true)
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line2', true)
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line3', true)
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line4', false)
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line5', false)
        CallScaleformMethod(scaleform, 'ADD_OPTIONAL_LIST_ITEM', 'Line6', false)
        -- TYPE OF LOOT
        CallScaleformMethod(scaleform, 'SET_TARGET_TYPE', 'PLACEHOLDER')
        -- POI IMAGES
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 1)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 2)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 3)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 4)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 5)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 6)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 7)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 8)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 9)
        CallScaleformMethod(scaleform, 'SET_POI_IMAGES', 10)
        -- BUTON IMAGES?
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 1, 1) -- Unknown

        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 2, 1) -- Extra 1
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 3, 2) -- Extra 2
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 4, 3) -- Extra 3

        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 5, 1) -- Approach 1
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 6, 2) -- Approach 2
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 7, 3) -- Approach 3

        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 8, 3) -- Target Loot

        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 9, 1) -- Casino Image / Guard Image Top
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 10, 2) -- -- Casino Image / Guard Image Bottom

        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 11, 1) -- Access Point 1
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 12, 2) -- Access Point 2
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 13, 3) -- Access Point 3
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 14, 4) -- Access Point 4
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 15, 5) -- Access Point 5
        CallScaleformMethod(scaleform, 'SET_BUTTON_IMAGE', 16, 6) -- Access Point 6
        -- Selections / Lock / idk imma shoot myself (use button ID's above)
        -- CallScaleformMethod(scaleform, 'SET_CURRENT_SELECTION', 5)
        CallScaleformMethod(scaleform, 'SET_EXTREME', 5, true)
        -- CallScaleformMethod(scaleform, 'SET_PADLOCK', 6, true)
        CallScaleformMethod(scaleform, 'SET_TICK', 2, true)
        CallScaleformMethod(scaleform, 'SET_TICK', 10, true)
    end)
end)

local incam = false
local cam
local selected = 1 -- Used for selecting ButtonID's
local CantSelect = {} -- This loks the other 2 Approaches from being slected after 1 has already been selected
RegisterCommand('EnterBoard', function()
    local entity = GetClosestObjectOfType(2712.0, -366.41, -54.78, 1.5, `ch_prop_whiteboard`, 0, 0, 0)
    local Offset = GetOffsetFromEntityInWorldCoords(entity, 0.0, -1.5, 0.0)
    -- while true do
    --     Wait(5)
    --     DrawLine(GetEntityCoords(entity), Offset, 255, 50, 50, 255)
    -- end
    if not incam then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(cam, Offset.x, Offset.y, Offset.z)
        PointCamAtEntity(cam, entity)
        RenderScriptCams(true, true, 2000, 1, 1)
        Wait(2000)
        incam = true
    end

    while incam do
        Wait(1)
        if IsControlJustPressed(0, 177) then -- Exit
            RenderScriptCams(false, true, 2000, 1, 1)
            Wait(2000)
            DestroyCam(cam, 0)
            incam = false
        elseif IsControlJustPressed(0, 190) then -- Right
            selected = selected + 1
            print('Selecting #:'..selected)
            CallScaleformMethod(scaleform, 'SET_CURRENT_SELECTION', selected)
        elseif IsControlJustPressed(0, 189) then -- Left
            selected = selected - 1
            print('Selecting #:'..selected)
            CallScaleformMethod(scaleform, 'SET_CURRENT_SELECTION', selected)
        elseif IsControlJustPressed(0, 191) and not CantSelect[selected] then -- Enter
            CallScaleformMethod(scaleform, 'SET_TICK', selected, true)
            if selected == 5 then
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 6, true)
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 7, true)
                CantSelect = {
                    [6] = true,
                    [7] = true
                }
            elseif selected == 6 then
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 5, true)
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 7, true)
                CantSelect = {
                    [5] = true,
                    [7] = true
                }
            elseif selected == 7 then
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 6, true)
                CallScaleformMethod(scaleform, 'SET_PADLOCK', 5, true)
                CantSelect = {
                    [5] = true,
                    [6] = true,
                }
            end
        end
    end
end)

----- PREP BOARD CODE -----

local function PrepBoard2()
    CreateThread(function()
        scaleform2 = RequestScaleformMovie('CASINO_HEIST_BOARD_PREP') --uParam0->f_709
        while not HasScaleformMovieLoaded(scaleform2) do
            Citizen.Wait(0)
        end
        print(scaleform2)
        local model = GetHashKey("ch_prop_whiteboard_02"); -- 2054093856
        local pos = { x = -810.59, y = 170.46, z = 77.25 };
        local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
        local handle = CreateNamedRenderTargetForModel("arcadeplan_02", model)
        while true do
            SetTextRenderId(handle) -- set render target
            Set_2dLayer(4)
            SetScriptGfxDrawBehindPausemenu(1)
            DrawScaleformMovie(scaleform2, 0.25, 0.5, 0.5, 1.0, 255, 255, 255, 255, 0)
            SetScaleformFitRendertarget(scaleform2, true)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset
            SetScriptGfxDrawBehindPausemenu(0)
            Citizen.Wait(0)
        end
    end)
end

RegisterCommand('board2', function()
    CreateThread(function()
        PrepBoard2()
        Wait(100)
        -- TODO LIST
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line1', true)
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line2', true)
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line3', true)
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line4', false)
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line5', false)
        CallScaleformMethod(scaleform2, 'ADD_TODO_LIST_ITEM', 'Line6', false)
        -- OPTIONAL LIST
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line1', true)
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line2', true)
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line3', true)
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line4', false)
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line5', false)
        CallScaleformMethod(scaleform2, 'ADD_OPTIONAL_LIST_ITEM', 'Line6', false)
        -- SECURITY PASS LEVEL
        CallScaleformMethod(scaleform2, 'SET_SECURITY_PASS_VISIBLE', 2)
        -- APPROACH Specific Perps
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', -2, 1, "-2", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', -1, 2, "-1", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 0, 3, "0", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 1, 4, "1", false, true, 'TAPE')
        -- Etc
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 2, 1, "2", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 3, 3, "3", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 4, 4, "4", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 5, 2, "5", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 6, 1, "6", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 7, 1, "7", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 8, 6, "8", false, true, 'TAPE')
        CallScaleformMethod(scaleform2, 'ADD_APPROACH', 9, 2, "9", false, true, 'TAPE')
        --HEADINGS?
        CallScaleformMethod(scaleform2, 'SET_HEADINGS', 'FUCK1', 'FUCK2')
        -- Crew Members
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER', 10, 'AJ Lastname', 'Skill', 2, 30, 1)
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER_HIRED', 10, false)
        CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 5, false)
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER', 11, 'AJ Lastname ', 'Skill', 1, 30, 1)
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER_HIRED', 11, false)
        CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 6, false)
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER', 12, 'AJ Lastname', 'Skill', 4, 10, 1)
        CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER_HIRED', 12, false)
        CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 7, false)
    end)
end)

local selected2 = -3 --Used for selecting ButtonID's
local ScaleformSelected = { -- Dosent work yet but what im trying to do here is when your selecting the 4th image (its in the middle of the board), itll show in the place of ID "9" (Bottom Left of the board)
    [-2] = -2,
    [-1] = -1,
    [0] = 0,
    [1] = 1,
    [2] = 2,
    [3] = 3,
    [4] = 9,
    [5] = 5,
    [6] = 6,
    [7] = 7,
    [8] = 8,
    [9] = 4,
    [10] = 10,
    [11] = 11,
    [12] = 12,
    [13] = 13,
}
RegisterCommand('EnterBoard2', function()
    local entity = GetClosestObjectOfType(2716.07, -369.06, -54.78, 1.5, `ch_prop_whiteboard_02`, 0, 0, 0)
    local Offset = GetOffsetFromEntityInWorldCoords(entity, 0.0, -1.5, 0.0)
    -- while true do
    --     Wait(5)
    --     DrawLine(GetEntityCoords(entity), Offset, 255, 50, 50, 255)
    -- end
    if not incam then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamCoord(cam, Offset.x, Offset.y, Offset.z)
        PointCamAtEntity(cam, entity)
        RenderScriptCams(true, true, 2000, 1, 1)
        Wait(2000)
        incam = true
    end

    while incam do
        Wait(1)
        if IsControlJustPressed(0, 177) then -- Exit
            RenderScriptCams(false, true, 2000, 1, 1)
            Wait(2000)
            DestroyCam(cam, 0)
            incam = false
        elseif IsControlJustPressed(0, 190) then -- Right
            selected2 = selected2 + 1
            print('Selecting #:'..selected2)
            CallScaleformMethod(scaleform2, 'SET_CURRENT_SELECTION', selected2)
        elseif IsControlJustPressed(0, 189) then -- Left
            selected2 = selected2 - 1
            print('Selecting #:'..selected2)
            CallScaleformMethod(scaleform2, 'SET_CURRENT_SELECTION', selected2)
        elseif IsControlJustPressed(0, 191) and not CantSelect[selected2] then -- Enter
            if selected2 == 10 or 11 or 12 then
                CallScaleformMethod(scaleform2, 'SET_CREW_MEMBER_HIRED', selected2, true)
                if selected2 == 10 then
                    CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 5, true)
                elseif selected2 == 11 then
                    CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 6, true)
                elseif selected2 == 12 then
                    CallScaleformMethod(scaleform2, 'SET_BUTTON_VISIBLE', 7, true)
                end
            else
                CallScaleformMethod(scaleform2, 'SET_TICK', selected2, true)
            end
        end
    end
end)

----- FINAL BOARD CODE -----

local function PrepBoard3()
    CreateThread(function()
        scaleform3 = RequestScaleformMovie('CASINO_HEIST_BOARD_FINALE') --uParam0->f_709
        while not HasScaleformMovieLoaded(scaleform3) do
            Wait(0)
        end
        print(scaleform3)
        local model = GetHashKey("ch_prop_whiteboard_03"); -- 2054093856
        local pos = { x = -810.59, y = 170.46, z = 77.25 };
        local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
        local handle = CreateNamedRenderTargetForModel("arcadeplan_03", model)
        while true do
            SetTextRenderId(handle) -- set render target
            Set_2dLayer(4)
            SetScriptGfxDrawBehindPausemenu(1)
            DrawScaleformMovie(scaleform3, 0.25, 0.5, 0.5, 1.0, 255, 255, 255, 255, 0)
            SetScaleformFitRendertarget(scaleform3, true)
            SetTextRenderId(GetDefaultScriptRendertargetRenderId()) -- reset
            SetScriptGfxDrawBehindPausemenu(0)
            Wait(0)
        end
    end)
end

local function GetPedheadshot(ped)
    local step = 1000
    local timeout = 5 * 1000
    local currentTime = 0
    local pedheadshot = RegisterPedheadshot(ped)

    while not IsPedheadshotReady(pedheadshot) do
        Citizen.Wait(step)

        currentTime = currentTime + step

        if currentTime >= timeout then
            return -1
        end
    end

    return pedheadshot
end

local function LoadStreamedTextureDict(texturesDict)
    local step = 1000
    local timeout = 5 * 1000
    local currentTime = 0

    RequestStreamedTextureDict(texturesDict, 0)
    while not HasStreamedTextureDictLoaded(texturesDict) do
        Citizen.Wait(step)

        currentTime = currentTime + step

        if currentTime >= timeout then
            return false
        end
    end

    return true
end

RegisterCommand('board3', function()
    CreateThread(function()
        PrepBoard3()
        Wait(100)
        local pedheadshot = GetPedheadshot(PlayerPedId())

        if pedheadshot ~= -1 then
            textureDict = GetPedheadshotTxdString(pedheadshot)
    
            local IsTextureDictLoaded = LoadStreamedTextureDict(textureDict)
            print(textureDict, IsTextureDictLoaded)
            CallScaleformMethod(scaleform3, 'SET_HEADINGS', 'approach', 'target', 1000000, 1500000, 25000, 'entrance', 'exit', 'buyer', 'outfitIn', 'outfitOut')

            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER', 8, 'ihyajb', textureDict)
            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER_STATE', 8, true, 2)
            CallScaleformMethod(scaleform3, 'SET_CREW_CUT', 8, 25)

            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER', 9, 'ihyajb', textureDict)
            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER_STATE', 9, false, 2)
            CallScaleformMethod(scaleform3, 'SET_CREW_CUT', 9, 75)

            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER', 10, 'ihyajb', textureDict)
            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER_STATE', 10, false, 2)
            CallScaleformMethod(scaleform3, 'SET_CREW_CUT', 10, 0)

            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER', 11, 'ihyajb', textureDict)
            CallScaleformMethod(scaleform3, 'SET_CREW_MEMBER_STATE', 11, true, 2)
            CallScaleformMethod(scaleform3, 'SET_CREW_CUT', 11, 0)
        end
    end)
end)

----- DECOMPILED CODE SNIPPETS I USED / LOOKED AT | File: gb_casino_heist_planning.c -----

-- void func_1217(var uParam0)
-- {
-- 	uParam0->f_709 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("CASINO_HEIST_BOARD_SETUP");
-- 	uParam0->f_710 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS");
-- }

-- void func_1100(var uParam0)
-- {
-- 	uParam0->f_709 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("CASINO_HEIST_BOARD_PREP");
-- 	uParam0->f_710 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS");
-- }

-- void func_915(var uParam0)
-- {
-- 	uParam0->f_709 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("CASINO_HEIST_BOARD_FINALE");
-- 	uParam0->f_710 = GRAPHICS::REQUEST_SCALEFORM_MOVIE("INSTRUCTIONAL_BUTTONS");
-- }

-- char* func_1231(int iParam0)
-- {
-- 	switch (iParam0)
-- 	{
-- 		case 0:
-- 			return "arcadeplan_01";

-- 		case 1:
-- 			return "arcadeplan_02";

-- 		case 2:
-- 			return "arcadeplan_03";

-- 		default:
-- 	}
-- 	return "";
-- }

-- int func_1230(int iParam0)
-- {
-- 	switch (iParam0)
-- 	{
-- 		case 0:
-- 			return joaat("ch_prop_whiteboard");

-- 		case 1:
-- 			return joaat("ch_prop_whiteboard_02");

-- 		case 2:
-- 			return joaat("ch_prop_whiteboard_03");

-- 		default:
-- 	}
-- 	return 0;
-- }

-- void func_1158(var uParam0)
-- {
-- 	if (uParam0->f_702)
-- 	{
-- 		if (GRAPHICS::HAS_SCALEFORM_MOVIE_LOADED(uParam0->f_709))
-- 		{
-- 			GRAPHICS::SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(true);
-- 			HUD::SET_TEXT_RENDER_ID(uParam0->f_700);
-- 			switch (2)
-- 			{
-- 				case 0:
-- 					break;

-- 				case 1:
-- 					GRAPHICS::_0x32F34FF7F617643B(uParam0->f_709, 1);
-- 					break;

-- 				case 2:
-- 					GRAPHICS::_SET_SCALEFORM_FIT_RENDERTARGET(uParam0->f_709, true);
-- 					break;
-- 			}
-- 			GRAPHICS::DRAW_SCALEFORM_MOVIE(uParam0->f_709, 0.25f, 0.5f, 0.5f, 1f, 255, 255, 255, 255, 0);
-- 			HUD::SET_TEXT_RENDER_ID(HUD::GET_DEFAULT_SCRIPT_RENDERTARGET_RENDER_ID());
-- 			GRAPHICS::SET_SCRIPT_GFX_DRAW_BEHIND_PAUSEMENU(false);
-- 			if (uParam0->f_705)
-- 			{
-- 			}
-- 		}
-- 	}
-- 	if (uParam0->f_703)
-- 	{
-- 		func_1159(uParam0);
-- 	}
-- }