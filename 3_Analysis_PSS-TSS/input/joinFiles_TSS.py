
first_file = "TSS_5p_coverage/dWT1_TSS.tabular"
files = ["dWT2_TSS.tabular", "dWT3_TSS.tabular", "WT1_TSS.tabular", "WT2_TSS.tabular", "WT3_TSS.tabular",  "TV1_TSS.tabular", "TV2_TSS.tabular"]
dir_files = []
direct = "TSS_5p_coverage"
for i in files:
	dir_files.append(direct + "/" + i)

data_dict = {}
nt_list = []

with open(first_file) as dIF11_0h:
	print("now reading first file")
	for line in dIF11_0h:
		split_line = line.strip("\n").split("\t")
		nt_pos = split_line[0]
		count = split_line[1]
		nt_list.append(nt_pos)
		data_dict[nt_pos] = [count]
			
for tabular in dir_files:
	with open(tabular) as data:
		print("now reading " + tabular)
		for line in data:
			split_line = line.strip("\n").split("\t")
			nt_pos = split_line[0]
			count = split_line[1]
			if nt_pos not in data_dict.keys():
				print(nt_pos + " not in data dict !!!!")
			data_dict[nt_pos].append(count)
				
combined_table = "TSS_5ends_combined_5sensing.txt"
with open(combined_table, "w") as table:
	print("now printing file")
	table.write("\tdWT1\tdWT2\tdWT3\tWT1\tWT2\tWT3\tTV1\tTV2\n")
	for nt_pos in nt_list:
		table.write(nt_pos + "\t")
		j = 1
		for i in data_dict[nt_pos]:
			if j == 8:
				table.write(i + "\n")
				continue
			table.write(i + "\t")
			j += 1
