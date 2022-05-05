script_author('AMR')
script_name('State Law')


require 'StateLaw'
encoding = require "encoding"
encoding.default = 'CP1251'
u8 = encoding.UTF8
require "lib.moonloader"
imgui = require 'imgui'
local overlay = imgui.ImBool(false)
local TypedLaw = true

function main()
    while not isSampAvailable() do wait(200) end
    imgui.Process = false
    overlay.v = true
    while true do
        wait(0)
        imgui.Process = overlay.v
        if overlay.v then imgui.Process = true else imgui.Process = false end
        if sampIsChatInputActive() and string.len(sampGetChatInputText()) > 2 and string.find(sampGetChatInputText(), "/su%s+%w+%s+(.+)") then --and not string.find(sampGetChatInputText(), '(.+)/') and string.find(sampGetChatInputText(), '/su%s+%w+%s+(.+)') 
			overlay.v = true
		else
			overlay.v = false
		end
	end
end

function imgui.OnDrawFrame()
    if overlay.v then
		if TypedLaw then
			lawText = sampGetChatInputText():match("/su%s+%w+%s+(.+)") --Yes im pro
            local in1 = sampGetInputInfoPtr()
            local in1 = getStructElement(in1, 0x8, 4)
            local in2 = getStructElement(in1, 0x8, 4)
            local in3 = getStructElement(in1, 0xC, 4)
            local posY = in3 + 200
            local posX = in2 + 400
			--local sw, sh = getScreenResolution()-- Was made to get screen res, might be useful later
			imgui.SetNextWindowPos(imgui.ImVec2(posX,posY),imgui.Cond.Always,imgui.ImVec2(0.5,0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(800,300))
			imgui.Begin("Sus", overlay.v, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
            imgui.PushTextWrapPos(0.0)
			imgui.Text(u8"State Law Helper.")
            imgui.TextColored(imgui.ImVec4(1,1,0,256), u8"---------------------------------------------------------------------------------")
			imgui.Text(lawText)
			imgui.Text(law.find(lawText))
			imgui.TextColored(imgui.ImVec4(1,1,0,256), u8"---------------------------------------------------------------------------------")
			imgui.TextColored(imgui.ImVec4(1,1,1,256), u8"Version 1.1")
			imgui.End()
		end
    end
end
