import string, Tkinter
import tkMessageBox 
import sys

line_list = []
input_file = sys.argv[1]
with open(input_file, 'r') as f:
    line_list = f.readlines()

textheight = 69
# where the comments are located on the page
commentplacement = 0

functionname = input_file[:-4] +'_print'

out = open(input_file[:-4] +'-print.txt', 'w')

out.write('''
void ''' + functionname + '''() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix(); 
translate(200, 200 );
String code = "";\n''')

for i in range(len(line_list)): 
    if (i != 0) and (i % 30 == 0):
        print "next page"
        out.write('text(code, 0, 0, width*0.8, height*0.8);\n')
        out.write('popMatrix();\n')
        out.write('goToNext();\n')
        out.write('code = \"\";\n')
        out.write('pushMatrix();\n')
        out.write('translate(200, 200 );\n')
        out.write('textFont(mainFont, 60);\n')
        commentplacement = 0

    currline = line_list[i].rstrip()
    #currlinelist = currline.split()
    if(currline.lstrip()[:2] == '//'):
        out.write('fill(commentFill);\ntext(\"' + currline + '\", 0,' + 
            str(textheight*commentplacement) + ',width*0.8,height*0.8);\nfill(0);\n')
        out.write('code += \"\\n\";')

    else:
        if(len(currline) > 1):
            out.write('code += \"' + currline + '\\n\";')
        else:
            out.write('code += \"\\n\";')

        out.write('\n')

    commentplacement += 1

out.write('text(code, 0, 0, width*0.8, height*0.8);\npopMatrix();\n')

out.write('}\n')

out.close()
f.close()
