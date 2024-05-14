self.createButton({
    click_function = 'drawAll',
    function_owner = self,
    label = 'FindAll',
    position = {0, 0.5, 0},
    width = 400,
    height = 150
})

deck_object_all = nil

function onCollisionEnter(collision_info)
    if collision_info.collision_object.getQuantity() > 1 then
        deck_object_all = collision_info.collision_object
    end
end

function onCollisionExit(collision_info)
    if collision_info.collision_object.getQuantity() > 1 then
        deck_object_all = nil
    end
end

function drawAll(obj, color)
    if deck_object_all == nil then
        print("This cube must be put on a deck")
        return;
    end
    Player[color].showInputDialog("What to search ?", "", drawCallback)
end

function drawCallback(name)
    name = string.lower(name)
    if name ~= '' and deck_object_all ~= nil and deck_object_all.getObjects() ~= nil then
        local negation = (name:sub(1, 4) == "not ")
        if negation then
            name = name:sub(5)
        end
        -- Do the matching
        local pos = {self.getPosition().x, self.getPosition().y + 2, self.getPosition().z}

        local matchFn = function(v)
            return (string.find(string.lower(v.nickname), string.lower(name)) ~= nil) ~= negation
        end
        local res = takeFromCollection(deck_object_all, matchFn, pos)
        
        if (res == nil) then
            local matchGmFn = function(v)
                return (string.find(string.lower(v.gm_notes), string.lower(name)) ~= nil) ~= negation
            end
            res = takeFromCollection(deck_object_all, matchGmFn, pos)
        end
    end
end

function takeFromCollection(collection, matchFn, matchPosition)
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
        else
            -- Take only matches out of the deck, and form new deck
            params = {
                top = false,
                position = matchPosition
            }

            for k, v in pairs(collection.getObjects()) do
                if (matchFn(v)) then
                    params.guid = v.guid
                    params.callback_function = function(obj)
                        if (matchObj == nil) then
                            matchObj = newObj
                        else
                            matchObj.putObject(newObj)
                        end
                    end
                    newObj = collection.takeObject(params)
                end
            end
        end

        return matchObj
    else
        return nil
    end
end