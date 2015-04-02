import processing.pdf.*;

PFont titleFont; 
PFont mainFont;
PFont codeFont;
int pgnum = 1;
float pgwidth;
float pgheight;
int margin = 200;

void setup() {
  size(3508, 2480, PDF, "The Colorist Cookbook.pdf");
  pgwidth = width-(margin*2);
  pgheight = height-(margin*2);
  
  titleFont = createFont("Cheap Potatoes Black Thin.ttf",148); 
  mainFont = createFont("monkey.ttf",148);
  codeFont = createFont("PIXEARG_.TTF",148); 
}

void draw() {
  titlePage();
  goToNext();
  quotePage();
  goToNext();
  
  // 3 pages of the first example of simulataneous contrast
  for(int i = 0; i < 4; i++) { 
    simContrastPage1();
    goToNext();
  } 
  simContrastPage1_print();
  
  // Exit the program 
  println("Finished.");
  exit();
}

void quotePage() { 
  textAlign(LEFT); 
  textFont(titleFont, 90);
  
  // randomly chooses one of the quotes text files
  int rand = (int) random(8);
  String[] data = loadStrings("quotes/"+rand + ".txt");
  
  if(data != null) {
    String quote = data[0];
    pushMatrix();
    fill(0);
    translate(300, 300 );
    text("\"" + quote + "\"", 0, 0, width*0.75, height*0.8);
    popMatrix();
  }
  
}

void goToNext() {
  if(pgnum > 2) {
    textFont(mainFont, 80);
    fill(0);
    
    // odd numbered on left
    if(pgnum%2 == 1) 
      text(pgnum, width*0.05, height*0.95);
    else
       text(pgnum, width*0.95, height*0.95);
    
  }
  PGraphicsPDF pdf = (PGraphicsPDF) g;
  pdf.nextPage();
  
  pgnum++;
}

// simple demonstrations of simulataneous contrast
void simContrastPage1() {
  // recipe for simultaneous contrast  
  
  // prepare the first color
  float r_col1 = random(3,95) + random(4,80) + random(3,73);
  float g_col1 = random(3,90) + random(4,83) + random(3,75);
  float b_col1 = random(3,93) + random(4,85) + random(3,70);
  
  color col1 = color(r_col1, g_col1, b_col1);
  
  // prepare the 'opposite' color to the first color
  // season with a touch of randomness
  color col2 = color(255 - r_col1 + random(-7,7), 
                      255 - g_col1 + random(-7,7), 
                      255 - b_col1 + random(-7,7));
  
  // evenly mix the first two colors to create 
  // the 'middle' color
  // (recommended) season with randomness
  color mid = color((r_col1+red(col2))/2f + random(-15,15), 
                    (g_col1+green(col2))/2f + random(-15,15),
                    (b_col1+blue(col2))/2f + random(-15,15)) ;
  
  // pre-translate the transformation matrix
  // to the size of your margins
  pushMatrix();
  translate(margin, margin);
  
  rectMode(CORNER);
  
  // arrange opposing colors beside each other
  fill(col1);
  stroke(col1);
  rect(0,0,pgwidth/2f,pgheight);
  fill(col2);
  stroke(col2);
  rect(pgwidth/2f,0,pgwidth/2f,pgheight);
  
  // top with the middle color
  rectMode(CENTER);
  fill(mid);
  noStroke();
  rect((pgwidth*2f)/8f,pgheight/2f,pgwidth/5f,pgheight/2f);
  rect((pgwidth*6f)/8f,pgheight/2f,pgwidth/5f,pgheight/2f);
  
  popMatrix();
}

void simContrastPage1_print() {
  fill(0);
  textAlign(LEFT); 
  rectMode(CORNER);
  textFont(codeFont, 40);
  
  pushMatrix();
    
  translate(200, 200 );
  
  String code = ""; 
code += "// recipe for simultaneous contrast\n";
code += "\n";
code += "// prepare the first color\n";
code += "float r_col1 = random(3,95) + random(4,80) + random(3,73);\n";
code += "float g_col1 = random(3,90) + random(4,83) + random(3,75);\n";
code += "float b_col1 = random(3,93) + random(4,85) + random(3,70);\n";
code += "\n";
code += "color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
code += "// prepare the 'opposite' color to the first color\n";
code += "// season with a touch of randomness\n";
code += "color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "255 - g_col1 + random(-7,7),\n";
code += "255 - b_col1 + random(-7,7));\n";
code += "\n";
code += "// evenly mix the first two colors to create\n";
code += "// the 'middle' color\n";
code += "// (recommended) season with randomness\n";
code += "color mid = color((r_col1+red(col2))/2f + random(-15,15),\n";
code += "(g_col1+green(col2))/2f + random(-15,15),\n";
code += "(b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
code += "// pre-translate the transformation matrix\n";
code += "// to the size of your margins\n";
code += "pushMatrix();\n";
code += "translate(margin, margin);\n";
code += "\n";
code += "rectMode(CORNER);\n";
code += "\n";
code += "// arrange opposing colors beside each other\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "fill(col1);\n";
code += "stroke(col1);\n";
code += "rect(0,0,pgwidth/2f,pgheight);\n";
code += "fill(col2);\n";
code += "stroke(col2);\n";
code += "rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
code += "// top with the middle color\n";
code += "rectMode(CENTER);\n";
code += "fill(mid);\n";
code += "noStroke();\n";
code += "rect((pgwidth*2f)/8f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "rect((pgwidth*6f)/8f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "\n";
code += "popMatrix();\n";

  text(code, 0, 0, width*0.8, height*0.8);
  
  popMatrix();
}

void titlePage() { 
  
  fill(0);
  rect(0,0,width,height);
  fill(255);
  
  pushMatrix();
  translate(width/2,height/2); 
  
  textAlign(CENTER); 
  textFont(titleFont, 45);
  text("The", 0, -200);
 
  textFont(titleFont, 148);
 
  // value determines the color of 'Colorist'
  int titleFill = (int) random(3);
  
  if(titleFill == 0) {
    // fill with pink
    fill(#EC394E);
  }
  else if(titleFill == 1) {
    // fill with yellow
    fill(#ECDA39);
  }
  else {
    // fill with blue
    fill(#8DEDFF);
  }
  text("Colorist", 0, 0);
  fill(255);
  text("Cookbook", 0, 250);
 
  
  popMatrix();
}
