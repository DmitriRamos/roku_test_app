sub init()
    m.top.functionname = "load"
end sub

function load()
    data=ReadAsciiFile("pkg:/"+m.top.filepath)
    ? "Config Data: ";data
    json = parseJSON(data)
    m.top.filedata = Json
end function