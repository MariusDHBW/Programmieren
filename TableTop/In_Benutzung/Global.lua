setup_token = 'a2f924'
assets_deck = 'ee3091'
boon_deck = '00c94d'
bane_deck = '4b5612'
spell_deck = '979d7b'
talent_deck = '00c94d'
u_assets_deck = 'hr2o1d'
pawn_bag = '50c60d'

hp_bag = '194dca'
san_bag = 'e4b9e9'
trash_bag = '62mbfc'
game_board = '5y4u6n'
zone = '4i02oy'
pyramid_bag = '7r39h8'
ant_bag = '1sw2bb'
et_bag = '084f8n'
ancients_bag = 'i1suo8'
prelude_deck = '323e47'
doom_track = '0meu2k'
monster_bag = 'f784da'
epic_monster_bag = '3616e4'
mystic_bag = '9o33o4'
dream_bag = 'f35a79'
moreset = false
disaster_bag = 'f2ace9'
nyarla_bag = '142c8e'
eldritch_bag = '084f8n'
personalStories_deck = '4f714d'

expeditionDeck = 'hz6n3c'
mysticRuinsDeck = '1x7og2'
dreamQuestDeck = "078985"

discard_bag = '84844c'

focus_bag = 'ps1q97'
clue_bag = '652d1t'
ticket_bag = '6d91f2'
will_bag = '8ca0b4'
resource_bag = 'f0fcc6'
gates_bag = '96en34'

shouldGetPrelude = "True"
shouldGetPersonalStory = "True"
shouldIncludeEasyMythos = "True"
shouldIncludeMediumMythos = "True"
shouldIncludeHardMythos = "True"
progressiveMythos = "False"
manualPlayerValue = '0'

decks = {
    character = "84yoxs",
    other_worls = "ecab11",
    general = "82af68",
    america = "b2d49d",
    europe = "2bbb46",
    asia = "d90c42",
    expedition = "hz6n3c",
    assets = "ee3091",
    spells = "979d7b",
    unique_assets = "4d308a",
    artifacts = "95073f",
    debts = "8e0b7c",

    -- mythos decks
    hgm = 'qszvkn',
    mgm = 'vxiwyn',
    egm = 'uc2b43',
    hym = '8c13f8',
    mym = 'n621fe',
    eym = 'cr05o1',
    hbm = 'k39546',
    mbm = '6g97ke',
    ebm = '0c9452',

    bm = "7eaa3b",
    ym = "c30267",
    gm = "6c5ef6",

    -- preludes must be filtered after mythos to avoid spawning mythos cards
    preludes = "323e47",

    injuries = "eb8351",
    madnesses = "8a60b0",
    illnesses = "96ae9b",
    exposures = "3c22ea",
    pursuits = "87bd42",
    deals = "8e0b7c",
    talents = "ee2fae",
    banes = "b150a1",
    restrictions = "44cb4b"
}

extension_codes = {"EH01", "EH02", "EH03", "EH04", "EH05", "EH06", "EH07", "EH08", "EH09"}
selected_expansions = {}

ancients_by_expansion = {
    EH01 = {"Azathoth", "Cthulhu", "Shub-Niggurath", "Yog-Sothoth"},
    EH02 = {"Yig"},
    EH03 = {"ElderThings", "Ithaqua"},
    EH04 = {"Syzygy"},
    EH05 = {"Abhoth", "Nephren-Ka"},
    EH06 = {"Hastur"},
    EH07 = {"Atlach-Nacha", "Hypnos"},
    EH08 = {"Shudde Mell"},
    EH09 = {"Antediluvium", "Nyarlathotep"},
    EHX1 = {"Ghatanothoa", "Y-Golonac", "The King in Yellow", "The Mi-go"}
}

boardLocations = {
    Antarctica = {5, -10.9},
    The_Heart_Of_Africa = {3.030, -1.31},
    The_Pyramids = {3.940, 3.920},
    The_Himalayas = {12.72, 7.000},
    Tunguska = {13.78, 12.40},
    The_Amazon = {-12.4, 0.990},
    San_Francisco = {-21.9, 10.53},
    Arkham = {-12.6, 10.13},
    Buenos_Aires = {-12.8, -4.58},
    London = {-3.29, 12.25},
    Rome = {-0.14, 7.990},
    Istanbul = {5.580, 9.650},
    Tokyo = {23.32, 7.520},
    Shanghai = {18.73, 4.32},
    Sydney = {22.45, -7.40},
    ["Chichen Itza (7)"] = {-16.35, 3.85},
    ["Moai Statues (3)"] = {-21.43, -5.80},
    ["Mu (2)"] = {-25.5, 7.67},
    ["Hyperborea (9)"] = {-8.48, 16.06},
    ["Atlantis (8)"] = {-12.78, 6.95},
    ["Pnakotus (21)"] = {20.82, -3.81}
}
-- Functions

function shuffleDeck(deckID)
    shuffledDeck = getObjectFromGUID(deckID)
    shuffledDeck.shuffle()
end

function slowSpawnNextExpedition()
    Wait.frames(function()
        spawnNextExpedition()
    end, 1)
end

