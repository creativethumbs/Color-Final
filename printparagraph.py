import string, Tkinter
import tkMessageBox 
 
output = []
line_list = []
with open('chap1.txt', 'r') as f:
    line_list = f.readlines()
out = open('chap1-print.txt', 'w')

for i in range(len(line_list)): 
    currline = line_list[i]
    currlinelist = currline.split()
    out.write('\npara += \"')

    if(len(line_list[i].strip()) <= 1):
        out.write('\\n\\n')

    for j in range(len(currlinelist)):
        #if (j != 0 and j % 15 == 0):
        #    out.write('\\n')
        
        out.write(currlinelist[j] + " ")

    out.write('\";')

    #print currlinelist

out.close()
f.close()
