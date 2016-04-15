local ffi = require('ffi')
local json = require('radio.thirdparty.json')
local buffer = require('tests.buffer')

local radio = require('radio')

-- Benchmark parameters

-- Duration of each benchmark trial
local BENCH_TRIAL_DURATION  = 5.0

-- Number of benchmark trials to average
local BENCH_NUM_TRIALS      = 3

-- Benchmark suite
local BenchmarkSuite = {
    {
        "Five Back to Back FIR Filters (256 Real-valued taps, Complex-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 256 do
                taps[i] = math.random(1.0)
            end
            taps = radio.Float32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.FIRFilterBlock(taps),
                radio.FIRFilterBlock(taps),
                radio.FIRFilterBlock(taps),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Null Source (Complex-valued)",
        "NullSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Null Source (Real-valued)",
        "NullSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "IQ File Source (f32le)",
        "IQFileSource",
        function (results_fd)
            local random_vec = radio.ComplexFloat32Type.vector(2048)
            for i = 0, random_vec.length-1 do
                random_vec.data[i].real = 2*math.random(1.0)-1.0
                random_vec.data[i].imag = 2*math.random(1.0)-1.0
            end
            local src_fd = buffer.open(ffi.string(random_vec.data, random_vec.size))

            return radio.CompositeBlock():connect(
                radio.IQFileSource(src_fd, 'f32le', 1.0, true),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Real File Source (f32le)",
        "RealFileSource",
        function (results_fd)
            local random_vec = radio.Float32Type.vector(2048)
            for i = 0, random_vec.length-1 do
                random_vec.data[i].value = 2*math.random(1.0)-1.0
            end
            local src_fd = buffer.open(ffi.string(random_vec.data, random_vec.size))

            return radio.CompositeBlock():connect(
                radio.RealFileSource(src_fd, 'f32le', 1.0, true),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Raw File Source (float)",
        "RawFileSource",
        function (results_fd)
            local random_vec = radio.Float32Type.vector(2048)
            for i = 0, random_vec.length-1 do
                random_vec.data[i].value = 2*math.random(1.0)-1.0
            end
            local src_fd = buffer.open(ffi.string(random_vec.data, random_vec.size))

            return radio.CompositeBlock():connect(
                radio.RawFileSource(src_fd, radio.Float32Type, 1.0, true),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Uniform Random Source (Complex-valued)",
        "UniformRandomSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.ComplexFloat32Type, 1.0),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Uniform Random Source (Real-valued)",
        "UniformRandomSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.Float32Type, 1.0),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Signal Source (Complex Exponential)",
        "SignalSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.SignalSource('exponential', 200e3, 1e6),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Signal Source (Cosine)",
        "SignalSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.SignalSource('cosine', 200e3, 1e6),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Signal Source (Square)",
        "SignalSource",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.SignalSource('square', 200e3, 1e6),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (64 Real-valued taps, Complex-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 64 do
                taps[i] = math.random(1.0)
            end
            taps = radio.Float32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (64 Real-valued taps, Real-valued input, Real-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 64 do
                taps[i] = math.random(1.0)
            end
            taps = radio.Float32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (64 Complex-valued taps, Complex-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 64 do
                taps[i] = {math.random(1.0), math.random(1.0)}
            end
            taps = radio.ComplexFloat32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (64 Complex-valued taps, Real-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 64 do
                taps[i] = {math.random(1.0), math.random(1.0)}
            end
            taps = radio.ComplexFloat32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (256 Real-valued taps, Complex-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 256 do
                taps[i] = math.random(1.0)
            end
            taps = radio.Float32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (256 Real-valued taps, Real-valued input, Real-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 256 do
                taps[i] = math.random(1.0)
            end
            taps = radio.Float32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (256 Complex-valued taps, Complex-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 256 do
                taps[i] = {math.random(1.0), math.random(1.0)}
            end
            taps = radio.ComplexFloat32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FIR Filter (256 Complex-valued taps, Real-valued input, Complex-valued output)",
        "FIRFilterBlock",
        function (results_fd)
            local taps = {}
            for i = 1, 256 do
                taps[i] = {math.random(1.0), math.random(1.0)}
            end
            taps = radio.ComplexFloat32Type.vector_from_array(taps)

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.FIRFilterBlock(taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "IIR Filter (5 ff 3 fb Real-valued taps, Complex-valued input, Complex-valued output)",
        "IIRFilterBlock",
        function (results_fd)
            local b_taps = {math.random(1.0), math.random(1.0), math.random(1.0), math.random(1.0)}
            local a_taps = {math.random(1.0), math.random(1.0), math.random(1.0)}

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.IIRFilterBlock(b_taps, a_taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "IIR Filter (5 ff 3 fb Real-valued taps, Real-valued input, Real-valued output)",
        "IIRFilterBlock",
        function (results_fd)
            local b_taps = {math.random(1.0), math.random(1.0), math.random(1.0), math.random(1.0)}
            local a_taps = {math.random(1.0), math.random(1.0), math.random(1.0)}

            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.IIRFilterBlock(b_taps, a_taps),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "FM Deemphasis Filter",
        "FMDeemphasisFilterBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 30e3),
                radio.FMDeemphasisFilterBlock(75e-6),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Downsampler (M = 7), Complex-valued",
        "DownsamplerBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.DownsamplerBlock(7),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Downsampler (M = 7), Real-valued",
        "DownsamplerBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.DownsamplerBlock(7),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Upsampler (L = 7), Complex-valued",
        "UpsamplerBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.UpsamplerBlock(7),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Upsampler (L = 7), Real-valued",
        "UpsamplerBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.UpsamplerBlock(7),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Frequency Translator",
        "FrequencyTranslatorBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1e6),
                radio.FrequencyTranslatorBlock(200e3),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Hilbert Transform (65 taps)",
        "HilbertTransformBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.HilbertTransformBlock(65),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Hilbert Transform (257 taps)",
        "HilbertTransformBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.HilbertTransformBlock(257),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Frequency Discriminator",
        "FrequencyDiscriminatorBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.FrequencyDiscriminatorBlock(5.0),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "PLL",
        "PLLBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.ComplexFloat32Type, 1e6),
                radio.PLLBlock(1e3, 200e3, 220e3),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Zero Crossing Clock Recovery",
        "ZeroCrossingClockRecoveryBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.Float32Type, 1e6),
                radio.ZeroCrossingClockRecoveryBlock(1200),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Binary Phase Corrector",
        "BinaryPhaseCorrectorBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.ComplexFloat32Type, 1.0),
                radio.BinaryPhaseCorrectorBlock(3000),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Sum (Complex-valued)",
        "SumBlock",
        function (results_fd)
            local src = radio.NullSource(radio.ComplexFloat32Type, 1.0)
            local summer = radio.SumBlock()
            local top = radio.CompositeBlock()
            top:connect(src, 'out', summer, 'in1')
            top:connect(src, 'out', summer, 'in2')
            return top:connect(summer, radio.BenchmarkSink(results_fd))
        end
    },
    {
        "Subtract (Complex-valued)",
        "SubtractBlock",
        function (results_fd)
            local src = radio.NullSource(radio.ComplexFloat32Type, 1.0)
            local subtractor = radio.SubtractBlock()
            local top = radio.CompositeBlock()
            top:connect(src, 'out', subtractor, 'in1')
            top:connect(src, 'out', subtractor, 'in2')
            return top:connect(subtractor, radio.BenchmarkSink(results_fd))
        end
    },
    {
        "Multiply (Complex-valued)",
        "MultiplyBlock",
        function (results_fd)
            local src = radio.NullSource(radio.ComplexFloat32Type, 1.0)
            local multiplier = radio.MultiplyBlock()
            local top = radio.CompositeBlock()
            top:connect(src, 'out', multiplier, 'in1')
            top:connect(src, 'out', multiplier, 'in2')
            return top:connect(multiplier, radio.BenchmarkSink(results_fd))
        end
    },
    {
        "Multiply Constant (Real-valued constant, Complex-valued input)",
        "MultiplyConstantBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.MultiplyConstantBlock(5.0),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Multiply Constant (Complex-valued constant, Complex-valued input)",
        "MultiplyConstantBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.MultiplyConstantBlock(radio.ComplexFloat32Type(math.random(), math.random())),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Multiply Constant (Real-valued constant, Real-valued input)",
        "MultiplyConstantBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.MultiplyConstantBlock(5.0),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Multiply Conjugate",
        "MultiplyConjugateBlock",
        function (results_fd)
            local src = radio.NullSource(radio.ComplexFloat32Type, 1.0)
            local multiplier = radio.MultiplyConjugateBlock()
            local top = radio.CompositeBlock()
            top:connect(src, 'out', multiplier, 'in1')
            top:connect(src, 'out', multiplier, 'in2')
            return top:connect(multiplier, radio.BenchmarkSink(results_fd))
        end
    },
    {
        "Absolute Value",
        "AbsoluteValueBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.Float32Type, 1.0),
                radio.AbsoluteValueBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Complex Conjugate",
        "ComplexConjugateBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.ComplexConjugateBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Complex Magnitude",
        "ComplexMagnitudeBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.ComplexMagnitudeBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Complex Phase",
        "ComplexPhaseBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.ComplexPhaseBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Delay (N = 3000, Complex-valued input)",
        "DelayBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.DelayBlock(3000),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Bit Slicer",
        "SlicerBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.Float32Type, 1.0),
                radio.SlicerBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Differential Decoder",
        "DifferentialDecoderBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.UniformRandomSource(radio.BitType, 1.0),
                radio.DifferentialDecoderBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Complex to Real",
        "ComplexToRealBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.ComplexToRealBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Complex to Imaginary",
        "ComplexToImagBlock",
        function (results_fd)
            return radio.CompositeBlock():connect(
                radio.NullSource(radio.ComplexFloat32Type, 1.0),
                radio.ComplexToImagBlock(),
                radio.BenchmarkSink(results_fd)
            )
        end
    },
    {
        "Float to Complex",
        "FloatToComplexBlock",
        function (results_fd)
            local src = radio.NullSource(radio.Float32Type, 1.0)
            local floattocomplex = radio.FloatToComplexBlock()
            local top = radio.CompositeBlock()
            top:connect(src, 'out', floattocomplex, 'real')
            top:connect(src, 'out', floattocomplex, 'imag')
            return top:connect(floattocomplex, radio.BenchmarkSink(results_fd))
        end
    },
}

--------------------------------------------------------------------------------

-- Benchmark runner

local test_name_match = arg[1]

-- If a test name was specified, filter the benchmark suite
-- by fuzzy-matching by test name
if test_name_match then
    local MatchedBenchmarkSuite = {}

    for _, benchmark in ipairs(BenchmarkSuite) do
        local test_name = benchmark[1]
        if test_name:lower():find(test_name_match:lower()) then
            MatchedBenchmarkSuite[#MatchedBenchmarkSuite + 1] = benchmark
        end
    end

    BenchmarkSuite = MatchedBenchmarkSuite
end

-- Results
local benchmark_results = {
    version = radio.version,
    platform = {
        luajit_version = radio.platform.luajit_version,
        os = radio.platform.os,
        arch = radio.platform.arch,
        page_size = radio.platform.page_size,
        cpu_count = radio.platform.cpu_count,
        cpu_model = radio.platform.cpu_model,
        features = radio.platform.features
    },
    parameters = {
        num_trials = BENCH_NUM_TRIALS,
        trial_duration = BENCH_TRIAL_DURATION,
    },
    benchmarks = {}
}

for index, benchmark in ipairs(BenchmarkSuite) do
    local test_name, block_name, test_factory = unpack(benchmark)

    io.stderr:write(string.format("Running benchmark %d/%d \"%s\"\n", index, #BenchmarkSuite, test_name))

    local samples_per_second, bytes_per_second = 0.0, 0.0

    -- Run each trial
    for trial = 1, BENCH_NUM_TRIALS do
        -- Create results buffer
        local results_fd = buffer.open()

        -- Create the test top block
        local top = test_factory(results_fd)

        -- Run the trial
        top:start()
        ffi.C.sleep(BENCH_TRIAL_DURATION)
        top:stop()

        -- Read and deserialize results buffer
        buffer.rewind(results_fd)
        local results = json.decode(buffer.read(results_fd, 256))
        buffer.close(results_fd)

        io.stderr:write(string.format("\tTrial %d - %.1f MS/s, %.1f MiB/s\n", trial, results.samples_per_second/1e6, results.bytes_per_second/1048576))

        samples_per_second = samples_per_second + results.samples_per_second
        bytes_per_second = bytes_per_second + results.bytes_per_second
    end

    -- Average results
    samples_per_second = samples_per_second / BENCH_NUM_TRIALS
    bytes_per_second = bytes_per_second / BENCH_NUM_TRIALS

    io.stderr:write(string.format("\tAverage - %.1f MS/s, %.1f MiB/s\n", samples_per_second/1e6, bytes_per_second/1048576))

    -- Add it to our table
    benchmark_results.benchmarks[index] = {name = test_name, block_name = block_name, results = {samples_per_second = samples_per_second, bytes_per_second = bytes_per_second}}
end

print(json.encode(benchmark_results))