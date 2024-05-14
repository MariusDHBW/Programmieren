
function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end
 
 local function contains(table, val)
     for i=1,#table do
         if table[i] == val then
             return true
         end
     end
     return false
 end
 
 local cardNames={}
 local decks={"Assets","Artifacts","DoubleSided"}
 
 function onLoad(save_state)
     for k,v in pairs(getAllObjects()) do
         if v.getName()!=nil and v.tag=="Deck" and contains(decks, v.getName()) then
             for n,c in pairs(v.getObjects()) do
                 if not contains(cardNames,c.nickname) then
                     table.insert(cardNames,c.nickname)
                 end
             end
         end
     end
     table.sort(cardNames)
     createMainMenu()
 end
 
 function createMainMenu()
     self.clearButtons()
     menu={".","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
     for k,v in pairs(menu) do
         _G['ClickFunction' .. k] = function(obj, playerColor)
             listCards(playerColor, k, v)
         end
         self.createButton({	click_function = 'ClickFunction' .. k , label=v, function_owner = self,position = {	1+ ((k-1) % 5)*1.5,0.01,0+math.floor((k-1)/5)*0.4},width = 700,height = 200,font_size = 100})
     end
 end
 
 function listCards(playerColor, index, starts)
     self.clearButtons()
     menu={}
     for k,v in pairs(cardNames) do
         if  string.starts(v,starts) then
             table.insert(menu,v)
         end
     end
     table.insert(menu,"<<<")
     for k,v in pairs(menu) do
         _G['ClickFunction' .. k] = function(obj, playerColor)
             getCard(playerColor, k, v)
         end
         self.createButton({click_function = 'ClickFunction' .. k , label=v, function_owner = self,position = {	1+ ((k-1) % 5)*1.5,0.01,0+math.floor((k-1)/5)*0.4},width = 700,height = 200,font_size = 100-math.min(70,(math.floor(string.len(v)/5)*9)), alignment =1})
     end
 end
 
 function getCard(playerColor, index, name)
     createMainMenu()
     for k,v in pairs(getAllObjects()) do
         if v.getName()!=nil and v.tag=="Deck" and contains(decks, v.getName()) then
             for n,c in pairs(v.getObjects()) do
                 if c.nickname==name then
                     printToAll(playerColor .. " got " .. v.getName() .. " - " .. name, {0.8,0.8,0.8})
                     pos=self.getPosition()
                     pos.y=pos.y+2
                     v.takeObject({guid=c.guid,position=pos,rotation = {0,180,0},smooth=false})
                    -- v.shuffle()
                     return
                 end
             end
         end
     end
 
 
 end