import json

fname = "synopsys_results.json"
dirs1 = ["exact", "approx"]
dirs2 = ["mul", "div", "sqrt"]

if __name__=="__main__":
	with open(fname, "w") as file:
		file_data = json.loads("[]")
		for d1 in dirs1:
			for d2 in dirs2:
				with open(d1+"/"+d2+"/results/"+fname,'r+') as f_in:
					file_new_data = json.load(f_in)
					file_data += file_new_data
		json.dump(file_data, file, indent = 4)
