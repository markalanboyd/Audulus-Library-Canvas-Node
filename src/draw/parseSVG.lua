local colors={indianred={205,92,92,1},lightcoral={240,128,128,1},salmon={250,128,114,1},darksalmon={233,150,122,1},lightsalmon={255,160,122,1},crimson={220,20,60,1},red={255,0,0,1},firebrick={178,34,34,1},darkred={139,0,0,1},pink={255,192,203,1},lightpink={255,182,193,1},hotpink={255,105,180,1},deeppink={255,20,147,1},mediumvioletred={199,21,133,1},palevioletred={219,112,147,1},coral={255,127,80,1},tomato={255,99,71,1},orangered={255,69,0,1},darkorange={255,140,0,1},orange={255,165,0,1},gold={255,215,0,1},yellow={255,255,0,1},lightyellow={255,255,224,1},lemonchiffon={255,250,205,1},lightgoldenrodyellow={250,250,210,1},papayawhip={255,239,213,1},moccasin={255,228,181,1},peachpuff={255,218,185,1},palegoldenrod={238,232,170,1},khaki={240,230,140,1},darkkhaki={189,183,107,1},lavender={230,230,250,1},thistle={216,191,216,1},plum={221,160,221,1},violet={238,130,238,1},orchid={218,112,214,1},fuchsia={255,0,255,1},magenta={255,0,255,1},mediumorchid={186,85,211,1},mediumpurple={147,112,219,1},rebeccapurple={102,51,153,1},blueviolet={138,43,226,1},darkviolet={148,0,211,1},darkorchid={153,50,204,1},darkmagenta={139,0,139,1},purple={128,0,128,1},indigo={75,0,130,1},slateblue={106,90,205,1},darkslateblue={72,61,139,1},mediumslateblue={123,104,238,1},greenyellow={173,255,47,1},chartreuse={127,255,0,1},lawngreen={124,252,0,1},lime={0,255,0,1},limegreen={50,205,50,1},palegreen={152,251,152,1},lightgreen={144,238,144,1},mediumspringgreen={0,250,154,1},springgreen={0,255,127,1},mediumseagreen={60,179,113,1},seagreen={46,139,87,1},forestgreen={34,139,34,1},green={0,128,0,1},darkgreen={0,100,0,1},yellowgreen={154,205,50,1},olivedrab={107,142,35,1},olive={128,128,0,1},darkolivegreen={85,107,47,1},mediumaquamarine={102,205,170,1},darkseagreen={143,188,139,1},lightseagreen={32,178,170,1},darkcyan={0,139,139,1},teal={0,128,128,1},aqua={0,255,255,1},cyan={0,255,255,1},lightcyan={224,255,255,1},paleturquoise={175,238,238,1},aquamarine={127,255,212,1},turquoise={64,224,208,1},mediumturquoise={72,209,204,1},darkturquoise={0,206,209,1},cadetblue={95,158,160,1},steelblue={70,130,180,1},lightsteelblue={176,196,222,1},powderblue={176,224,230,1},lightblue={173,216,230,1},skyblue={135,206,235,1},lightskyblue={135,206,250,1},deepskyblue={0,191,255,1},dodgerblue={30,144,255,1},cornflowerblue={100,149,237,1},royalblue={65,105,225,1},blue={0,0,255,1},mediumblue={0,0,205,1},darkblue={0,0,139,1},navy={0,0,128,1},midnightblue={25,25,112,1},cornsilk={255,248,220,1},blanchedalmond={255,235,205,1},bisque={255,228,196,1},navajowhite={255,222,173,1},wheat={245,222,179,1},burlywood={222,184,135,1},tan={210,180,140,1},rosybrown={188,143,143,1},sandybrown={244,164,96,1},goldenrod={218,165,32,1},darkgoldenrod={184,134,11,1},peru={205,133,63,1},chocolate={210,105,30,1},saddlebrown={139,69,19,1},sienna={160,82,45,1},brown={165,42,42,1},maroon={128,0,0,1},white={255,255,255,1},snow={255,250,250,1},honeydew={240,255,240,1},mintcream={245,255,250,1},azure={240,255,255,1},aliceblue={240,248,255,1},ghostwhite={248,248,255,1},whitesmoke={245,245,245,1},seashell={255,245,238,1},beige={245,245,220,1},oldlace={253,245,230,1},floralwhite={255,250,240,1},ivory={255,255,240,1},antiquewhite={250,235,215,1},linen={250,240,230,1},lavenderblush={255,240,245,1},mistyrose={255,228,225,1},gainsboro={220,220,220,1},lightgray={211,211,211,1},silver={192,192,192,1},darkgray={169,169,169,1},gray={128,128,128,1},dimgray={105,105,105,1},lightslategray={119,136,153,1},slategray={112,128,144,1},darkslategray={47,79,79,1},black={0,0,0,1}}


local function createPrintLogger()
    local queue = {}

    local function addToPrintQueue(s)
        table.insert(queue, s)
    end

    local function printQueue()
        translate { 0 , -30 }
        text("Print Queue Output", theme.text)
        translate { 0, -20}
        for i, s in ipairs(queue) do
            text(i .. ": " .. s, theme.text)
            translate { 0 , -14 }
        end
    end

    return addToPrintQueue, printQueue
end

local print, printAll = createPrintLogger()

local s = [[
<rect x="0" y="0" width="100" height="50" fill="black" stroke="blue" stroke-width="2"/>
]]

local function parseSVG(s)
    local function getVal(s, key, valType)
        local pattern = key .. '="([^"]+)"'
        local value = string.match(s, pattern)
        if valType == "number" then return tonumber(value) end
        if valType == "string" then return value end
    end
    
    local function parseRect(sub)
        local x1 = getVal(sub, "x", "number")
        local y1 = getVal(sub, "y", "number")
        local width = getVal(sub, "width", "number")
        local height = getVal(sub, "height", "number")
        local x2 = x1 + width
        local y2 = y1 + height
        local coordA = {x1, y1}
        local coordB = {x2, y2}
        local fill = getVal(sub, "fill", "string")
        if fill ~= nil then fill = color_paint(colors[fill]) end
        local stroke = getVal(sub, "stroke", "string")
        if stroke ~= nil then stroke = color_paint(colors[stroke]) end
        local strokeWidth = 2
-- Match pattern having trouble with the `-` in the middle of stroke-width
--        local strokeWidth = getVal(sub, "stroke-width", "number")

        if fill ~= "none" then
            fill_rect(coordA, coordB, 1, fill)
        end

        if stroke ~= "none" then
            stroke_rect(coordA, coordB, 1, strokeWidth, stroke)
        end
    end

    parseRect(s)
end

parseSVG(s)

printAll()


