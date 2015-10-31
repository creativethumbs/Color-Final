import string, Tkinter
import tkMessageBox 
import sys

line_list = []
input_file = sys.argv[1]
with open(input_file, 'r') as f:
    line_list = f.readlines()
out = open(input_file[:-4] +'-print.txt', 'w')

for i in range(len(line_list)): 
    currline = line_list[i]
    currlinelist = currline.split()
    out.write('\npara += \"')

    for j in range(len(currlinelist)):
        out.write(currlinelist[j] + ' ')

    out.write('\\n\";')

out.close()
f.close()
