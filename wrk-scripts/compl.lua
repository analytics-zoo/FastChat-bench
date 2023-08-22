wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = '{"model": "llama-7b-bigdl", "prompt": "Once upon a time", "max_tokens":64}'

logfile = io.open("wrk.log", "w");

response = function(status, header, body)
     logfile:write("status:" .. status .. "\n" .. body .. "\n-------------------------------------------------\n");
end
