local BenchMark = { lookup_table = {} }

--- @param n number
--- @param decimal number|nil
--- @return number
local function round(n, decimal)
	local pow10 = math.pow(10, decimal or 0)
	return math.floor(n * pow10 + 0.5) / pow10
end


--- @param label string
--- Starts a bench test
--- Returns a callback to be called when the functions ends
function BenchMark:start_bench(label)
	local index = #self.lookup_table + 1

	self.lookup_table[index] = { label = label, startTime = vim.uv.hrtime() }

	return function()
		if self.lookup_table[index].endTime ~= nil then
			vim.health.error('Ending the already ended benchmark ' .. self.lookup_table[index].label)
			return
		end
		self.lookup_table[index].endTime = vim.uv.hrtime()
	end
end

function BenchMark:summarize()
	local max_label_length = 0
	for _, value in ipairs(self.lookup_table) do
		if value.label ~= nil then
			max_label_length = math.max(max_label_length, #value.label)
		end
	end

	max_label_length = math.max(20, max_label_length) + 5
	local label_column_format = string.format("%%-%ds", max_label_length)
	vim.print("Column format: ", label_column_format)

	local header = string.format(label_column_format .. "%-15s%-15s%-15s", "Label", "Start Time", "End Time",
		"Elapsed Time");

	local format = label_column_format .. "%-15s%-15s%-15s";
	local decimal_points = 3
	local split = string.rep("-", max_label_length + 15 * 3 + 10) .. "\n"
	-- @type [ number, string ][]
	local prefixes = { { 0, 'ns' }, { 3, 'μs' }, { 6, 'ms' }, { 9, 's' } }
	--- @param n number
	--- @return [number, string]
	local function find_prefix(n)
		n = math.log10(n)
		local closest = prefixes[1]
		for i = 2, #prefixes, 1 do
			local power, prefix = prefixes[i][1], prefixes[i][2]
			if math.abs(n - power) < math.abs(closest[1] - power) then
				closest = { power, prefix }
			end
		end
		return closest
	end

	--- @param n number
	--- @param dec_points number
	--- @return string
	local function formatNum(n, dec_points)
		if n == -1 then
			return "Unknown"
		end
		local power, prefix = unpack(find_prefix(n))
		n = round(n / math.pow(10, power), dec_points)
		local b = tostring(n)
		local padding_zeroes = #b:sub((b:find('%.') or #b) + 1)

		return b .. string.rep('0', dec_points - padding_zeroes) .. prefix
	end

	vim.print(header)
	vim.print(split)
	for _, test in ipairs(self.lookup_table) do
		local label = test.label or ("Unknown test")
		local startTime = test.startTime or -1
		local endTime = test.endTime or -1
		local elapsedTime = (startTime == -1 or endTime == -1) and -1 or endTime - startTime

		local startTimeString = formatNum(startTime, decimal_points)
		local endTimeString = formatNum(endTime, decimal_points)
		local elapsedTimeString = formatNum(elapsedTime, decimal_points)

		vim.print(string.format(format, label, startTimeString, endTimeString, elapsedTimeString))
	end
end

return BenchMark
