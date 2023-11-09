import json
import numpy as np

log_file = "./wrk.log"

first_token_times = []
rest_token_times = []

with open(log_file, "r") as file:
    for line in file:
        try:
            if line.startswith('{"id":'):
            
                data = json.loads(line)
                choices = data.get("choices", [])
                for choice in choices:
                    first_token_time = choice.get("first_token_time")
                    rest_token_time = choice.get("rest_token_time")
                    if first_token_time is not None:
                        first_token_times.append(first_token_time)
                    if rest_token_time is not None:
                        rest_token_times.append(rest_token_time)
        except Exception:
            pass
                #print(f"Error parsing JSON at line : {line}")

average_first_token_time = np.mean(first_token_times)
average_rest_token_time = np.mean(rest_token_times)

print("Average first_token_time:", average_first_token_time * 1000)
print("Average rest_token_time:", average_rest_token_time * 1000)
