local radio = require('radio')
local jigs = require('tests.jigs')
local buffer = require('tests.buffer')

jigs.TestSourceBlock(radio.NullSource, {
    {
        desc = "",
        args = {},
        inputs = {},
        outputs = {radio.ComplexFloat32Type.vector_from_array({{0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}, {0.00000000, 0.00000000}})}
    },
}, {epsilon = 1.0e-06})
