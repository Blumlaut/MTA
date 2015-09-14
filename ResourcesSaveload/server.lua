     
     
    function writeRunningResources(player, command, ctconfig)
    if ctconfig == "true" then
    if not fileExists("mtaserver.txt") then txt = fileCreate("mtaserver.txt") fileClose(txt) end
    resourceTable = getResources()
     
    txt = fileOpen("mtaserver.txt")
    for resourceKey, resourceValue in ipairs(resourceTable) do
     
    if getResourceState(resourceValue) == "running" then
     
    resourceName = getResourceName(resourceValue)
     
    text = fileRead(txt,9999999)
     
    fileWrite(txt, ""..text.." \n <resource src='"..resourceName.."' startup='1' protected='0' />" )
    fileFlush(txt)
     
    end
    end
    end
     
     
     
     
     
     
     
     
    xmlfile = xmlLoadFile("resources.xml")
    resourceTable = getResources()
    for resourceKey, resourceValue in ipairs(resourceTable) do
    if getResourceState(resourceValue) == "running" then
    resourceName = getResourceName(resourceValue)
    xmlNodeSetValue(xmlCreateChild(xmlfile, "resource"), resourceName)
    xmlSaveFile(xmlfile)
    end
    end
    outputChatBox("Wrote to XML!", root, 255, 0, 0, false)
    end
    addCommandHandler("getRunningResources", writeRunningResources, true)
     
     
    function loadResources()
    outputChatBox("Starting Resources, this can take a while...",root, 255, 0, 0, false)
    local rootNode = xmlLoadFile ( "resources.xml" )
    local nums = xmlNodeGetChildren(rootNode)
    for i,node in ipairs(nums) do      
    local resource = xmlNodeGetValue ( node )
    startResource( getResourceFromName(resource), true)
    end
    end
    addCommandHandler("loadResources", loadResources, true)
     
     
