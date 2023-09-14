wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = '{"model": "llama-7b-bigdl", "prompt": "Once upon a time, there existed a little girl who liked to have adventures. She wanted to go to places and meet new people, and have fun", "max_tokens":32}'

logfile = io.open("wrk.log", "w");

response = function(status, header, body)
     logfile:write("status:" .. status .. "\n" .. body .. "\n-------------------------------------------------\n");
end
