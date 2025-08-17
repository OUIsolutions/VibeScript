
private_vibescript.is_str_inside = function(str,target)
    if not str or not target then
        return false
    end
    if string.find(str,target,1,true) then
        return true
    end
    return false
end