function spawnNextExpedition()
    local expeditionObjects = getObjectFromGUID(expeditionDeck).getObjects()
    local nextExpeditionTable = expeditionObjects[#expeditionObjects]
    local nextExpeditionName = nextExpeditionTable["nickname"]
    local coords = boardLocations[nextExpeditionName]
    local expeditionToken = getObjectFromGUID("du57qe")

    if coords == nil then
        printToAll("coordinates for " .. nextExpeditionName .. " not found")
    else
        expeditionToken.setPosition(vector(coords[1], 3, coords[2]))
    end
end

function slowSpawnNextMysticRuins()
    Wait.frames(function()
        spawnNextMysticRuins()
    end, 1)
end

function spawnNextMysticRuins()
    local mysticRuinsObjects = getObjectFromGUID(mysticRuinsDeck).getObjects()
    local nextmysticRuinsTable = mysticRuinsObjects[1]
    local nextmysticRuinsName = nextmysticRuinsTable.nickname
    local coords = boardLocations[nextmysticRuinsName]
    local mysticRuinsToken = getObjectFromGUID("o84pjs")

    if coords == nil then
        printToAll("coordinates for " .. nextmysticRuinsName .. " not found")
    else
        mysticRuinsToken.setPosition(vector(coords[1], 3, coords[2]))
    end
end

function slowSpawnNextDreamQuest()
    Wait.frames(function()
        spawnNextDreamQuest()
    end, 1)
end

function spawnNextDreamQuest()
    local mysticRuinsObjects = getObjectFromGUID(dreamQuestDeck).getObjects()
    local nextDreamQuestTable = mysticRuinsObjects[1]
    local nextDreamQuestName = nextDreamQuestTable.nickname
    local coords = boardLocations[nextDreamQuestName]
    local dreamQuestToken = getObjectFromGUID("dba6b6")

    if coords == nil then
        printToAll("coordinates for " .. nextDreamQuestName .. " not found")
    else
        dreamQuestToken.setPosition(vector(coords[1], 3, coords[2]))
    end
end

function spawnClues()
    local bag = getObjectFromGUID(clue_bag)
    local spawnedClue = bag.takeObject({
        position = {0, 3, 0},
        rotation = {0, 180, 0}
    })
    local spawnedClueData = spawnedClue.getData()
    local clueBoardID = spawnedClueData["Description"]
    local clueX = tonumber(string.sub(spawnedClueData["GMNotes"], 1, 5))
    local clueZ = tonumber(string.sub(spawnedClueData["GMNotes"], -5))
    local clueBoard = nil
    local clueBoardData = {}
    local clueBoardTransform = {}
    local clueBoardX = 0
    local clueBoardZ = 0
    if clueBoardID == "" then
        spawnedClue.setPosition(vector(clueX, 3, clueZ))
    else
        clueBoard = getObjectFromGUID(clueBoardID)
        clueBoardData = clueBoard.getData()
        clueBoardTransform = clueBoardData["Transform"]
        clueBoardX = tonumber(clueBoardTransform["posX"])
        clueBoardZ = tonumber(clueBoardTransform["posZ"])
        clueX = clueX + clueBoardX
        clueZ = clueZ + clueBoardZ
        spawnedClue.setPosition(vector(clueX, 3, clueZ))
    end
end

function spawnGates()
    local bag = getObjectFromGUID(gates_bag)
    local spawnedGate = bag.takeObject({
        position = {0, 3, 0},
        rotation = {0, 180, 0}
    })
    local spawnedGateData = spawnedGate.getData()
    local gateBoardID = ""
    local gateBoardIDCheck = string.sub(spawnedGateData["GMNotes"], -1)
    local gateX = tonumber(string.sub(spawnedGateData["Description"], 1, 5))
    local gateZ = tonumber(string.sub(spawnedGateData["Description"], -5))
    local gateBoard = nil
    local gateBoardData = {}
    local gateBoardTransform = {}
    local gateBoardX = 0
    local gateBoardZ = 0
    if gateBoardIDCheck == "-" then
        gateBoardID = string.sub(spawnedGateData["GMNotes"], 1, 6)
        gateBoard = getObjectFromGUID(gateBoardID)
        gateBoardData = gateBoard.getData()
        gateBoardTransform = gateBoardData["Transform"]
        gateBoardX = tonumber(gateBoardTransform["posX"])
        gateBoardZ = tonumber(gateBoardTransform["posZ"])
        gateX = gateX + gateBoardX
        gateZ = gateZ + gateBoardZ
    end
    spawnedGate.setPosition(vector(gateX, 3, gateZ))
    local monsterbag = getObjectFromGUID(monster_bag)
    Wait.frames(function()
        local spawnedMonster = monsterbag.takeObject({
            position = {gateX, 3.5, gateZ},
            rotation = {0, 180, 180},
            smooth = false
        })
        local spawnedMonsterData = spawnedMonster.getData()
        local spawnedMonsterType = spawnedMonsterData["Name"]
        if spawnedMonsterType == "Custom_Tile" then
            spawnedMonster.setRotation(vector(0, 180, 0))
        end
    end, 30)
end

function onSave()
    if gameStarted then
        return JSON.encode(origin)
    end
end

function onPlayerConnect(player)
    if not player.promoted and not player.host then
        player.promote()
    end
end

function onLoad(save_state)
    for _, player in ipairs(Player.getPlayers()) do
        onPlayerConnect(player)
    end
    registerHotKeys()

    math.randomseed(os.time())
    if save_state ~= "" then
        origin = JSON.decode(save_state)
        gameStarted = true
    end

    -- Enable all expansions by default
    for iext = 1, #extension_codes do
        selected_expansions[extension_codes[iext]] = "true"
    end

    options = getOptions()
    createButtons()
    debtButton()
    clueButton()
    gateButton()
    -- expeditionButton()
end

function setupCharacter(a, b)
    local decks = {bane_deck, assets_deck, talent_deck, boon_deck, spell_deck, u_assets_deck, "f97ec7"}
    local specials = {
        Clue = "652d1t",
        ["Ship Ticket"] = '6d91f2',
        ["Improve Any"] = 'dcb941',
        ["Improve Will"] = '8ca0b4',
        Focus = 'ps1q97',
        Resource = 'f0fcc6'
    }
    local starters = a.getVar('starters')
    local card_offset = -#starters + 1
    for k, v in pairs(starters) do
        local special = specials[v]
        local options = {
            rotation = {0, 180, 0},
            position = {a.getPosition().x + 11.5 + card_offset, a.getPosition().y + 1, a.getPosition().z + 5.5}
        }
        if special ~= nil then
            local bag = getObjectFromGUID(special)
            bag.takeObject(options)
        else
            for i = 1, #decks do
                local name = decks[i]
                if type(searchForIn(v, name, options)) == 'userdata' then
                    break
                end
            end
        end
        card_offset = card_offset + 2.5
    end
    a.removeButton(0)
    local token = searchForIn(a.getName(), pawn_bag, {
        position = {a.getPosition().x - 2, a.getPosition().y + 2, a.getPosition().z}
    })
    local hp = getObjectFromGUID(hp_bag).takeObject({
        position = {a.getPosition().x + 2, a.getPosition().y + 2, a.getPosition().z - 2},
        rotation = {0, 180, 0}
    })
    local san = getObjectFromGUID(san_bag).takeObject({
        position = {a.getPosition().x + 5, a.getPosition().y + 2, a.getPosition().z - 1},
        rotation = {0, 180, 0}
    })
    --hp.Counter.setValue(a.getVar('hp'))
    --san.Counter.setValue(a.getVar('san'))
    token.setColorTint(b)
    local tokenData = token.getData()
    local tokenGMNotes = tokenData["GMNotes"]
    if tokenGMNotes == "special" then
        printToAll(a.getName() .. " token must be spawned manually")
    else
        local pos = string.find(tokenGMNotes, ',')
        local tokenX = tonumber(string.sub(tokenGMNotes, 1, pos - 1))
        local tokenZ = tonumber(string.sub(tokenGMNotes, pos + 1))
        token.setPosition(vector(tokenX, 3, tokenZ))
        token.setRotation(vector(0, 0, 0))
    end
    local namepos = Player[b].getPlayerHand()
    if shouldGetPersonalStory == "True" then
        local story = searchForInExact(a.getData()["Nickname"], personalStories_deck)
        story.setPosition(vector(a.getPosition().x + 4, a.getPosition().y + 2, a.getPosition().z - 8.5))
        local storyEnd = searchForInExact(a.getData()["Nickname"], personalStories_deck)
        storyEnd.setPosition(vector(a.getPosition().x + 6.5, a.getPosition().y + 2, a.getPosition().z - 8.5))
    end
end

function createButtons()
    local controller = getObjectFromGUID(setup_token)
    controller.createButton({
        click_function = 'startGame',
        label = 'Setup',
        font_size = 400,
        position = {0, 0.30, 0},
        width = 1000,
        height = 550
    })

    function debtButton()
        local gameboard = getObjectFromGUID(game_board)
        gameboard.createButton({
            click_function = 'drawDebt',
            label = 'Draw debt',
            font_size = 300,
            position = {-25.15, 0.10, 14.5},
            width = 1500,
            height = 500
        })
    end

    function expeditionButton()
        local gameboard = getObjectFromGUID(game_board)
        gameboard.createButton({
            click_function = 'spawnNextExpedition',
            label = 'Place Expedition Token',
            font_size = 300,
            position = {33.4, 0.6, -10},
            width = 1500,
            height = 500
        })
    end

    function clueButton()
        local gameboard = getObjectFromGUID(game_board)
        gameboard.createButton({
            click_function = 'spawnClues',
            label = 'Spawn Clue',
            font_size = 300,
            position = {33.4, 0.6, 11},
            width = 1500,
            height = 500
        })
    end
    function gateButton()
        local gameboard = getObjectFromGUID(game_board)
        gameboard.createButton({
            click_function = 'spawnGates',
            label = 'Spawn Gate',
            font_size = 300,
            position = {33.5, 0.6, 16},
            width = 1500,
            height = 500
        })
    end
    function drawDebt()
        local pos = getObjectFromGUID(game_board).getPosition()
        searchForIn('debt', decks.deals, {
            position = {-25.12, 1.11, -13.42}
        }).setRotation({0, 180, 0})
    end
    assetButtons()

end

function assetButtons()
    local gameboard = getObjectFromGUID(game_board)
    gameboard.createButton({
        click_function = 'assets1',
        label = 'Restock',
        font_size = 300,
        position = {-21.3, 0.1, 13},
        width = 1500,
        height = 500
    })
    gameboard.createButton({
        click_function = 'assets2',
        label = 'Restock',
        font_size = 300,
        position = {-17.5, 0.1, 13},
        width = 1500,
        height = 500
    })
    gameboard.createButton({
        click_function = 'assets3',
        label = 'Restock',
        font_size = 300,
        position = {-13.8, 0.1, 13},
        width = 1500,
        height = 500
    })
    gameboard.createButton({
        click_function = 'assets4',
        label = 'Restock',
        font_size = 300,
        position = {-10, 0.1, 13},
        width = 1500,
        height = 500
    })
end

function assets1()
    local placed = getObjectFromGUID("2de33d")
    if #placed.getObjects() > 1 then
        return
    end
    local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 21.5, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function assets2()
    local placed = getObjectFromGUID("f24880")
    if #placed.getObjects() > 1 then
        return
    end
    local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 17.6, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function assets3()
    local placed = getObjectFromGUID("025205")
    if #placed.getObjects() > 1 then
        return
    end
    local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 13.8, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function assets4()
    local placed = getObjectFromGUID("80933e")
    if #placed.getObjects() > 1 then
        return
    end
    local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 10, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function startGame(a, b)
    setupToken = getObjectFromGUID("a2f924")
    current_pos = setupToken.getPosition()
    setupToken.setPositionSmooth({current_pos.x, current_pos.y + 500, current_pos.z + 100}, false, true) -- move the setup button 500 up and +z

    UI.show("SetupPanel")
    UI.setAttribute("SetupPanel", "active", "true")
    initSelectedExpansions()
    updatePreludeToggleState()
    updatePSToggleState()
    updateAllAncientButtonsState()
end

function initSelectedExpansions()
    for i = 1, #extension_codes do
        exp = extension_codes[i]
        if selected_expansions[exp] and selected_expansions[exp] == "true" then
            UI.setAttribute(exp, "isOn", "true")
        else
            UI.setAttribute(exp, "isOn", "false")
        end

        -- selected_expansions[exp] = string.lower(UI.getAttribute(exp, "isOn"))
    end
end

function cancelSetup(a, b)
    UI.hide("SetupPanel")
    current_pos = setupToken.getPosition()
    setupToken.setPositionSmooth({current_pos.x, current_pos.y - 500, current_pos.z - 100}, false, true) -- move the setup button 500 down and -z
end

function hideSetupPanel(a, b)
    UI.hide("SetupPanel")
    UI.setAttribute("SetupPanel", "active", "false")
end

--[[
  options = getOptions()
  if tonumber(options.prelude) == 1 then
    getPrelude()
  end
  randomAncient()
  gameStarted = true
end]] --

function randomOfficialAncient()
    local allAncients = {}
    for i = 1, #extension_codes do
        exp = extension_codes[i]
        if selected_expansions[exp] == "true" then
            ancients = ancients_by_expansion[exp]
            for j = 1, #ancients do
                table.insert(allAncients, ancients[j])
            end
        end
    end

    setupAncient(allAncients[math.random(#allAncients)])
end

function randomFanAncient()
    local fanAncients = ancients_by_expansion["EHX1"];
    setupAncient(fanAncients[math.random(#fanAncients)])
end

function mysticRuins(prelude)
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(mystic_bag)
    local mysticDeck = bag.takeObject({
        position = {25.41, 1.09, 24.44},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {25.41, 2.09, 24.44},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    if prelude == true then
        bag.takeObject({
            position = {pos.x + 23.5, 1.4, pos.z - 25.5},
            rotation = {0, 90, 0},
            callback_owner = Global
        })
        bag.takeObject({
            position = {pos.x + 23.5, 1.2, pos.z - 25.5},
            rotation = {0, 90, 0},
            callback_owner = Global
        })
    end
    mysticDeck.shuffle()
    slowSpawnNextMysticRuins()
end

function nyarla()
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(nyarla_bag)
    bag.takeObject({
        position = {60.59, 0.96, 8.46},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {67.05, 0.96, 8.46},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {60.59, 0.96, 4.34},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {67.05, 0.96, 4.34},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {63.91, 0.87, 1.11},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
end

function eldritch()
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(eldritch_bag)
    bag.takeObject({
        position = {-5.11, 1.10, 20.71},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {1.81, 1.10, 20.71},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {8.73, 1.10, 20.72},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
    bag.takeObject({
        position = {15.68, 1.10, 20.72},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
end

function disaster()
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(disaster_bag)
    bag.takeObject({
        position = {16.41, 1.18, 24.36},
        rotation = {180, 0, 0},
        callback_owner = Global
    }).shuffle()
    bag.takeObject({
        position = {22.41, 1.11, 24.44},
        rotation = {180, 0, 0},
        callback_owner = Global
    }).shuffle()
    bag.takeObject({
        position = {22.41, 2.11, 24.44},
        rotation = {180, 0, 0},
        callback_owner = Global
    })
end

function egyptSide(prelude)
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(pyramid_bag)
    bag.takeObject({
        position = {pos.x, 1.01, pos.z - 25.5},
        rotation = {0, 180, 0},
        callback = 'callbackLock',
        callback_owner = Global
    })
    local tokens = searchForIn('Tokens', bag, {
        position = {50, 1, 0}
    })
    searchForIn('Egypt', bag, {
        position = {pos.x + 13.5, 1, pos.z - 21},
        rotation = {180, 0, 0}
    })
    searchForIn('Africa', bag, {
        position = {pos.x + 13.5, 1, pos.z - 26.5},
        rotation = {180, 0, 0}
    })
    if prelude then
        searchForIn('Adventure', bag, {
            position = {pos.x + 21, 1, pos.z - 21},
            rotation = {180, 270, 0}
        })
        tokens.takeObject({
            position = {pos.x + 21, 3, pos.z - 21}
        })
    end
    egyptMonsters()
    local gatepos = getObjectFromGUID('96en34').getPosition()
    local cluepos = getObjectFromGUID('652d1t').getPosition()
    for i = 1, 3 do
        tokens.takeObject({
            position = {gatepos.x, 5, gatepos.z},
            rotation = {0, 180, 0}
        })
    end
    for i = 1, 6 do
        tokens.takeObject({
            position = {cluepos.x, 5, cluepos.z}
        })
    end
    Wait.frames(function()
        shuffleDeck('96en34')
    end, 200)
    Wait.frames(function()
        shuffleDeck('652d1t')
    end, 200)
end

function DreamSide(prelude)
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(dream_bag)
    local dreamPos = {pos.x, 1.01, pos.z - 30.9}
    local dreamBoard = bag.takeObject({
        guid = "0f9802", -- Dream board id
        position = dreamPos,
        rotation = {0, 270, 0},
        callback_function = (function(spawnedObject)
            Wait.frames(function()
                spawnedObject.setLock(true)
            end, 60)
        end)
    })

    local tokens = searchForIn('Tokens', bag, {
        position = {50, 1, 0}
    })
    searchForIn('Dream Quest', bag, {
        position = {pos.x + 10.6, 1, pos.z - 21},
        rotation = {180, 0, 0}
    }).shuffle()
    searchForIn('Dreamlands', bag, {
        position = {pos.x + 10.6, 1, pos.z - 26.5},
        rotation = {180, 0, 0}
    })
    if prelude == true then
        searchForIn('Otherworldly Dreams', bag, {
            position = {pos.x + 25, 1, pos.z - 21},
            rotation = {180, 270, 0}
        })
    end
    dreamMonsters()
    tokens.takeObject({
        position = {pos.x + 10.6, 2, pos.z - 21}
    })
    tokens.takeObject({
        position = {pos.x + 25, 2, pos.z - 21}
    })
    tokens.takeObject({
        position = {pos.x + 17, 1, pos.z - 27},
        rotation = {0, 180, 0}
    })
    tokens.takeObject({
        position = {pos.x + 25, 1, pos.z - 27},
        rotation = {0, 180, 0}
    })
    tokens.takeObject({
        position = {pos.x + 33, 1, pos.z - 27},
        rotation = {0, 180, 0}
    })

    boardLocations["Unknown Kadath"] = {dreamPos[1] - 0.2199687446, dreamPos[3] + 10.3428314}
    boardLocations["The Enchanted Woods"] = {dreamPos[1] - 4.943246, dreamPos[3] + 6.526412871}
    boardLocations["Celephais"] = {dreamPos[1] + 4.266059919, dreamPos[3] + 5.9491883}
    boardLocations["Ulthar"] = {dreamPos[1] - 4.2933176, dreamPos[3] + 1.694925738}
    boardLocations["Dylath-Leen"] = {dreamPos[1] + 2.617099265, dreamPos[3] + 0.1377310187}
    boardLocations["The Underworld"] = {dreamPos[1] - 5.145058303, dreamPos[3] - 6.512132792}
    boardLocations["The Moon"] = {dreamPos[1] + 5.245887471, dreamPos[3] - 5.530074}

    printToAll("Don't forget to setup the dream gates", "White")
    local gatepos = getObjectFromGUID('96en34').getPosition()
    local cluepos = getObjectFromGUID('652d1t').getPosition()
    for i = 1, 3 do
        tokens.takeObject({
            position = {gatepos.x, 5, gatepos.z},
            rotation = {0, 180, 0}
        })
    end
    for i = 1, 7 do
        tokens.takeObject({
            position = {cluepos.x, 5, cluepos.z},
            rotation = {0, 0, 0}
        })
    end

    slowSpawnNextDreamQuest()
end

function dreamMonsters()
    table.insert(ancient.monsters, 'Zoog')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Ghoul')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Moon-Beast')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Nightgaunt')
    table.insert(ancient.monsters, 1)
    setAsideMonsters()
end

function egyptMonsters()
    table.insert(ancient.monsters, 'Sand Dweller')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Mummy')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Spawn of Sebak')
    table.insert(ancient.monsters, 1)
    setAsideMonsters()
end
function antSide()
    local pos = getObjectFromGUID(game_board).getPosition()
    local bag = getObjectFromGUID(ant_bag)
    bag.takeObject({
        position = {pos.x, 1.01, pos.z - 25.5},
        rotation = {0, 180, 0},
        callback = 'callbackLock',
        callback_owner = Global
    }).interactable = true
    local tokens = searchForIn('Tokens', bag, {
        position = {50, 1, 0}
    })
    searchForIn('Mountains', bag, {
        position = {13.34, 1.15, -21.34},
        rotation = {180, 0, 0}
    })
    searchForIn('Outpost', bag, {
        position = {13.29, 1.07, -16.43},
        rotation = {180, 0, 0}
    })
    searchForIn('Adventure', bag, {
        position = {pos.x + 21, 1, pos.z - 21},
        rotation = {180, 270, 0}
    })
    searchForIn('Research', bag, {
        position = {13.36, 1.15, -26.22},
        rotation = {180, 0, 0}
    })
    antMonsters()
    tokens.takeObject({
        position = {pos.x + 21, 3, pos.z - 21}
    })
    local gatepos = getObjectFromGUID('96en34').getPosition()
    local cluepos = getObjectFromGUID('652d1t').getPosition()
    for i = 1, 3 do
        tokens.takeObject({
            position = {gatepos.x, 5, gatepos.z},
            rotation = {0, 180, 0}
        })
    end
    for i = 1, 6 do
        tokens.takeObject({
            position = {cluepos.x, 5, cluepos.z}
        })
    end
end

function antMonsters()
    table.insert(ancient.monsters, 'Elder Thing')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Giant Penguin')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Shoggoth')
    table.insert(ancient.monsters, 1)
    table.insert(ancient.monsters, 'Shoggoth')
    table.insert(ancient.monsters, 1)
    setAsideMonsters()
end

ancient = {}
ancient.mythos = {}
ancient.mythos.stage1 = {}
ancient.mythos.stage2 = {}
ancient.mythos.stage3 = {}
ancient.monsters = {}
ancient.expansion = ""

function setupAncient(name)
    gameStarted = true
    ancient_bag = searchForIn(name, ancients_bag, {
        position = {50, 5, 20}
    })
    if name == 'Hastur' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 5
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Byakhee', 1}
        ancient.doom = 11
    elseif name == 'Nyarlathotep' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 12
        nyarla()
    elseif name == 'Antediluvium' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Cultist', 5, 'Deep One', 1}
        ancient.doom = 13
        mysticRuins()
        local pos = getObjectFromGUID(game_board).getPosition()
        getObjectFromGUID(et_bag).takeObject({
            position = {22.88, 1.10, 18.59}
        })
        local pos = getObjectFromGUID(game_board).getPosition()
        getObjectFromGUID(et_bag).takeObject({
            position = {25.93, 1.10, 19.41}
        })
    elseif name == 'The Mi-go' then
        ancient.mythos.stage1.green = 2
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Cultist', 6, 'Mi-go', 1}
        ancient.doom = 12
    elseif name == 'The King in Yellow' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Cultist', 14, 'Riot', 1}
        ancient.doom = 8
    elseif name == 'Shudde Mell' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 4
        ancient.mythos.stage2.yellow = 2
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 15
        disaster()
        eldritch()
    elseif name == 'Ghatanothoa' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 1
        ancient.monsters = {'Mummy', 1, 'Mi-go', 1, 'Lloigor', 1}
        ancient.doom = 13
    elseif name == 'Y-Golonac' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Maniac', 1, 'Ghoul', 2}
        ancient.doom = 13
    elseif name == 'Hypnos' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        -- ancient.monsters = {'Zoog', 1, 'Ghoul', 1, 'Moon-Beast', 1, 'Nightgaunt', 1}
        ancient.doom = 12
        DreamSide()
    elseif name == 'Atlach-Nacha' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 2
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Leng Spider', 1}
        ancient.doom = 9
    elseif name == 'Yog-Sothoth' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 14
    elseif name == 'ElderThings' then
        ancient.mythos.stage1.green = 2
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 4
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 16
        antSide()
    elseif name == 'Azathoth' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 15
        local pos = getObjectFromGUID(game_board).getPosition()
        getObjectFromGUID(et_bag).takeObject({
            position = {24.00, 1.10, 20.49}
        })
    elseif name == 'Syzygy' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 5
        ancient.mythos.stage3.blue = 0
        ancient.doom = 13
        mysticRuins()
    elseif name == 'Ithaqua' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 4
        ancient.mythos.stage2.yellow = 2
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Gnoph-Keh', 1, 'Wendigo', 1}
        ancient.doom = 13
    elseif name == 'Shub-Niggurath' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 2
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Goat Spawn', 2, 'Ghoul', 2, 'Dark Young', 1}
        ancient.doom = 13
    elseif name == 'Yig' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 2
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Cultist', 6, 'Serpent People', 1}
        ancient.doom = 10
    elseif name == 'Abhoth' then
        ancient.mythos.stage1.green = 1
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 1
        ancient.mythos.stage2.green = 3
        ancient.mythos.stage2.yellow = 2
        ancient.mythos.stage2.blue = 1
        ancient.mythos.stage3.green = 2
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Cultist', 8}
        ancient.doom = 14
    elseif name == 'Nephren-Ka' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 1
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.doom = 12
        egyptSide()
    elseif name == 'Cthulhu' then
        ancient.mythos.stage1.green = 0
        ancient.mythos.stage1.yellow = 2
        ancient.mythos.stage1.blue = 2
        ancient.mythos.stage2.green = 1
        ancient.mythos.stage2.yellow = 3
        ancient.mythos.stage2.blue = 0
        ancient.mythos.stage3.green = 3
        ancient.mythos.stage3.yellow = 4
        ancient.mythos.stage3.blue = 0
        ancient.monsters = {'Deep One', 1, 'Star Spawn', 1}
        ancient.doom = 12
    end
    shuffleDeck("8a60b0")
    shuffleDeck("eb8351")
    shuffleDeck("96ae9b")
    shuffleDeck("3c22ea")
    shuffleDeck("87bd42")
    shuffleDeck("8e0b7c")
    shuffleDeck("ee2fae")
    shuffleDeck("b150a1")
    shuffleDeck("44cb4b")
    shuffleDeck("ecab11")
    shuffleDeck("82af68")
    shuffleDeck("b2d49d")
    shuffleDeck("2bbb46")
    shuffleDeck("d90c42")
    shuffleDeck("hz6n3c")
    shuffleDeck("ee3091")
    shuffleDeck("979d7b")
    shuffleDeck("4d308a")
    shuffleDeck("95073f")
    Wait.frames(function()
        shuffleDeck('96en34')
    end, 200)
    Wait.frames(function()
        shuffleDeck('652d1t')
    end, 200)
    Wait.frames(function()
        spawnNextExpedition()
    end, 10)
    getPlayerCount()

    setupAncient2(ancient_bag)
    filterExpansions()
    assets1()
    assets2()
    assets3()
    assets4()
    -- Prelude setup needs to happen before mythos deck setup
    -- certain preludes require cards from mythos deck
    if shouldGetPrelude == "True" then
        getPrelude()
    end

    setupMythosDeck()
    if not moreset then
        setAsideMonsters()
    end

    hideSetupPanel()
end

function filterExpansions()
    discardbag = getObjectFromGUID(discard_bag)

    function filterSingleFilter(ext)
        matchGmFn = function(v)
            return string.find(string.lower(v.gm_notes), string.lower(ext))
        end
        local callbackFn = function(obj)
            discardbag.putObject(obj)
        end
        local discard_offset = 1

        -- skip deck filtering for user expansion
        if ext ~= "EHX1" then
            for k, v in pairs(decks) do
                -- spawn a separate thread/coroutine for each deck in order to speed things up
                local co = coroutine.create(function(cparams)
                    local deckGuid = cparams.deck
                    local ext = cparams.ext
                    local offset = cparams.offset

                    local deck = getObjectFromGUID(deckGuid)
                    local lpos = discardbag.getPosition()
                    lpos.y = lpos.y + 4 + offset
                    local callbackFn = function(obj)
                        discardbag.putObject(obj)
                    end
                    local res = takeFromCollection(deck, matchGmFn, lpos, callbackFn)
                end)
                hr = coroutine.resume(co, {
                    deck = v,
                    ext = ext,
                    offset = discard_offset
                })
                if not hr then
                    print("Failed to start coroutine for deck: " .. k)
                end

                discard_offset = discard_offset + 1
            end
        end

        local lpos = discardbag.getPosition()
        lpos.y = lpos.y + 4 + discard_offset
        monsterbag = getObjectFromGUID(monster_bag)
        takeFromCollection(monsterbag, matchGmFn, lpos, callbackFn)

        lpos.y = lpos.y + 1
        epicmonsterbag = getObjectFromGUID(epic_monster_bag)
        takeFromCollection(epicmonsterbag, matchGmFn, lpos, callbackFn)

        lpos.y = lpos.y + 4
        gatesbag = getObjectFromGUID(gates_bag)
        takeFromCollection(gatesbag, matchGmFn, lpos, callbackFn)
    end

    local filterStr = getExpansionFilter()
    if filterStr then
        filterSingleFilter(filterStr)
    end

    if not isUserExpansionsEnabled() then
        filterSingleFilter("EHX1")
    end

end

function getExpansionFilter()
    local filterStr = "EH0["
    local needFilter = false
    for i = 1, #extension_codes do
        local ext = extension_codes[i]
        if selected_expansions[ext] == "false" then
            needFilter = true
            filterStr = filterStr .. i
        end
    end
    filterStr = filterStr .. "]"

    if needFilter then
        return filterStr
    else
        return nil
    end
end

function isUserExpansionsEnabled()
    local enable = true
    -- enable user extensions only if all base game extensions are enabled

    for i = 1, #extension_codes do
        local ext = extension_codes[i]
        if selected_expansions[ext] == "false" then
            enable = false
            break
        end
    end

    return enable
end

function isExpansionEnabled(exp)
    if exp == "EHX1" then
        return isUserExpansionsEnabled()
    else
        return selected_expansions[exp] == "true"
    end
end

function isPreludeExist()
    local expansions_with_prelude = {"EH03", "EH04", "EH05", "EH06", "EH07", "EH08", "EH09"}
    for i = 1, #expansions_with_prelude do
        if selected_expansions[expansions_with_prelude[i]] == "true" then
            return true
        end
    end

    return false
end

function isPSExist()
    local expansions_with_ps = {"EH09"}
    for i = 1, #expansions_with_ps do
        if selected_expansions[expansions_with_ps[i]] == "true" then
            return true
        end
    end

    return false
end

function getPrelude()
    local prelude = searchForIn('', prelude_deck, {
        callback_owner = Global,
        position = {0, 2, 0},
        rotation = {180, 0, 180}
    })
    if prelude.getGUID() == '95wn6m' then
        moreset = true
        antMonsters()
    elseif prelude.getGUID() == 'qxkqjd' then
        moreset = true
        egyptMonsters()
    end
end

function setScale(a)
    -- 666 lol
    a.setScale({6, 6, 6})
    a.lock()
end

function getPlayerCount()
    local pos = getObjectFromGUID(game_board).getPosition()
    local num_players = tonumber(manualPlayerValue)
    if num_players == 0 then
        num_players = #getSeatedPlayers()
    end
    local seated = #getSeatedPlayers()
    print("Remaining setup steps:")
    print("Select investigators (if not done already)")
    print("Check prelude card (if present) and setup appropriately")
    print("Setup the first gates and clues using the setup button again")
    print("Draw first mystery")
    local player_num_ref = getObjectFromGUID('d8b7a4')
    local player_guid = {'4576dr', '7ojp91', 's2rwq2', 'olbcuq', 't117wb', '36tlad', 'ky9tj2', 'hutw2i'}
    player_num_ref.takeObject({
        position = {pos.x + 34, 1, pos.z + 25},
        rotation = {0, 180, 0},
        guid = player_guid[num_players]
    })

    local current_pos = setupToken.getPosition()
    setupToken.setPositionSmooth({current_pos.x, current_pos.y - 500, current_pos.z - 100}, false, true) -- move the setup button 500 down and -z

    setupToken.removeButton(0)

    setupToken.createButton({
        click_function = 'spawnStartingGates',
        label = 'Place Starting Gates',
        font_size = 100,
        position = {0, 0.30, 0},
        width = 1000,
        height = 200
    })
end

function spawnStartingGates()
    local num_players = tonumber(manualPlayerValue)
    if num_players == 0 then
        num_players = #getSeatedPlayers()
    end
    local seated = #getSeatedPlayers()
    spawnAppropriateClues(num_players)
    spawnAppropriateGates(num_players)

    local current_pos = setupToken.getPosition()
    setupToken.setPositionSmooth({current_pos.x, current_pos.y + 500, current_pos.z - 100}, false, true) -- move the setup button 500 down and -z
end

function spawnAppropriateClues(numplayers)
    if numplayers >= 1 then
        spawnClues()
    end
    if numplayers >= 3 then
        spawnClues()
    end
    if numplayers >= 5 then
        spawnClues()
    end
    if numplayers >= 7 then
        spawnClues()
    end
end

function spawnAppropriateGates(numplayers)
    if numplayers >= 1 then
        spawnGates()
    end
    if numplayers >= 5 then
        spawnGates()
    end
end

function callbackLock(a)
    a.unlock()
end

function setupAncient2(bag)
    local doom_tracker = getObjectFromGUID(doom_track)
    local pos = getObjectFromGUID(game_board).getPosition()
    doom_tracker.setPosition({pos.x + 20.2 - (2.31 * ancient.doom), 1.3, pos.z + 16.67})

    function filterMyteryDeck(obj)
        filterStr = getExpansionFilter()
        if filterStr then
            discardbag = getObjectFromGUID(discard_bag)
            callbackFn = function(obj)
                discardbag.putObject(obj)
            end
            position = discardbag.getPosition()
            position["y"] = position["y"] + 10
            matchGmFn = function(v)
                return string.find(string.lower(v.gm_notes), string.lower(filterStr))
            end
            takeFromCollection(obj, matchGmFn, position, callbackFn)
        end
        obj.shuffle()
    end

    function filterResearchDeck(obj)
        filterStr = getExpansionFilter()
        if filterStr then
            discardbag = getObjectFromGUID(discard_bag)
            callbackFn = function(obj)
                discardbag.putObject(obj)
            end
            position = discardbag.getPosition()
            position["y"] = position["y"] + 10
            matchGmFn = function(v)
                return string.find(string.lower(v.gm_notes), string.lower(filterStr))
            end
            takeFromCollection(obj, matchGmFn, position, callbackFn)
        end
        obj.shuffle()
    end

    bag.takeObject({
        position = {pos.x + 34, 1, pos.z + 10},
        rotation = {0, 180, 0},
        callback = 'callbackLock',
        callback_owner = Global
    })
    searchForIn('Research', bag, {
        position = {10.41, 1.11, 24.44},
        rotation = {180, 0, 0}
    }, filterResearchDeck)
    searchForIn('Mystery', bag, {
        position = {pos.x + 63.8, 1, pos.z + 13.5},
        rotation = {180, 270, 0}
    }, filterMyteryDeck)
    searchForIn('', bag, {
        position = {pos.x + 42, 1, 9},
        rotation = {180, 0, 0}
    })
    searchForIn('', bag, {
        position = {pos.x + 42, 1, 14},
        rotation = {180, 0, 0}
    })
    searchForIn('', bag, {
        position = {pos.x + 42, 1, 19},
        rotation = {180, 0, 0}
    })
    searchForIn('', bag, {
        position = {pos.x + 42, 1, 24},
        rotation = {180, 0, 0}
    })
end

function setAsideMonsters()
    for i = 1, #ancient.monsters, 2 do
        for j = 1, ancient.monsters[i + 1] do
            searchForIn(ancient.monsters[i], monster_bag, {
                position = {0, 500, 0},
                rotation = {180, 0, 0}
            }, function(monster)
                origin[monster.getGUID()] = nil
                ancient_bag.putObject(monster)
            end)
        end
    end
end

function setupMythosDeck()
    local pos = getObjectFromGUID(game_board).getPosition()
    -- local diff = {split(options.difficulty,',')}

    local diff = {}
    if progressiveMythos == "True" then
        -- broadcastToAll("Progressive mythos included")
        diff[1] = 1
    else
        local currentTableIndex = 1
        if shouldIncludeEasyMythos == "True" then
            -- broadcastToAll("Easy mythos included")
            diff[currentTableIndex] = 1
            currentTableIndex = currentTableIndex + 1
        end
        if shouldIncludeMediumMythos == "True" then
            -- broadcastToAll("Medium mythos included")
            diff[currentTableIndex] = 2
            currentTableIndex = currentTableIndex + 1
        end
        if shouldIncludeHardMythos == "True" then
            -- broadcastToAll("Hard mythos included")
            diff[currentTableIndex] = 3
        end
    end

    -- for i=1,#diff do
    --   print(diff[i])
    -- end

    local hgm = 'qszvkn'
    local mgm = 'vxiwyn'
    local egm = 'uc2b43'
    local hym = '8c13f8'
    local mym = 'n621fe'
    local eym = 'cr05o1'
    local hbm = 'k39546'
    local mbm = '6g97ke'
    local ebm = '0c9452'
    local blue = {ebm, mbm, hbm}
    local green = {egm, mgm, hgm}
    local yellow = {eym, mym, hym}
    if shouldIncludeEasyMythos == "True" and shouldIncludeMediumMythos == "True" and shouldIncludeHardMythos == "False" then
        blue = {ebm, mbm}
        green = {egm, mgm}
        yellow = {eym, mym}
    elseif shouldIncludeEasyMythos == "True" and shouldIncludeMediumMythos == "False" and shouldIncludeHardMythos ==
        "False" then
        blue = {ebm}
        green = {egm}
        yellow = {eym}
    elseif shouldIncludeEasyMythos == "True" and shouldIncludeMediumMythos == "False" and shouldIncludeHardMythos ==
        "True" then
        blue = {ebm, hbm}
        green = {egm, hgm}
        yellow = {eym, hym}
    elseif shouldIncludeEasyMythos == "False" and shouldIncludeMediumMythos == "False" and shouldIncludeHardMythos ==
        "True" then
        blue = {hbm}
        green = {hgm}
        yellow = {hym}
    elseif shouldIncludeEasyMythos == "False" and shouldIncludeMediumMythos == "True" and shouldIncludeHardMythos ==
        "True" then
        blue = {mbm, hbm}
        green = {mgm, hgm}
        yellow = {mym, hym}
    elseif shouldIncludeEasyMythos == "False" and shouldIncludeMediumMythos == "True" and shouldIncludeHardMythos ==
        "False" then
        blue = {mbm}
        green = {mgm}
        yellow = {mym}
    end
    local foundItem = false
    local failCount = 0
    local stage_offset = 0
    local blueMessageSent = 0
    local greenMessageSent = 0
    local yellowMessageSent = 0
    for k, v in pairs(ancient.mythos) do
        if progressiveMythos == "True" then
            if k == "stage1" then
                blue = {ebm}
                green = {egm}
                yellow = {eym}
            elseif k == "stage2" then
                blue = {mbm}
                green = {mgm}
                yellow = {mym}
            else
                blue = {hbm}
                green = {hgm}
                yellow = {hym}
            end
        end

        for i, j in pairs(v) do
            if i == 'blue' then
                for a = 1, j do
                    foundItem = false
                    failcount = 0
                    local randomNum = tonumber(diff[math.random(#diff)])
                    while foundItem == false do
                        foundItem = searchForIn('', blue[randomNum], {
                            position = {pos.x + 29.5 + stage_offset, 1.5, 3},
                            rotation = {180, 0, 0}
                        })
                        if randomNum == 3 then
                            randomNum = 1
                        else
                            randomNum = randomNum + 1
                        end
                        failcount = failcount + 1
                        if failcount == 4 then
                            if blueMessageSent == 0 then
                                printToAll("Not enough " .. i ..
                                               " mythos cards with selected difficulty and expansions. Please manually complete decks with remaining mythos cards, or reload with different settings.",
                                    {
                                        r = 0,
                                        g = 0,
                                        b = 1
                                    })
                                blueMessageSent = 1
                            end
                            break
                        end
                    end
                end
            elseif i == 'green' then
                for a = 1, j do
                    foundItem = false
                    failcount = 0
                    local randomNum = tonumber(diff[math.random(#diff)])
                    while foundItem == false do
                        foundItem = searchForIn('', green[randomNum], {
                            position = {pos.x + 29.5 + stage_offset, 1.5, 3},
                            rotation = {180, 0, 0}
                        })
                        if randomNum == 3 then
                            randomNum = 1
                        else
                            randomNum = randomNum + 1
                        end
                        failcount = failcount + 1
                        if failcount == 4 then
                            if greenMessageSent == 0 then
                                printToAll("Not enough " .. i ..
                                               " mythos cards with selected difficulty and expansions. Please manually complete decks with remaining mythos cards, or reload with different settings.",
                                    {
                                        r = 0,
                                        g = 1,
                                        b = 0
                                    })
                                greenMessageSent = 1
                            end
                            break
                        end
                    end
                end
            elseif i == 'yellow' then
                for a = 1, j do
                    foundItem = false
                    failcount = 0
                    local randomNum = tonumber(diff[math.random(#diff)])
                    while foundItem == false do
                        foundItem = searchForIn('', yellow[randomNum], {
                            position = {pos.x + 29.5 + stage_offset, 1.5, 3},
                            rotation = {180, 0, 0}
                        })
                        if randomNum == 3 then
                            randomNum = 1
                        else
                            randomNum = randomNum + 1
                        end
                        failcount = failcount + 1
                        if failcount == 4 then
                            if yellowMessageSent == 0 then
                                printToAll("Not enough " .. i ..
                                               " mythos cards with selected difficulty and expansions. Please manually complete decks with remaining mythos cards, or reload with different settings.",
                                    {
                                        r = 1,
                                        g = 0.91,
                                        b = 0
                                    })
                                yellowMessageSent = 1
                            end
                            break
                        end
                    end
                end
            end
        end
        stage_offset = stage_offset + 3.5
    end
end

function getName(container, item)
    if (container.tag == "Scripting") then
        print(item)
        return item.getName()
    else
        return item.name
    end
end

function searchForIn(object, containerguid, params2, callbackFn)
    params2.guid = '000000'
    params2.callback_function = callbackFn
    local deckorbag
    local guids = {}
    if type(containerguid) == 'string' then
        deckorbag = getObjectFromGUID(containerguid)
    else
        deckorbag = containerguid
    end
    local obj = nil
    if deckorbag == nil then
        return false
    else
        for k, v in pairs(deckorbag.getObjects()) do
            if object == "" or string.lower(getName(deckorbag, v)) == string.lower(object) then
                table.insert(guids, v)
            end
        end

        if #guids == 0 then
            for k, v in pairs(deckorbag.getObjects()) do
                if object == "" or string.find(string.lower(getName(deckorbag, v)), string.lower(object)) then
                    table.insert(guids, v)
                end
            end
        end

        if #guids > 0 then
            local item = guids[math.random(#guids)]
            if deckorbag.tag == "Scripting" then
                item.setPosition(params2.position)
                if deckorbag.getGUID() == "f97ec7" then
                    Wait.frames(function()
                        assets1()
                        assets2()
                        assets3()
                        assets4()
                    end, 5)
                end
                return item
            end
            params2.guid = item.guid
            return deckorbag.takeObject(params2)
        else
            -- print("not enough of this object")
            return false
        end
    end
end

function searchForInExact(object, containerguid)
    local deckorbag
    if type(containerguid) == 'string' then
        deckorbag = getObjectFromGUID(containerguid)
    else
        deckorbag = containerguid
    end
    local obj = nil
    local foundIndex = nil
    if deckorbag == nil then
        return false
    else
        for k, v in pairs(deckorbag.getObjects()) do
            if v.nickname == object then
                foundIndex = v.index
                break
            end
        end
        if foundIndex == nil then
            return false
        else
            return deckorbag.takeObject({
                index = foundIndex
            })
        end
    end
end

function takeFromCollection(collection, matchFn, matchPosition, callbackFn)
    if collection ~= nil and collection.getObjects() ~= nil then
        matchObj = nil
        matchesAll = true

        for k, v in pairs(collection.getObjects()) do
            if not (matchFn(v)) then
                matchesAll = false
                break
            end
        end

        if matchesAll then
            -- Take whole deck
            collection.setPosition(matchPosition)
            matchObj = collection
            callbackFn(matchObj)
        else
            -- Take only matches out of the deck, and form new deck
            params = {
                top = false,
                position = matchPosition
            }

            for k, v in pairs(collection.getObjects()) do
                if (matchFn(v)) then
                    params.guid = v.guid
                    params.callback_function = callbackFn
                    newObj = collection.takeObject(params)
                end
            end
        end

        return matchObj
    else
        return nil
    end
end

function split(input, split)
    local returnarr = {}
    local i = 1
    for str in string.gmatch(input, '([^' .. split .. ']+)') do
        returnarr[i] = str
        i = i + 1
    end
    return returnarr
end

function getRulesText()
    for k, v in pairs(getNotebookTabs()) do
        if v.color == 'White' then
            return v.body
        end
    end
end

function getOptions()
    local returnarr = {}
    local lines = split(getRulesText(), '\n')
    for k, v in pairs(lines) do
        local optparam = split(v, '=')
        returnarr[optparam[1]] = optparam[2]
    end
    return returnarr
end

-- Specific Ancient One SetupPanel
function setupAbhoth()
    setupAncient("Abhoth")
end
function setupAntediluvium()
    setupAncient("Antediluvium")
end
function setupAtlachNacha()
    setupAncient("Atlach-Nacha")
end
function setupAzathoth()
    setupAncient("Azathoth")
end
function setupCthulhu()
    setupAncient("Cthulhu")
end
function setupElderThings()
    setupAncient("ElderThings")
end
function setupHastur()
    setupAncient("Hastur")
end
function setupHypnos()
    setupAncient("Hypnos")
end
function setupIthaqua()
    setupAncient("Ithaqua")
end
function setupNephrenKa()
    setupAncient("Nephren-Ka")
end
function setupNyarlathotep()
    setupAncient("Nyarlathotep")
end
function setupShubNiggurath()
    setupAncient("Shub-Niggurath")
end
function setupShuddeMell()
    setupAncient("Shudde Mell")
end
function setupSyzygy()
    setupAncient("Syzygy")
end
function setupYig()
    setupAncient("Yig")
end
function setupYogSothoth()
    setupAncient("Yog-Sothoth")
end
function setupGhatanothoa()
    setupAncient("Ghatanothoa")
end
function setupTheKingInYellow()
    setupAncient("The King in Yellow")
end
function setupTheMigo()
    setupAncient("The Mi-go")
end
function setupYGolonac()
    setupAncient("Y-Golonac")
end

function updatePreludeToggleState()
    if isPreludeExist() then
        UI.setAttribute("preludeToggle", "interactable", "true")
        UI.show("preludeToggle")
    else
        UI.setAttribute("preludeToggle", "isOn", "false")
        UI.setAttribute("preludeToggle", "interactable", "false")
        shouldGetPrelude = "False"
    end
end

function updatePSToggleState()
    if isPSExist() then
        UI.setAttribute("personalStoriesToggle", "interactable", "true")
        UI.show("personalStoriesToggle")
    else
        UI.setAttribute("personalStoriesToggle", "isOn", "false")
        UI.setAttribute("personalStoriesToggle", "interactable", "false")
        shouldGetPersonalStory = "false"
    end
end

function updateAllAncientButtonsState()
    for i = 1, #extension_codes do
        updateAncientButtonState(extension_codes[i])
    end
end

function updateAncientButtonState(exp)
    local ancients = ancients_by_expansion[exp]
    local buttonInteractableVal = selected_expansions[exp]
    local opacityVal = "100"
    if buttonInteractableVal == "true" then
        opacityVal = "0"
    end

    for i = 1, #ancients do
        local buttonName = ancients[i] .. "SetupButton"
        UI.setAttribute(buttonName, "interactable", buttonInteractableVal)
        UI.setAttribute(buttonName, "opacity", opacityVal)
    end

    -- update fan created ancients
    if isUserExpansionsEnabled() then
        buttonInteractableVal = "true"
        opacityVal = "0"
    else
        buttonInteractableVal = "false"
        opacityVal = "100"
    end
    ancients = ancients_by_expansion["EHX1"]
    for i = 1, #ancients do
        buttonName = ancients[i] .. "SetupButton"
        UI.setAttribute(buttonName, "interactable", buttonInteractableVal)
        UI.setAttribute(buttonName, "opacity", opacityVal)
    end
    UI.setAttribute("RandomFanAncientOneSetupButton", "interactable", buttonInteractableVal)
    UI.setAttribute("RandomFanAncientOneSetupButton", "opacity", opacityVal)
end

function expansionValueChanged(player, value, id)
    selected_expansions[id] = string.lower(value)
    updatePreludeToggleState()
    updatePSToggleState()
    updateAncientButtonState(id)
end

function preludeToggleValueChanged(sender, value)
    shouldGetPrelude = value
end

function personalStoriesToggleValueChanged(sender, value)
    shouldGetPersonalStory = value
end

function manualPlayerValueChanged(player, option, id)
    manualPlayerValue = option
end

function easyMythosToggleValueChanged(sender, value)
    shouldIncludeEasyMythos = value
    makeSureAtLeastMediumMythosIsSelected()
end

function mediumMythosToggleValueChanged(sender, value)
    shouldIncludeMediumMythos = value
    makeSureAtLeastMediumMythosIsSelected()
end

function hardMythosToggleValueChanged(sender, value)
    shouldIncludeHardMythos = value
    makeSureAtLeastMediumMythosIsSelected()
end

function progressiveMythosToggleValueChanged(sender, value)
    progressiveMythos = value
    makeSureAtLeastMediumMythosIsSelected()
end

function makeSureAtLeastMediumMythosIsSelected()
    if progressiveMythos == "True" then
        shouldIncludeEasyMythos = "False"
        shouldIncludeMediumMythos = "False"
        shouldIncludeHardMythos = "False"
        UI.setAttribute("easyMythosToggle", "isOn", "False")
        UI.setAttribute("mediumMythosToggle", "isOn", "False")
        UI.setAttribute("hardMythosToggle", "isOn", "False")
    elseif progressiveMythos == "False" and shouldIncludeEasyMythos == "False" and shouldIncludeMediumMythos == "False" and
        shouldIncludeHardMythos == "False" then
        UI.setAttribute("mediumMythosToggle", "isOn", "True")
    end
end

gameStarted = false
origin = {}

function onObjectLeaveContainer(container, object)
    if container ~= nil and object ~= nil and origin[object.getGUID()] == nil then
        origin[object.getGUID()] = container.getGUID()
    end
end

-- Hotkey stuff

onlyHotKey = {}

function registerHotKeys()
    addHotkey("disable numpad keys", disableNumpad)
    addHotkey("discard", discard)
    addHotkey("summon find cube", summonFindCube)
    addHotkey("summon find all cube", summonFindAllCube)
    addHotkey("kill investigator", killGuy)
end

function disableNumpad(color)
    local player = Player[color]
    onlyHotKey[player] = onlyHotKey[player] ~= true
end

function onScriptingButtonDown(index, color)
    local player = Player[color]
    if (onlyHotKey[player] ~= false) then
        local object = player.getHoverObject()
        local position = player.getPointerPosition()
        if index == 10 then
            discard(color, object)
        elseif index == 1 then
            summonFindCube(color, object, position)
        elseif index == 2 then
            summonFindAllCube(color, object, position)
        elseif index == 3 then
            killGuy(color, object)
        end
    end
end

function discard(color, object)
    if object ~= nil then
        local objectId = object.getGUID()
        local targetId = nil

        if objectId == "c3b704" then -- Discarded Artifacts
            targetId = "95073f" -- Artifacts
        elseif objectId == "94412b" then -- Discarded assets
            targetId = "ee3091" -- Assets
        elseif objectId == "31sza9" then -- Discarded clues
            targetId = "652d1t" -- Clues
        elseif objectId == "n2pra1" then -- Discarded gates
            targetId = "96en34" -- Gates
        end

        if targetId ~= nil then
            local target = getObjectFromGUID(targetId)
            for _, newObjId in ipairs(object.getObjects()) do
                local newObj = object.takeObject(newObjId)
                target.putObject(newObj)
            end
            target.shuffle()
        elseif object.getCustomObject() ~= nil and object.getCustomObject().stackable == true then
            object.destruct()
        else
            local containerId = origin[objectId]
            if containerId ~= nil then
                local position = getObjectFromGUID(containerId).getPosition()
                if containerId == "95073f" then -- Artifacts
                    containerId = "c3b704" -- Discarded Artifacts
                elseif containerId == "ee3091" then -- Assets
                    containerId = "94412b" -- Discarded assets
                elseif containerId == "652d1t" then -- Clues
                    containerId = "31sza9" -- Discarded clues
                elseif containerId == "96en34" then -- Gates
                    containerId = "n2pra1" -- Discarded gates
                elseif position.x > 60 and position.z > 38 then
                    containerId = "90f99a" -- Discarded mythos
                end
                local container = getObjectFromGUID(containerId)
                if container ~= nil then
                    container.putObject(object)
                    if container.tag == "Deck" then
                        container.shuffle()
                    end
                end
            end
        end
    end
end

function summonFindCube(color, object, position)
    summonCube(getObjectFromGUID("p42bff"), object, position)
end

function summonFindAllCube(color, object, position)
    summonCube(getObjectFromGUID("1c8601"), object, position)
end

function summonCube(cube, object, position)
    if object ~= nil then
        position = object.getPosition()
    end
    position.y = position.y + 2
    cube.setPosition(position)
end

function killGuy(color, object)
    if object ~= nil and object.tag == "Generic" then
        object.setRotation({90, 0, 0})
    end
end
