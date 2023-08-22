wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = '{"model": "llama-7b-bigdl", "messages": [{"role": "user", "content": "Describe China in great details"}], "max_tokens":32}'

logfile = io.open("wrk.log", "w");

response = function(status, header, body)
     logfile:write("status:" .. status .. "\n" .. body .. "\n-------------------------------------------------\n");
end
