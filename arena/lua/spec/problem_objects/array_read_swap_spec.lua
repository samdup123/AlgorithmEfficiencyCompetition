local mach = require'mach'
local problem_object = require'problem_objects.array_read_swap'

describe('array_read_swap', function()

  it('should create an array that can be read from and swapped from only', function()
    local arr = problem_object({'hello', 'goodbye', 'iloveyou'})

    assert.are_equal('hello', arr.read(1))
    arr.swap(1, 3)
    assert.are_equal('iloveyou', arr.read(1))
  end)

  it('should error if an index is swapped that does not have data', function()
    local arr = problem_object({'hello'})

    assert.has_error(function() arr.swap(1,2) end, 'tried to swap from an index that has no data')
  end)
end)
