script_author('AMR')
script_name('State Law')

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
            local posX = in2
			--local sw, sh = getScreenResolution() Was made to get screen res, might be useful later
			imgui.SetNextWindowPos(imgui.ImVec2(posX,posY),imgui.Cond.Always,imgui.ImVec2(0.5,0.5))
			imgui.Begin("Sus", overlay.v, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
			imgui.Text(u8"State Law Helper.")
			imgui.Text(lawText)
			imgui.Text(stateLaw(lawText))
			imgui.TextColored(imgui.ImVec4(1,1,0,256), u8"---------------------------------------------------------------------------------")
			imgui.TextColored(imgui.ImVec4(1,1,1,256), u8"State Law.")
			imgui.End()
		end
    end
end

local something = { 
    {
        [1] = "V.1. Possession of an illegal substance [M]/[F]",
        [2] = [[
        It is strictly forbidden in the great state of San Andreas,
		the acts of introducing, manufacturing, possessing or distributing harmful
		drugs like heroin or cocaine or meth, with the exception of weed which may
		be legally possessed by an individual for up to a limit of 750 grams.
		If ingredients are found alongside with the illegal substance,
		and they are used to produce these substances,
		they are to be seized with the drugs. 
		The exception to prohibited possessions also include the sole possession of upto two joints.
        ]]
    },



    { 
        [1] = "V.1.1. Property Search",
        [2] = [[
        If the subject of a search is found to be in possession of more than 250 grams of heroin/meth or 750 grams of weed a warrant request may be sent to the persons of authority to approve warrants, against the subject's properties, which are then to be searched and seized of eventual illegal items that are found. 
        ]]
    },


    {
        [1] = "V.1.2. Property Seize",
        [2] = [[
        If upon execution of a search warrant, a property is found to be used for the storage of illegal substances (such as Weed, Meth, Heroin or Cocaine) in quantities more than the possession limit, i.e., more than 250 grams for heroin/meth or more than 750 grams for weed, the property may be seized for a period of 7 days to conduct further investigation into the owner of the property and the use of the produced substance.
        ]]
    },

    {
        [1] = "V.2. Possession of an assault weapon or a sniper rifle [F]",
        [2] = [[

        The possession of military grade weapons is strictly prohibited in the state of San Andreas. If a person is found possessing any of the following firearms, they will be immediately seized along with person's weapon license:

        Assault Rifles (M4 and AK 47)
        Sniper Rifles
        ]]
    },



    {
        [1] = "V.2.1. Property Seize",
        [2] = [[
        Any property in the state if found containing illegal military grade weaponry may be seized by law enforcement agencies for a period of 14 days for further investigation along with the illegal weapons.
        ]]
    },


    {
        [1] = "V.3. Illegal brandishing of a weapon [M]",
        [2] = [[
        It is strictly forbidden to display any kind of weapon in open sight on public grounds or any business setting without a lawful purpose. 
        ]]
    },


    {
        [1] = "V.4. Arms trafficking [F]",
        [2] = [[
        It is strictly forbidden in the great state of San Andreas, the act of introducing, manufacturing or distributing any type of weapon in the state without receiving prior authorization by the competent institutions of the state. Subjects whose right to bear arms has been restricted by a judiciary branch of the state are not allowed to possess weapons until said order expires.
        ]]
    },


    {
        [1] = "V.5. Possession of explosive material and biological/chemical agents [F]",
        [2] = [[

        The mere handling of explosive material, or other biological and/or chemical agents that can greatly affect the well-being of others, is strictly illegal.
        ]]
    },


    {
        [1] = "V.6. Possession of weaponry [M]",
        [2] = [[

        Possession of any weaponry without a weapon license is strictly prohibited. 

        A police officer may revoke your weapon license after you have been found committing a crime involving weapons
        ]]
    },


    {
        [1] = "V.7. Unlisted objects created for an unlawful purpose",
        [2] = [[

        Any object that is not listed in this list whose purpose of creation was to violate the rights or safety of others, such as burglary tools can be put up to trial to the judiciary branch of the state
        ]]
    },


    {
        [1] = "V.8. Miscellaneous items [F]",
        [2] = [[
        It is strictly prohibited to possess, use, and distribute the items listed below with the exceptions of brass, silver, gold jewelry, and gold bars under the criteria in the list.

        - Marked Money. (seize-able)
        - Phone Tracker. (seize-able)
        - Police Scanners. (seize-able)
        - Hacking Laptop. (seize-able)
        - Brass, silver, gold jewelry. (seize-able only if found robbing it)
        - Golden Bars. (seize-able only if found robbing it)
        ]]
    }
}

function stateLaw(arg)
    local toreturn = "No such law found." --Default in case there's no such law, to avoid script crash.
        for key, value in ipairs(something) do
            if string.find(string.lower(value[1]), string.lower(arg) ) then
                toreturn = value[1].."\n"..value[2]
            end
        end
    return toreturn
end
