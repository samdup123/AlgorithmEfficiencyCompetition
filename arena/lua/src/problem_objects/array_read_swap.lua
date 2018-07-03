local array = {}

return function(entries)
  array = entries
  return {
    read = function(index) return array[index] end,
    swap = function(a, b)
      if array[a] and array[b] then
         local tmp = array[a]
         array[a] = array[b]
         array[b] = tmp
      else
        error('tried to swap from an index that has no data')
      end
     end
  }
end
