setup_token = 'a2f924'
assets_deck = 'ee3091'
boon_deck = '00c94d'
bane_deck = '4b5612'
spell_deck = '979d7b'
talent_deck = '00c94d'
u_assets_deck = 'hr2o1d'
pawn_bag = '5p189x'
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
}

local colorPalet={}
local referenceIndex=4
local playerColors={'White','Red','Orange','Purple','Green','Blue'}
local gameInProgressTxt="Game in progress"

local dice_img={Blessed="https://www.dropbox.com/s/enubsck66iokfw1/4ecb0e3bd24aadbd3cbe233913b14ff4.png?dl=1",Cursed="https://www.dropbox.com/s/zc7no801s3tz0yc/d1d133c91a56e3c8feee0cc0d3718a45.png?dl=1",Regular="https://www.dropbox.com/s/3ke4ty3cecljpty/0d20f1832e6cb67704f86ce937104b76.png?dl=1"}
local dice_tint={Blessed={80/255,225/255,109/255},Cursed={233/255,123/255,123/255},Regular={1,1,1}}
local dice_desc={Blessed="Blessed",Cursed="Cursed",Regular="Regular"}
local dice_match={Blessed="Regular",Cursed="Regular"}
local dice_matchRestore={Blessed="Blessed",Cursed="Cursed"}

-- Functions
-------------------------
function changeDiceAround(tab)
  card=tab[1]
  startPos=card.getPosition()
  selector=card.getName()
  for k,v in ipairs(getAllObjects()) do
    if v.tag=='Dice' and v.getDescription()==dice_match[selector] then
      dicePos=v.getPosition()
      distance=math.sqrt(((startPos[1]-dicePos[1])^2)+((startPos[2]-dicePos[2])^2)+((startPos[3]-dicePos[3])^2))
      if distance<=8 then
        card.call("registerMe", {d=v})
        v.setColorTint(dice_tint[selector])
        v.setDescription(dice_desc[selector])
        v.setCustomObject({type=1,image=dice_img[selector]})
        v.reload()
      end
    end
  end
end

function changeDice(tab)
  selector=tab[1]
  changed=tab[2]
  for k,g in pairs(changed) do
    v=getObjectFromGUID(g)
    if v!=nil and v.tag=='Dice' and v.getDescription()==dice_matchRestore[selector] then
      v.setColorTint(dice_tint.Regular)
      v.setDescription(dice_desc.Regular)
      v.setCustomObject({type=1,image=dice_img.Regular})
      v.reload()
    end
  end
end
-------------------------
reconingOn=false
reckoningStep=0
reconingList={"Reckoning","ReckAO","ReckMythos","ReckPosCond","ReckOver"}
reconingAnnouncement={"Reckoning step 1 of 4 - Monsters","Reckoning step 2  of 4 - Ancient One","Reckoning step 3 of 4 - Mythos cards","Reckoning step 4 of 4 - Possessions and Conditions","Reckoning ended"}

