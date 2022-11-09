local helper = {}

function helper.parseCDATA(str)
    str = string.gsub(str, "<!%[CDATA%[", "")
    str = string.gsub(str, "]]>", "")
    return str
end

return helper