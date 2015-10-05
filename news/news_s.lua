


function setNews(newsText)
fileDelete("news.txt")
newsFile = fileCreate("news.txt")
fileWrite(newsFile,newsText)
fileFlush(newsFile)
fileClose(newsFile)
outputChatBox("The News got Updated, Check whats new! ( /news )", root, 255, 255, 255 )
restartResource(getResourceFromName("news"))
end
addEvent("updateNewsText",true)
addEventHandler("updateNewsText", root, setNews)
