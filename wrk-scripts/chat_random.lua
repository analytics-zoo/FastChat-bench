local json = require("cjson")

local seedctr = os.time()
function setup(thread)
	thread:set("seed", seedctr)
	seedctr = seedctr + 1
end

local requests = {}
local n_requests = 0

function init(args)
	math.randomseed(seed)
	for i = 1, #args do
		for line in io.lines(args[i]) do
			n_requests = n_requests + 1
            requestBody = '{"model": "llama-7b-bigdl", "messages": [{"role": "user", "content": "' .. line .. '"}], "max_tokens":32}'
			requests[n_requests] = wrk.format(nil, nil, nil, requestBody)
		end
	end
end

function request()
	return requests[math.random(n_requests)]
end

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"

logfile = io.open("wrk.log", "w");
response = function(status, header, body)
     logfile:write("status:" .. status .. "\n" .. body .. "\n-------------------------------------------------\n");
end
