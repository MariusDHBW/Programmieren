local function contains(table, val)
	for i=1,#table do
		if table[i] == val then
			return true
		end
	end
	return false
end

topCardTxt="1st from the top"

local menu={
	Artifacts={topCardTxt,"[Elixir]","[Item]","[Magical]","[Relic]","[Tome]","[Trinket]","[Weapon]","<<<"},
	Assets={topCardTxt,"[Ally]","[Item]","[Magical]","[Relic]","[Service]","[Task]","[Tome]","[Trinket]","[Weapon]","<<<"},
	Bane={"[Bane]","Blight","Corruption","Cursed","Haunted","<<<"},
	Boon={"[Boon]","Blessed","Composed","Living Link","Righteous","<<<"},
	--Clues={topCardTxt,"City","Sea","Wilderness"},
	Deal={"[Deal]","Agreement","Dark Pact","Debt","Funding","Promise of Power","<<<"},
	Exposure={"[Exposure]","Hypothermia","<<<"},
	Illness={"[Illness]","Diseased","Infection","Poisoned","<<<"},
	Injury={"[Injury]","Back Injury","Head Injury","Internal Injury","Leg Injury","<<<"},
	Madness={"[Madness]","Amnesia","Despair","Hallucinations","Hunger","Paranoia","Terror","<<<"},
	Pursuit={"[Pursuit]","Hunted","Wanted","<<<"},
	Restriction={"[Restriction]","Detained","Lost in Time and Space","<<<"},
	Spells={"[Spells]","[Glamour]","[Incantation]","[Ritual]","[Non-Glamour]","[Non-Incantation]","[Non-Ritual]","<<<"},
	Talent={"[Talent]","Attuned","Composed","Elusive","Guts","Headstrong","Martial Prowess","Meditation","Moxie","Perceptive","Practiced","Quick Study","Relentless","Resilient","Rugged","Silver Tongued","Skulduggery","Studious","Studious","Visions","<<<"},
	UniqueAssets={"[Unique Assets]","[Character]","[Relic]","[Task]","[Tome]","[Weapon]","Courier Run","Old Journal","Treasure Map","<<<"}
}

function onLoad(save_state)
	createMainMenu()
end

function createMainMenu()
	self.clearButtons()
	n=1
	for k,v in pairs(menu) do
		_G['ClickFunction' .. n] = function(obj, playerColor)
			listSubtypes(playerColor, n, k)
		end
		if self.getDescription()=="v" then
			self.createButton({	click_function = 'ClickFunction' .. n , label="["..k.."]", function_owner = self,position = {1+ ((n-1) % 3)*1.5,0.01,0+math.floor((n-1)/3)*0.4},width = 700,height = 200,font_size = 100})
		else
			self.createButton({	click_function = 'ClickFunction' .. n , label="["..k.."]", function_owner = self,position = {1+ ((n-1) % 5)*1.5,0.01,0+math.floor((n-1)/5)*0.4},width = 700,height = 200,font_size = 100})
		end
		n=n+1
	end
end

function listSubtypes(playerColor, index, subtype)
	self.clearButtons()
	submenu=menu[subtype]
	for k,v in pairs(submenu) do
		_G['ClickFunction' .. k] = function(obj, playerColor)
			getCard(playerColor, k, subtype, v)
		end
		if self.getDescription()=="v" then
			self.createButton({click_function = 'ClickFunction' .. k , label=v, function_owner = self,position = {1+ ((k-1) % 3)*1.5,0.01,0+math.floor((k-1)/3)*0.4},width = 700,height = 200,font_size = 100-math.min(70,(math.floor(string.len(v)/5)*9)), alignment =1})
		else
			self.createButton({click_function = 'ClickFunction' .. k , label=v, function_owner = self,position = {1+ ((k-1) % 5)*1.5,0.01,0+math.floor((k-1)/5)*0.4},width = 700,height = 200,font_size = 100-math.min(70,(math.floor(string.len(v)/5)*9)), alignment =1})
		end

	end
end

function getCard(playerColor, index, subtype, cardName)
	successMessage=playerColor .. " got [" .. subtype .. "] -> " .. cardName
	createMainMenu()
	if cardName=="<<<" then
		return
	end
	deckName="Boon / Talent"
	if subtype=="Assets" or subtype=="Artifacts" or subtype=="Bane" or subtype=="Deal" or subtype=="Exposure" or subtype=="Illness" or subtype=="Injury" or subtype=="Madness" or subtype=="Pursuit" or subtype=="Restriction" or subtype=="Spells" or subtype=="UniqueAssets" then
		deckName=subtype
	end
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
	if grabCard(playerColor, deckName, subtype, cardName, cardTag, reverseTag) then
		printToAll(successMessage, {0.8,0.8,0.8})
	end
end


function grabCard(playerColor, deckName, subtype, cardName, cardTag, reverseTag)
	deck=nil
	for k,v in pairs(getAllObjects()) do
		if v.tag=="Deck" and v.getName()==deckName then
			deck=v
			break
		end
	end
	if deck!=nil then
		local objects = deck.getObjects()
		local guids={}
		for k,v in ipairs(objects) do
			if cardName==topCardTxt then
				table.insert(guids, v.guid)
				break
			end
			if cardTag==nil and v.nickname==cardName then
				table.insert(guids, v.guid)
			else
				local tags={}
				for token in string.gmatch(v.description, "[^;]+") do
					table.insert(tags, token)
				end
				if (not reverseTag and contains(tags,cardTag)) or (reverseTag and not contains(tags,cardTag) and contains(tags,subtype)) then
					table.insert(guids, v.guid)
				end
			end
		end

		if #guids>0 then
			pos=self.getPosition()
			pos.y=pos.y+2
			deck.takeObject({guid=guids[math.random(#guids)],position=pos,rotation = {0,180,0},smooth=false})
			if cardName!=topCardTxt then
				--deck.shuffle()
			end
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