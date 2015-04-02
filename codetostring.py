import string, Tkinter
import tkMessageBox 
 
output = []
line_list = []
content = open('code.txt', 'r')
out = open('output.txt', 'w')

# count number of lines, new page after it exceeds a certain value

for line in content: 
    line_list.append(line)

for i in range(len(line_list)): 
    if (i != 0) and (i % 30 == 0):
        out.write('text(code, 0, 0, width*0.8, height*0.8);\n')
        out.write('popMatrix();\n')
        out.write('goToNext();\n')
        out.write('code = \"\";\n')
        out.write('pushMatrix();\n')
        out.write('translate(200, 200 );\n')
        out.write('textFont(codeFont, 40);\n')
        
    if(len(line_list[i].strip()) > 1):
        out.write('code += \"' + str(line_list[i].strip()) + '\\n\";\n')
    else:
        out.write('code += \"\\n\";\n')

out.close()
content.close()