function markReconing(tab)
	reconingOn=true
	for k,v in ipairs(getAllObjects()) do
		v.highlightOff()
		if string.find(v.getDescription(), reconingList[(reckoningStep % # reconingList)+1]) then
			if v.tag!="Card" then
				v.highlightOn({1,0,0},300)
			else
				rot=v.getRotation()
				if reconingList[(reckoningStep % # reconingList)+1]!="ReckMythos" or (rot.x>340 or rot.x<20) and  (rot.z>340 or rot.z<20) then
					v.highlightOn({1,0,0},300)
				end
			end

		end
	end
broadcastToAll(reconingAnnouncement[(reckoningStep % # reconingList)+1], colorPalet.doom)
	reckoningStep=reckoningStep+1
end
------------------------
function searchGates(tab)
	winner="green"
	minDist=9999
	pl={{c="N", pos={23.99,20.49}},{c="E", pos={25.92,19.41}},{c="S",pos={24.78,17.51}},{c="W", pos={22.88,18.59}}}
	for k,v in pairs(pl) do
		dist=math.sqrt(((tab[1].getPosition().x-v.pos[1])^2)+((tab[1].getPosition().z-v.pos[2])^2))
		if dist<minDist then
			minDist=dist
			winner=v.c
		end
	end
	compass={N="green",E="blue",S="red",W="blue"}
	printToAll("Omen is " .. compass[winner], {0.5,0.5,0.5})
	for k,v in ipairs(getAllObjects()) do
		if v.tag=="Tile" and string.find(v.getName(), "Gates") then
			if string.find(string.lower(v.getName()), compass[winner]) then
				v.highlightOn({0,1,0},8)
			else
				v.highlightOff()
			end
		end
	end
end
------------------------

local function contains(table, val)
	for i=1,#table do
		if table[i] == val then
			return true
		end
	end
	return false
end

function offsetPos(v1,v2)
	return{x=v1.x+v2[1],y=v1.y+v2[2],z=v1.z+v2[3]}
end
----------------------------------------------
function getPlayerInvestigator()
	leadtoken=locateTypeName("Generic", "Lead Investigator")
	if leadtoken~=nil then
		tab = leadtoken.getTable("playerInvestigator")
		if tab==nil then
			tab={White="",Red="",Orange="",Purple="",Green="",Blue=""}
		end
		return tab
	end
end

function savePlayerInvestigator(tab)
	leadtoken=locateTypeName("Generic", "Lead Investigator")
	if leadtoken~=nil then
		leadtoken.setTable("playerInvestigator",tab)
	end
end

function doomUpdate(tab)
	doomToken=tab[1]
	if math.floor(doomToken.getPosition()[3])==16 or math.floor(doomToken.getPosition()[3])==17 then
		doomVal=math.abs(math.floor(((doomToken.getPosition()[1]-26.3)/2.31)+0.5))
		if doomToken.getPosition()[1]>=-20.5 and doomToken.getPosition()[1]<=27 then
			printToAll("Doom moves to " .. doomVal, colorPalet.doom)
			updateLog(doomVal .. " ")
		end
	end
end

function getMapLocation(name)
	mapLocation={}
      mapLocation["1"]={-23.9, 1.3, 13.7}
      mapLocation["2"]={-25.4, 1.3, 7.5}
      mapLocation["3"]={-21.4, 1.3, -5.8}
      mapLocation["4"]={-18.4, 1.3, 13.8}
      mapLocation["5"]={-17.2, 1.3, 11}
      mapLocation["6"]={-19, 1.3, 7.8}
      mapLocation["7"]={-16.3, 1.3, 3.8}
      mapLocation["8"]={-12.7, 1.3, 6.9}
      mapLocation["9"]={-8.4, 1.3, 16.0}
      mapLocation["10"]={-4.1, 1.3, 2.7}
      mapLocation["11"]={-3.2, 1.3, -5.8}
      mapLocation["12"]={-5.9, 1.3, -9.4}
      mapLocation["13"]={4.4, 1.3, 17.1}
      mapLocation["14"]={2.6, 1.3, 12.8}
      mapLocation["15"]={2.1, 1.3, -6.3}
      mapLocation["16"]={9.4, 1.3, 12.3}
      mapLocation["17"]={11.3, 1.3, 3.2}
      mapLocation["18"]={10.3, 1.3, -7.8}
      mapLocation["19"]={22.9, 1.3, 12.4}
      mapLocation["20"]={18.9, 1.3, -0.7}
      mapLocation["21"]={20.8, 1.3, -3.8}
      mapLocation["San Francisco"]={-23.7, 1.3, 9.3}
      mapLocation["Arkham"]={-14.3, 1.3, 9}
      mapLocation["The Amazon"]={-14.1, 1.3, -0.3}
      mapLocation["Buenos Aires"]={-14.1, 1.3, -5.7}
      mapLocation["London"]={-5.1, 1.3, 11.1}
      mapLocation["Rome"]={1.9, 1.3, 6.8}
      mapLocation["Istanbul"]={3.8, 1.3, 8.4}
      mapLocation["The Pyramids"]={2.1, 1.3, 2.6}
      mapLocation["The Heart of Africa"]={1.1, 1.3, -2.7}
      mapLocation["Tunguska"]={11.9, 1.3, 11}
      mapLocation["The Himalayas"]={10.8, 1.3, 5.7}
      mapLocation["Shanghai"]={16.9, 1.3, 3.2}
      mapLocation["Tokyo"]={21.4, 1.3, 6.3}
      mapLocation["Sydney"]={20.6, 1.3, -8.6}
      mapLocation["Antarctica"]={3.1, 1.3, -12.2}
      mapLocation["luke"]={24.9, 1.6, -11.9}

	--Egypt Side Board
	Egypt={}
	Egypt["The Sahada Desert"]={-10.4, 1.5, 1.8}
	Egypt["Alexandria"]={-4.6, 1.5, 3.8}
	Egypt["The Bent Pyramid"]={2, 1.5, 3.9}
	Egypt["Cairo"]={5.3, 1.5, 0.6}
	Egypt["Tel El-Amarna"]={-1.8, 1.5, -2.9}
	Egypt["The Nile River"]={3.4, 1.5, -5.3}
	if Egypt[name]!=nil then
		base=nil
		for k,v in ipairs(getAllObjects()) do
			if v.tag=="Board" and "Egypt Side Board"==v.getDescription() then
				base=v.getPosition()
			end
		end
		if base==nil then
			printToAll("ERROR - no Egypt Side Board",{1,0,0})
			return nil
		end
		return {x=base[1]+Egypt[name][1],y=base[2]+Egypt[name][2],z=base[3]+Egypt[name][3]}
	end

	--Antarctica Side Board
	Antarctica={}
	Antarctica["Plateau of Leng"]={-9.8, 1.3, -3.7}
	Antarctica["City of the Elder Things"]={-10.9, 1.5, 1.8}
	Antarctica["Frozen Waste"]={-5.6, 1.5, 4.2}
	Antarctica["Lake Camp"]={0.6, 1.5, 3.9}
	Antarctica["Snowy Mountains"]={-4.2, 1.5, -4.2}
	Antarctica["Miskatonic Outpost"]={7.4, 1.5, 3.4}
	if Antarctica[name]!=nil then
		base=nil
		for k,v in ipairs(getAllObjects()) do
			if v.tag=="Board" and "Antarctica Side Board"==v.getDescription() then
				base=v.getPosition()
			end
		end
		if base==nil then
			printToAll("ERROR - no Antarctica Side Board",{1,0,0})
			return nil
		end
		return {x=base[1]+Antarctica[name][1],y=base[2]+Antarctica[name][2],z=base[3]+Antarctica[name][3]}
	end

	--Dreamlands Side Board
	Dreamlands={}
	Dreamlands["The Moon"]={3.1, 1.2, -6.3}
	Dreamlands["The Underworld"]={-6.3, 1.2, -7}
	Dreamlands["Ulthar"]={-5.4, 1.2, 0.6}
	Dreamlands["Dylath-Leen"]={0.8, 1.2, -0.7}
	Dreamlands["The Enchanted Wood"]={-6.2, 1.2, 4.8}
	Dreamlands["Celephais"]={2.4, 1.1, 4.5}
	Dreamlands["Unknown Kadath"]={-1.7, 1.2, 8.4}
	if Dreamlands[name]!=nil then
		base=nil
		for k,v in ipairs(getAllObjects()) do
			if v.tag=="Board" and "Dreamlands Side Board"==v.getDescription() then
				base=v.getPosition()
			end
		end
		if base==nil then
			printToAll("ERROR - no Dreamlands Side Board",{1,0,0})
			return nil
		end
		return {x=base[1]+Dreamlands[name][1],y=base[2]+Dreamlands[name][2],z=base[3]+Dreamlands[name][3]}
	end

	return {x=mapLocation[name][1],y=mapLocation[name][2],z=mapLocation[name][3]}
end

function locateTypeName(type, name)
	for k,v in ipairs(getAllObjects()) do
		if (type==nil or v.tag==type) and name==v.getName() then
			return v
		end
	end
end

function fetchFromContainer(cName, oName, pos, cbOwner, cbName, cbParams)
	container=nil

	for k,v in ipairs(getAllObjects()) do
		if cName==v.getName() then
			container=v
		end
	end

	if container==nil then
		printToAll("error fetching: " .. cName, {1,0,0})
		return
	end

	o={}
	o.position = pos
	if (cName=="Assets") then
		o.rotation={0,180,0}
	end
	if (cName=="Monsters") then
		o.rotation={0,180,180}
	end

	if (cbOwner!=nil and cbName!=nil) then
		o.callback=cbName
		o.callback_owner=cbOwner
		o.params=cbParams
	end

	if oName!=nil and oName!="nilTop" then
		for k,v in ipairs(container.getObjects()) do
			if (container.tag=="Bag" and v.name==oName) or (container.tag=="Deck" and v.nickname==oName) then
				o.guid=v.guid
				o.smooth=false
				container.takeObject(o)
				if container.tag=="Deck" then
					return v.nickname
				else
					return v.name
				end
			end
		end
	else
		if container.tag=="Infinite" then
			o.index=1
			o.smooth=false
			container.takeObject(o)
			return nil
		end
		if oName=="nilTop" then
			selected=1
		else
			selected=math.random(# container.getObjects())-1
		end
		for k,v in ipairs(container.getObjects()) do
			if k==selected then
				if container.tag=="Deck" then
					rName=v.nickname
				else
					rName=v.name
				end
				o.guid=v.guid
			end
		end
		o.smooth=false
		container.takeObject(o)
		return rName
	end
end

function paintMe(obj,tab)
	obj.setColorTint(stringColorToRGB(tab[1] .. ""))
end
------------------------DOUBLE sided



function grabCard(cardName,deckName, pos, firstLevel)
	deck=locateDeck(deckName)
	if deck!=nil then
		local objects = deck.getObjects()
		local position = deck.getPosition()
		position = { position.x+4,position.y+2,position.z+4}
		if pos!=nil then
			position=pos
		end
		local rotation = deck.getRotation()
		reverseTag=false

		cardTag=string.match(cardName,"^%[(.*)%]")
		if cardTag!=nil then
			cardName=nil
			r=string.match(cardTag,"^Non%-(.*)")
			if r!=nil then
				cardTag=r
				reverseTag=true
			end
		end

		local guids={}
		for k,v in ipairs(objects) do
			if cardTag==nil and string.starts(v.nickname, cardName) then
				table.insert(guids, v.guid)
			else
				local tags={}
				for token in string.gmatch(v.description, "[^;]+") do
					table.insert(tags, token)
				end
				if (not reverseTag and contains(tags,cardTag)) or (reverseTag and not contains(tags,cardTag) and contains(tags,firstLevel)) then
					table.insert(guids, v.guid)
				end
			end
		end

		if #guids>0 then
			deck.takeObject({guid=guids[math.random(#guids)],position=position,rotation = {0,180,0},smooth=false})
			deck.shuffle()
			return true
		end

		txt=cardName
		if cardTag!=nil then
			txt=cardTag
		end

		if reverseTag then
			printToAll("Can't find any non-" .. txt .. ".", {1,1,1})
		else
			printToAll("Can't find any " .. txt .. ".", {1,1,1})
		end
		return false
	else
		printToAll("Error - deck missing deckName:" .. deckName,{1,0,0})
	end
end

---------------------------------------
function setupInvestigator(tab)
	sheet=tab[1]
	color=tab[2]
	name=sheet.getName()
	if (sheet.getRotation()[3]>50) or (sheet.getRotation()[3]<-50) then
		return
	end


	pos=sheet.getButtons()[1].position
	pos.z=pos.z-0.7
	sheet.editButton({index=0,position=pos,label="Press one more time", font_size=80, width=800})
	if pos.z>-0.5 then
		return 0
	end
	--end

	sheet.call("hideButton",nil)


	local recepies={}
	recepies["Zoey Samaras"]={{"Assets", "Holy Cross"}}
	recepies["Daisy Walker"]={{"DoubleSided", "Arcane Insight"},{"DoubleSided", "Old Journal"}}
	recepies["Harvey Walters"]={{"Assets", "Ancient Tome"}}
	recepies["Skids O'Toole"]={{"Assets", "Axe"}}
	recepies["Ursula Downs"]={{"Assets", "Mineralogy Research"},{"Mystery bag", "nilTop"}}
	recepies["Trish Scarborough"]={{"Assets", ".45 Automatic"}}
	recepies["Diana Stanley"]={{"Assets", "Arcane Manuscripts"},{"DoubleSided", "Wither"}}
	recepies["Mark Harrigan"]={{"Assets", "Kerosene"},{"Assets", ".38 Revolver"}}
	recepies["Jacqueline Fine"]={{"DoubleSided", "Flesh Ward"},{"Clues", nil}}
	recepies["Norman Withers"]={{"DoubleSided", "Feed the Mind"}}
	recepies["Tony Morgan"]={{"Assets", "Handcuffs"}}
	recepies["Tommy Muldoon"]={{"Assets", "Carbine Rifle"},{"Will bag", nil}}
	recepies["Dexter Drake"]={{"Assets", "Arcane Assistant"},{"DoubleSided", "Binding"}}
	recepies["Silas Marsh"]={{"Assets", "Fishing Net"}}
	recepies["Lily Chen"]={{"Assets", "Protective Amulet"},{"Assets", "Lucky Rabbit's Foot"}}
	recepies["Wendy Adams"]={{"DoubleSided", "Elusive"},{"Clues", nil}}
	recepies["Jenny Barnes"]={{"Assets", ".25 Automatic"},{"Assets", "Fine Jewelry"},{"Ship Ticket bag", nil}}
	recepies["Rex Murphy"]={{"Assets", "Lucky Talisman"},{"DoubleSided", "Cursed"},{"Mystery bag", "nilTop"}}
	recepies["Leo Anderson"]={{"Assets", "Hired Muscle"}}
	recepies["Lola Hayes"]={{"Assets", ".18 Derringer"},{"Mystery bag", "nilTop"}}
	recepies["Charlie Kane"]={{"Assets", "Personal Assistant"}}
	recepies["Marie Lambeau"]={{"Assets", "Ritual Dagger"},{"DoubleSided", "Voice of Ra"}}
	recepies["Joe Diamond"]={{"Assets", ".32 Colt Pocket"}}
	recepies["Mandy Thompson"]={{"Assets", "Magnifying Glass"},{"DoubleSided", "Know Thy Enemy"}}
	recepies["Hank Samson"]={{"Assets", "Sledgehammer"}}
	recepies["Jim Culver"]={{"DoubleSided", "Shriveling"},{"Clues", nil}}
	recepies["Wilson Richards"]={{"Assets", "Blunderbuss"}}
	recepies["Michael McGlen"]={{"Assets", "Tommy Gun"}}
	recepies["Agnes Baker"]={{"Assets", "Profane Tome"},{"DoubleSided", "Storm of Spirits"}}
	recepies["George Barnaby"]={{"Assets", "Investment"},{"Assets", "Pocket Watch"}}
	recepies["Minh Thi Phan"]={{"DoubleSided", "Cryptic Text"},{"Clues", nil}}
	recepies["Finn Edwards"]={{"Assets", "Cat Burglar"},{"Assets", "Whiskey"},{"DoubleSided", "Courier Run"}}
	recepies["Patrice Hathaway"]={{"DoubleSided", "Banishment"},{"Clues", nil}}
	recepies["Akachi Onyele"]={{"DoubleSided", "Mists of Releh"},{"Clues", nil}}
	recepies["Sister Mary"]={{"Assets", "Holy Water"},{"Ship Ticket bag", nil},{"Clues", nil}}
	recepies["Monterey Jack"]={{"Assets", "Bull Whip"},{"DoubleSided", "Treasure Map"}}
	recepies["Amanda Sharpe"]={{"DoubleSided", "Quick Study"},{"DoubleSided", "Unspeakable Research"}}
	recepies["Carolyn Fern"]={{"DoubleSided", "Death XIII"},{"Assets", "Dream Diary"}}
	recepies["Darrell Simmons"]={{"Assets", "Camera"},{"Assets", "Seek the Truth"}}
	recepies["Gloria Goldberg"]={{"DoubleSided", "Find Gate"},{"DoubleSided", "Mythos Codex"}}
	recepies["Kate Winthrop"]={{"DoubleSided", "Dimensional Study"},{"Clues", "nilTop"}}
	recepies["Luke Robinson"]={{"Assets", "Dream Box"},{"Clues", "nilTop"}}
	recepies["William Yorick"]={{"Assets", "Alchemical Concoction"},{"DoubleSided", "Bury Them Deep"},{"Focus bag", "nilTop"}}
	recepies["Vincent Lee"]={{"Assets", "Bandages"},{"DoubleSided", "Composed"}}
	recepies["Rita Young"]={{"DoubleSided", "Rugged"},{"Clues", "nilTop"}}
	recepies["Ashcan Pete"]={{"DoubleSided", "Duke"},{"Clues", "nilTop"}}
	recepies["Roland Banks"]={{"Assets", "Mauser C96"},{"DoubleSided", "Agency Secrets"}}
	recepies["Bob Jenkins"]={{"Assets", "Winchester Rifle"},{"Clues", "nilTop"}}

	startingPos={}
	startingPos["Agnes Baker"]="London"
	startingPos["Akachi Onyele"]="15"
	startingPos["Charlie Kane"]="San Francisco"
	startingPos["Daisy Walker"]="Istanbul"
	startingPos["Dexter Drake"]="Tokyo"
	startingPos["Diana Stanley"]="7"
	startingPos["Finn Edwards"]="5"
	startingPos["George Barnaby"]="17"
	startingPos["Hank Samson"]="6"
	startingPos["Harvey Walters"]="Arkham"
	startingPos["Jacqueline Fine"]="5"
	startingPos["Jenny Barnes"]="8"
	startingPos["Jim Culver"]="6"
	startingPos["Joe Diamond"]="San Francisco"
	startingPos["Leo Anderson"]="Buenos Aires"
	startingPos["Lily Chen"]="Shanghai"
	startingPos["Lola Hayes"]="Tokyo"
	startingPos["Mandy Thompson"]="Shanghai"
	startingPos["Marie Lambeau"]="20"
	startingPos["Mark Harrigan"]="14"
	startingPos["Michael McGlen"]="London"
	startingPos["Minh Thi Phan"]="Tokyo"
	startingPos["Monterey Jack"]="The Pyramids"
	startingPos["Norman Withers"]="Arkham"
	startingPos["Patrice Hathaway"]="Sydney"
	startingPos["Rex Murphy"]="1"
	startingPos["Silas Marsh"]="Sydney"
	startingPos["Sister Mary"]="15"
	startingPos["Skids O'Toole"]="Buenos Aires"
	startingPos["Tommy Muldoon"]="1"
	startingPos["Tony Morgan"]="7"
	startingPos["Trish Scarborough"]="16"
	startingPos["Ursula Downs"]="The Heart of Africa"
	startingPos["Wendy Adams"]="16"
	startingPos["Wilson Richards"]="Arkham"
	startingPos["Zoey Samaras"]="Rome"
	startingPos["Amanda Sharpe"]="Istanbul"
	startingPos["Carolyn Fern"]="Rome"
	startingPos["Darrell Simmons"]="20"
	startingPos["Gloria Goldberg"]="Arkham"
	startingPos["Kate Winthrop"]="Buenos Aires"
	startingPos["Luke Robinson"]="luke"
	startingPos["William Yorick"]="Sydney"
	startingPos["Vincent Lee"]="17"
	startingPos["Rita Young"]="Shanghai"
	startingPos["Ashcan Pete"]="14"
	startingPos["Roland Banks"]="San Francisco"
	startingPos["Bob Jenkins"]="London"

	local startingVal={}
	startingVal["Agnes Baker"]={7,5}
	startingVal["Akachi Onyele"]={5,7}
	startingVal["Charlie Kane"]={4,8}
	startingVal["Daisy Walker"]={5,7}
	startingVal["Dexter Drake"]={5,7}
	startingVal["Diana Stanley"]={7,5}
	startingVal["Finn Edwards"]={6,6}
	startingVal["George Barnaby"]={4,8}
	startingVal["Hank Samson"]={8,4}
	startingVal["Harvey Walters"]={4,8}
	startingVal["Jacqueline Fine"]={4,8}
	startingVal["Jenny Barnes"]={7,5}
	startingVal["Jim Culver"]={7,5}
	startingVal["Joe Diamond"]={7,5}
	startingVal["Leo Anderson"]={6,6}
	startingVal["Lily Chen"]={6,6}
	startingVal["Lola Hayes"]={5,7}
	startingVal["Mandy Thompson"]={5,7}
	startingVal["Marie Lambeau"]={6,6}
	startingVal["Mark Harrigan"]={8,4}
	startingVal["Michael McGlen"]={8,4}
	startingVal["Minh Thi Phan"]={6,6}
	startingVal["Monterey Jack"]={7,5}
	startingVal["Norman Withers"]={5,7}
	startingVal["Patrice Hathaway"]={5,7}
	startingVal["Rex Murphy"]={7,7}
	startingVal["Silas Marsh"]={8,4}
	startingVal["Sister Mary"]={5,7}
	startingVal["Skids O'Toole"]={6,6}
	startingVal["Tommy Muldoon"]={7,5}
	startingVal["Tony Morgan"]={7,5}
	startingVal["Trish Scarborough"]={7,5}
	startingVal["Ursula Downs"]={6,6}
	startingVal["Wendy Adams"]={5,7}
	startingVal["Wilson Richards"]={8,4}
	startingVal["Zoey Samaras"]={5,7}
	startingVal["Amanda Sharpe"]={6,6}
	startingVal["Carolyn Fern"]={5,7}
	startingVal["Darrell Simmons"]={7,5}
	startingVal["Gloria Goldberg"]={4,8}
	startingVal["Kate Winthrop"]={5,7}
	startingVal["Luke Robinson"]={4,8}
	startingVal["William Yorick"]={7,5}
	startingVal["Vincent Lee"]={6,6}
	startingVal["Rita Young"]={7,5}
	startingVal["Ashcan Pete"]={7,5}
	startingVal["Roland Banks"]={7,5}
	startingVal["Bob Jenkins"]={7,5}

	--Exp09 Masks
	startingVal["Preston Fairmont"]={7,5}
	startingVal["Father Mateo"]={5,7}
	startingVal["Carson Sinclair"]={6,6}
	startingVal["Sefina Rousseau"]={4,8}
	startingVal["Daniela Reyes"]={7,5}
	startingVal["Calvin Wright"]={7,7}
	startingVal["Agatha Crane"]={5,7}


	startingPos["Preston Fairmont"]="Istanbul"
	startingPos["Father Mateo"]="Rome"
	startingPos["Carson Sinclair"]="London"
	startingPos["Sefina Rousseau"]="Sydney"
	startingPos["Daniela Reyes"]="San Francisco"
	startingPos["Calvin Wright"]="Buenos Aires"
	startingPos["Agatha Crane"]="Tokyo"

	recepies["Preston Fairmont"]={{"Assets","Fine Clothes"}}
	recepies["Father Mateo"]={{"Assets","King James Bible"}}
	recepies["Carson Sinclair"]={{"Assets","Lucky Cigarette Case"},{"Clues", nil}}
	recepies["Sefina Rousseau"]={{"Assets","Treasured Memento"},{"Clues", nil}}
	recepies["Daniela Reyes"]={{"DoubleSided", "Headstrong"},{"Clues", nil},{"Resource bag", nil}}
	recepies["Calvin Wright"]={{"Assets","Spirit Dagger"},{"DoubleSided", "Corruption"},{"Clues", nil},{"Resource bag", nil}}
	recepies["Agatha Crane"]={{"DoubleSided", "Instill Bravery"},{"DoubleSided", "Call the Storm"}}


	--Move sheet
	player_hand = Player[color].getPlayerHand()
	local position = {}
	position['y'] = player_hand['pos_y']+1

	position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 7
	position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 7
	sheet.setPositionSmooth(position)
	sheet.setRotationSmooth({0,180,0}, false, true)

	--HpSan
	if contains({"Purple","Orange"},color) then
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 14 + player_hand['trigger_right_x'] * 2
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 14 + player_hand['trigger_right_z'] * 2
	elseif contains({"Blue","Green"},color) then
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 9 - player_hand['trigger_right_x'] * 7.5
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 9 - player_hand['trigger_right_z'] * 7.5
	else
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 9 + player_hand['trigger_right_x'] * 7.5
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 9 + player_hand['trigger_right_z'] * 7.5
	end
	r=startingVal[name]
	if r!=nil then
		for k,v in ipairs(getAllObjects()) do
			if v.tag=="Tile" and color==v.getDescription() then
				v.call("setHS", {hp=r[1],san=r[2]})
				v.setPositionSmooth(position)
				v.setRotationSmooth({0,180,0}, false, true)
				break
			end
		end
	end

	--SmartBin
	if contains({"Purple","Orange"},color) then
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 14 - player_hand['trigger_right_x'] * 3.5
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 14 - player_hand['trigger_right_z'] * 3.5
	elseif contains({"Blue","Green"},color) then
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 3 - player_hand['trigger_right_x'] * 7.5
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 3 - player_hand['trigger_right_z'] * 7.5
	else
		position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 13 + player_hand['trigger_right_x'] * 7.5
		position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 13 + player_hand['trigger_right_z'] * 7.5
	end
	for k,v in ipairs(getAllObjects()) do
		if v.tag=="Bag" and v.getName()=="SmartBin" then
			v.clone({position=position})
			break
		end
	end

	--PAWN
	startPos=getMapLocation(startingPos[name])
	startPos=offsetPos(startPos,{0,6,0})
	if startPos!= nil then
		fetchFromContainer("Pawns", name, startPos, Global, "paintMe", {color})
	else
		fetchFromContainer("Pawns", name, pos, Global, "paintMe", {color})
	end


	--DECKS
	r=recepies[name]
	table.insert(r, {"Personal Mission", name})
	table.insert(r, {"Personal Mission", name})
	if r!=nil then
		n=0
		for k,v in ipairs(r) do
			if contains({"Purple","Orange"},color) then
				position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * (3+n*1) + player_hand['trigger_right_x'] * 8
				position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * (3+n*1) + player_hand['trigger_right_z'] * 8
			elseif contains({"Green","Blue"},color) then
				position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 9 - player_hand['trigger_right_x'] * (11+n)
				position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 9 - player_hand['trigger_right_z'] * (11+n)
			else
				position['x'] = player_hand['pos_x'] + player_hand['trigger_forward_x'] * 9 + player_hand['trigger_right_x'] * (11.5+n)
				position['z'] = player_hand['pos_z'] + player_hand['trigger_forward_z'] * 9 + player_hand['trigger_right_z'] * (11.5+n)
			end
			fetchFromContainer(v[1], v[2], position, nil, nil, nil)
			n=n+3
		end
	end

	sheet.clearButtons()

	--Save name
	pInvest=getPlayerInvestigator()
	if pInvest~=nil then
		pInvest[color]=name
		savePlayerInvestigator(pInvest)
	end
end

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
		expeditionObjects = getObjectFromGUID("hz6n3c").getObjects()
		local count = 0
		for _ in pairs(expeditionObjects) do
		count = count+1
		end
		local nextExpeditionTable = expeditionObjects[count]
		--nextExpeditionGUID = nextExpeditionTable["guid"]
		local nextExpeditionName = nextExpeditionTable["nickname"]
		local coords = "not found"
		local expeditionToken = getObjectFromGUID("du57qe")
		local tokenX = 0
		local tokenY = 0
		for k,v in pairs(boardLocations) do
			if k == nextExpeditionName then
				coords = v
				break
			end
		end
		if coords == "not found" then
			printToAll("coordinates for "..nextExpeditionName.." not found")
		else
			tokenX = tonumber(string.sub(coords,1,5))
			tokenZ = tonumber(string.sub(coords,-5))
			expeditionToken.setPosition(vector(tokenX, 3, tokenZ))
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
  return JSON.encode({started=gameStarted})
end

function onLoad(save_state)
  math.randomseed(os.time())
  if save_state ~= nil and JSON.decode(save_state) ~= nil then
    for k,v in pairs(JSON.decode(save_state)) do
      print(k,v)
    end
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
  local pos = getObjectFromGUID(game_board).getPosition()
  searchForIn('', assets_deck, {
        position = {pos.x - 21.5, 1.5, pos.z - 15.76}
}).setRotation({0, 180, 0})
end

function assets2()
  local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 17.6, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function assets3()
  local pos = getObjectFromGUID(game_board).getPosition()
    searchForIn('', assets_deck, {
        position = {pos.x - 13.8, 1.5, pos.z - 15.76}
    }).setRotation({0, 180, 0})
end

function assets4()
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

   MusicPlayer.play()

  hintList={"877b2b","95b838","cc9a2e","195f2b","ec1bbe","5e0b02"}
  for k,v in ipairs(hintList) do
    o=getObjectFromGUID(v)
    if o~=nil then
      o.destruct()
    end
  end
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

function mysticRuins()
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

function egyptSide()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(pyramid_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-25.5},rotation={0,180,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Egypt',bag,{position={pos.x+13.5,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Africa',bag,{position={pos.x+13.5,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Adventure',bag,{position={pos.x+21,1,pos.z-21},rotation={180,270,0}})
  egyptMonsters()
  tokens.takeObject({position={pos.x+21,3,pos.z-21}})
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

function DreamSide()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(dream_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-30.9},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  --bag.takeObject({position={0,2.01,0},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Dream Quest',bag,{position={pos.x+10.6,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Dreamlands',bag,{position={pos.x+10.6,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Otherworldly Dreams',bag,{position={pos.x+25,1,pos.z-21},rotation={180,270,0}})
  dreamMonsters()
  tokens.takeObject({position={pos.x+10.6,2,pos.z-21}})
  tokens.takeObject({position={pos.x+25,2,pos.z-21}})
  tokens.takeObject({position={pos.x+17,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+25,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+33,1,pos.z-27},rotation={0,180,0}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
    for i = 1, 3 do
        tokens.takeObject({
            position = {gatepos.x, 5, gatepos.z},
            rotation = {0, 180, 0}
        })
  end
  for i=1,7 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z},rotation={0,0,0}})
  end
end

function DreamSide2()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(dream_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-30.9},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  --bag.takeObject({position={0,2.01,0},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Dream Quest',bag,{position={pos.x+10.6,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Dreamlands',bag,{position={pos.x+10.6,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Otherworldly Dreams',bag,{position={pos.x+25,1,pos.z-21},rotation={180,270,0}})
  tokens.takeObject({position={pos.x+10.6,2,pos.z-21}})
  tokens.takeObject({position={pos.x+25,2,pos.z-21}})
  tokens.takeObject({position={pos.x+17,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+25,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+33,1,pos.z-27},rotation={0,180,0}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
  for i=1,3 do
    tokens.takeObject({position={gatepos.x,5,gatepos.z},rotation={0,180,0}})
  end
  for i=1,7 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z},rotation={0,0,0}})
  end
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
    ancient.monsters = {'Zoog', 1, 'Ghoul', 1, 'Moon-Beast', 1, 'Nightgaunt', 1}
    ancient.doom = 12
    DreamSide2()
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
  setupAncient2(searchForIn(name,ancients_bag,{position={50,5,20}}))
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
  print("Check prelude card (if present) and setup appropriately")
  print("Select investigators")
  print("Draw first mystery")
  spawnAppropriateClues(num_players)
  spawnAppropriateGates(num_players)
  local player_num_ref = getObjectFromGUID('d8b7a4')
  local player_guid = {'4576dr', '7ojp91', 's2rwq2', 'olbcuq', 't117wb', '36tlad', 'ky9tj2', 'hutw2i'}
  player_num_ref.takeObject({position={pos.x+34,1,pos.z+25},rotation={0,180,0},guid=player_guid[num_players]})
end

function spawnAppropriateClues(numplayers)
if numplayers == 1 then
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 2 then
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 3 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 4 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 5 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 6 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 7 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  elseif numplayers == 8 then
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  Wait.frames(function() spawnClues()end,300)
  end
end

function spawnAppropriateGates(numplayers)
if numplayers == 1 then
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 2 then
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 3 then
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 4 then
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 5 then
  Wait.frames(function() spawnGates()end,300)
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 6 then
  Wait.frames(function() spawnGates()end,300)
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 7 then
  Wait.frames(function() spawnGates()end,300)
  Wait.frames(function() spawnGates()end,300)
  elseif numplayers == 8 then
  Wait.frames(function() spawnGates()end,300)
  Wait.frames(function() spawnGates()end,300)
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

z_offset = 0
function setAsideMonsters()
  for i=1,#ancient.monsters,2 do
    for j=1,ancient.monsters[i+1] do
      searchForIn(ancient.monsters[i],monster_bag,{position={46,1.5+1*(j-1),20-z_offset},rotation={180,0,0}})
    end
    z_offset = z_offset + 2
  end
end

function setupMythosDeck()
  local pos = getObjectFromGUID(game_board).getPosition()
  -- local diff = {split(options.difficulty,',')}

  local diff = {}
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
  for k,v in pairs(ancient.mythos) do
    for i,j in pairs(v) do
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
	  if #guids > 0 then
		params2.guid = guids[math.random(#guids)]
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

function makeSureAtLeastMediumMythosIsSelected()
  if shouldIncludeEasyMythos == "False"
  and shouldIncludeMediumMythos == "False"
  and shouldIncludeHardMythos == "False"
  then
    UI.setAttribute("mediumMythosToggle", "isOn", "True")
  end
end