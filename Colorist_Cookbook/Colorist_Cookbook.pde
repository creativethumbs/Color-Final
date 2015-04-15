import processing.pdf.*;

PFont titleFont; 
PFont mainFont;
PFont codeFont;
int pgnum = 1;
float pgwidth;
float pgheight;
int margin = 200;

PShape blob;

// for the palette
ArrayList<Pixel> colors = new ArrayList<Pixel>();
float tolerance = 50.0;
int totalCount = 0; 
float proptolerance = 0.005;
PImage[] images = new PImage[7];

void setup() {
  size(3508, 2480, PDF, "The Colorist Cookbook.pdf");
  pgwidth = width-(margin*2);
  pgheight = height-(margin*2);
  
  titleFont = createFont("Cheap Potatoes Black Thin.ttf",148); 
  mainFont = createFont("monkey.ttf",148);
  codeFont = createFont("PIXEARG_.TTF",148); 
  
  blob = loadShape("blob.svg");
  for(int i = 0; i < images.length; i++) {
    images[i] = loadImage("img"+i+".jpg");
  }
}

void draw() {
  titlePage();
  goToNext();
  quotePage();
  goToNext();
  
  // 3 pages of the first example of simulataneous contrast
  for(int i = 0; i < 3; i++) { 
    simContrastPage1();
    goToNext();
  } 
  simContrastPage1_print();
  goToNext();
  // 3 pages of the second example of simulataneous contrast
  for(int i = 0; i < 3; i++) { 
    simContrastPage2();
    goToNext();
  }
  
  simContrastPage2_print();
  goToNext();
  
  simContrastPage3();
  goToNext();
  
  simContrastPage3_print();
  goToNext();
  
  for(int i = 0; i < 5; i++) { 
    simContrastPage4();
    goToNext();
  }
  simContrastPage4_print();
  goToNext();
  
  for(int i = 0; i < images.length; i++) {
    palettePage(i);
    goToNext();
  }
  
  palettePage_print();
  goToNext();
  
  monochromePage();
  
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
  // recipe for simple simultaneous contrast  
  
  // prepare the first color
  float r_col1 = random(2,84) + random(2,84) + random(2,84);
  float g_col1 = random(2,84) + random(2,84) + random(2,84);
  float b_col1 = random(2,84) + random(2,84) + random(2,84); 
  
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
  fill(mid);
  noStroke();
  
  triangle(pgwidth*0.1,pgheight/2f,pgwidth*0.4,pgheight/4f, pgwidth*0.4,pgheight*0.75);
  triangle(pgwidth*0.9,pgheight/2f,pgwidth*0.6,pgheight/4f, pgwidth*0.6,pgheight*0.75);
  
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
code += "// recipe for simple simultaneous contrast\n";
code += "\n";
code += "  // prepare the first color\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
code += "  // prepare the 'opposite' color to the first color\n";
code += "  // season with a touch of randomness\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
code += "  // evenly mix the first two colors to create\n";
code += "  // the 'middle' color\n";
code += "  // (recommended) season with randomness\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-15,15),\n";
code += "                    (g_col1+green(col2))/2f + random(-15,15),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
code += "  // pre-translate the transformation matrix\n";
code += "  // to the size of your margins\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
code += "  // arrange opposing colors beside each other\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
code += "  // top with the middle color\n";
code += "  fill(mid);\n";
code += "  noStroke();\n";
code += "\n";
code += "  triangle(pgwidth*0.1,pgheight/2f,pgwidth*0.4,pgheight/4f, pgwidth*0.4,pgheight*0.75);\n";
code += "  triangle(pgwidth*0.9,pgheight/2f,pgwidth*0.6,pgheight/4f, pgwidth*0.6,pgheight*0.75);\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();

}

// more sophisticated demonstrations of simultaneous contrast
void simContrastPage2() {
  // recipe for holed simultaneous contrast 
  
  // prepare the first color
  float r_col1 = random(2,84) + random(2,84) + random(2,84);
  float g_col1 = random(2,84) + random(2,84) + random(2,84);
  float b_col1 = random(2,84) + random(2,84) + random(2,84); 
  
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
  rect((pgwidth)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);
  rect((pgwidth*3f)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);
  
  // slice holes in the middle for a more dramatic effect
  rectMode(CORNER);
  fill(col1);
  for(int rows = 0; rows < 6; rows++) {
    for(int cols = 0; cols < 4; cols++) {
      rect(pgwidth * 0.168 + 140*cols, pgheight * 0.3 + 140*rows,100,100);
    }
  }  
  
  fill(col2);
  float rand3 = random(-350,350);
  float rand4 = random(-250,250);
  pushMatrix();
  //translate(rand3, rand4);
  for(int rows = 0; rows < 6; rows++) {
    for(int cols = 0; cols < 4; cols++) {
      rect(pgwidth * 0.668 + 140*cols, pgheight * 0.3 + 140*rows,100,100);
    }
  }  
  popMatrix();
  
  popMatrix();
}
void simContrastPage2_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(codeFont, 40);
pushMatrix();
translate(200, 200 );
String code = "";
code += "// recipe for holed simultaneous contrast\n";
code += "\n";
code += "  // prepare the first color\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
code += "  // prepare the 'opposite' color to the first color\n";
code += "  // season with a touch of randomness\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
code += "  // evenly mix the first two colors to create\n";
code += "  // the 'middle' color\n";
code += "  // (recommended) season with randomness\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-15,15),\n";
code += "                    (g_col1+green(col2))/2f + random(-15,15),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
code += "  // pre-translate the transformation matrix\n";
code += "  // to the size of your margins\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
code += "  // arrange opposing colors beside each other\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
code += "  // top with the middle color\n";
code += "  rectMode(CENTER);\n";
code += "  fill(mid);\n";
code += "  noStroke();\n";
code += "  rect((pgwidth)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "  rect((pgwidth*3f)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "\n";
code += "  // slice holes in the middle for a more dramatic effect\n";
code += "  rectMode(CORNER);\n";
code += "  fill(col1);\n";
code += "  for(int rows = 0; rows < 6; rows++) {\n";
code += "    for(int cols = 0; cols < 4; cols++) {\n";
code += "      rect(pgwidth * 0.168 + 140*cols, pgheight * 0.3 + 140*rows,100,100);\n";
code += "    }\n";
code += "  }\n";
code += "\n";
code += "  fill(col2);\n";
code += "  float rand3 = random(-350,350);\n";
code += "  float rand4 = random(-250,250);\n";
code += "  pushMatrix();\n";
code += "  //translate(rand3, rand4);\n";
code += "  for(int rows = 0; rows < 6; rows++) {\n";
code += "    for(int cols = 0; cols < 4; cols++) {\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "      rect(pgwidth * 0.668 + 140*cols, pgheight * 0.3 + 140*rows,100,100);\n";
code += "    }\n";
code += "  }\n";
code += "  popMatrix();\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

// a schotter tribute
void simContrastPage3() {
  // recipe for schotter simultaneous contrast  
  
  // prepare the first color
  float r_col1 = random(2,84) + random(2,84) + random(2,84);
  float g_col1 = random(2,84) + random(2,84) + random(2,84);
  float b_col1 = random(2,84) + random(2,84) + random(2,84); 
  
  color col1 = color(r_col1, g_col1, b_col1);
  
  // prepare the 'opposite' color to the first color
  // season with a touch of randomness
  color col2 = color(255 - r_col1 + random(-7,7), 
                      255 - g_col1 + random(-7,7), 
                      255 - b_col1 + random(-7,7));
  
  // evenly mix the first two colors to create 
  // the 'middle' color
  // (recommended) season with randomness
  color mid = color((r_col1+red(col2))/2f + random(-20,20), 
                    (g_col1+green(col2))/2f + random(-20,20),
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
  
  rectMode(CORNER);
  fill(mid);
  stroke(col1); 
  for(int rows = 0; rows < 25; rows++) {
    for(int cols = 0; cols < 15; cols++) {
      pushMatrix();
      translate(pgwidth * 0.1 + 60*cols, pgheight * 0.2 + 60*rows);
      float rotamnt = random(-rows*0.05,rows*0.05);
      rotate(rotamnt);
      rect(0,0,60,60);
      popMatrix();
      
    }
  }   
  rectMode(CORNER);
  fill(mid);
  stroke(col2); 
  for(int rows = 0; rows < 25; rows++) {
    for(int cols = 0; cols < 15; cols++) {
      pushMatrix();
      translate(pgwidth * 0.6 + 60*cols, pgheight * 0.2 + 60*rows);
      float rotamnt = random(-rows*0.05,rows*0.05);
      rotate(rotamnt);
      rect(0,0,60,60);
      popMatrix();
      
    }
  }  
  
  
  popMatrix();
}
void simContrastPage3_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(codeFont, 40);
pushMatrix();
translate(200, 200 );
String code = "";
code += "// recipe for schotter simultaneous contrast\n";
code += "\n";
code += "  // prepare the first color\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
code += "  // prepare the 'opposite' color to the first color\n";
code += "  // season with a touch of randomness\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
code += "  // evenly mix the first two colors to create\n";
code += "  // the 'middle' color\n";
code += "  // (recommended) season with randomness\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-20,20),\n";
code += "                    (g_col1+green(col2))/2f + random(-20,20),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
code += "  // pre-translate the transformation matrix\n";
code += "  // to the size of your margins\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
code += "  // arrange opposing colors beside each other\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  fill(mid);\n";
code += "  stroke(col1);\n";
code += "  for(int rows = 0; rows < 25; rows++) {\n";
code += "    for(int cols = 0; cols < 15; cols++) {\n";
code += "      pushMatrix();\n";
code += "      translate(pgwidth * 0.1 + 60*cols, pgheight * 0.2 + 60*rows);\n";
code += "      float rotamnt = random(-rows*0.05,rows*0.05);\n";
code += "      rotate(rotamnt);\n";
code += "      rect(0,0,60,60);\n";
code += "      popMatrix();\n";
code += "\n";
code += "    }\n";
code += "  }\n";
code += "  rectMode(CORNER);\n";
code += "  fill(mid);\n";
code += "  stroke(col2);\n";
code += "  for(int rows = 0; rows < 25; rows++) {\n";
code += "    for(int cols = 0; cols < 15; cols++) {\n";
code += "      pushMatrix();\n";
code += "      translate(pgwidth * 0.6 + 60*cols, pgheight * 0.2 + 60*rows);\n";
code += "      float rotamnt = random(-rows*0.05,rows*0.05);\n";
code += "      rotate(rotamnt);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "      rect(0,0,60,60);\n";
code += "      popMatrix();\n";
code += "\n";
code += "    }\n";
code += "  }\n";
code += "\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();

}

// painterly study 
void simContrastPage4() {
  
  colorMode(HSB,360,100,100); 
  color col1 = color(random(0,360), random(90,100), random(80,100));
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin, margin);
  noStroke(); 
  
  color bg = color((hue(col1)+180)%360, random(90,100), random(80,100));
  fill(bg);
  rect(0, 0, pgwidth,pgheight);
  
  for(int i = 0; i < 90; i++) {
    float posX = random(0, pgwidth-200);
    float posY = random(0, pgheight-200);  
    
    float rectw = random(100, min(1200, pgwidth-posX));
    float recth = random(200, min(800, pgheight-posY));
    
    fill(col1, 50);
    rect(posX, posY, rectw,recth);
    
  }
  
  for(int i = 0; i < 10; i++) {
    float posX = random(0, pgwidth-200);
    float posY = random(0, pgheight-200);  
    
    float rectw = random(100, min(1200, pgwidth-posX));
    float recth = random(200, min(800, pgheight-posY));
    
    fill(bg,70);
    rect(posX, posY, rectw,recth);
    
  }
  
  popMatrix();
  colorMode(RGB);
}

void simContrastPage4_print() {
  fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(codeFont, 40);
pushMatrix();
translate(200, 200 );
String code = "";
code += "  colorMode(HSB,360,100,100);\n";
code += "  color col1 = color(random(0,360), random(90,100), random(80,100));\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "  noStroke();\n";
code += "\n";
code += "  color bg = color((hue(col1)+180)%360, random(90,100), random(80,100));\n";
code += "  fill(bg);\n";
code += "  rect(0, 0, pgwidth,pgheight);\n";
code += "\n";
code += "  for(int i = 0; i < 90; i++) {\n";
code += "    float posX = random(0, pgwidth-200);\n";
code += "    float posY = random(0, pgheight-200);\n";
code += "\n";
code += "    float rectw = random(100, min(1200, pgwidth-posX));\n";
code += "    float recth = random(200, min(800, pgheight-posY));\n";
code += "\n";
code += "    fill(col1, 50);\n";
code += "    rect(posX, posY, rectw,recth);\n";
code += "\n";
code += "  }\n";
code += "\n";
code += "  for(int i = 0; i < 10; i++) {\n";
code += "    float posX = random(0, pgwidth-200);\n";
code += "    float posY = random(0, pgheight-200);\n";
code += "\n";
code += "    float rectw = random(100, min(1200, pgwidth-posX));\n";
code += "    float recth = random(200, min(800, pgheight-posY));\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "\n";
code += "    fill(bg,70);\n";
code += "    rect(posX, posY, rectw,recth);\n";
code += "\n";
code += "  }\n";
code += "\n";
code += "  popMatrix();\n";
code += "  colorMode(RGB);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();

}

void monochromePage() {
  //fill(236,95,12,5);
  background(0);
  noFill();
  stroke(236,95,12, 60);
  float posX = 0;
  float posY;
  pushMatrix();
  translate(-500, margin + pgheight/3.0);
  
  for(int i = 0; i < 2000; i++) {
    posY = sin(posX*0.005) * 200; 
    shape(blob,posX,posY);
    
    posX += 4;
  }
  
  popMatrix();
  
}

public class Pixel {
  public color pixelcolor; 
  public int count;
}

float colorDist(color c1, color c2) {
  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  
  return sqrt(sq(r) + sq(g) + sq(b));
}

void addPixel(color currpix) {
  Pixel p = new Pixel();
  p.pixelcolor = currpix;
  p.count = 1;
  colors.add(p);
  totalCount++;
}

boolean notBlackorWhite(color col) {
  return ((col != 0.0) && (col != 255.0)); 
}

void palettePage(int imgindex) {
  //
  totalCount = 0;
  // colors is an ArrayList of pixel objects
  // it is initialized as: ArrayList<Pixel> colors = new ArrayList<Pixel>();
  for(int i = colors.size()-1; i >= 0 ; i--) {
     colors.remove(i);
  } 
  
  int iwidth = images[imgindex].width;
  int iheight = images[imgindex].height;
  images[imgindex].resize(0, (int)pgheight);
  float palettepos = images[imgindex].width + 50;
  
  for(int i = 0; i < iheight; i++) {
    for(int j = 0; j < iwidth; j++) {
      color currpix = images[imgindex].get(i,j);
      
      if(notBlackorWhite(currpix)) {
        if(colors.size() == 0) {
          addPixel(currpix);
        }
        
        else {
          int idx;
          boolean foundMatch = false;
          int prevIdx = 0;
          float minDist = 1000000.0;
          for(idx = 0; idx < colors.size(); idx++) {
            float currDist = colorDist(currpix, colors.get(idx).pixelcolor);
            if(currDist < tolerance) {
                  if(foundMatch && (currDist < minDist)) {
                    colors.get(idx).count++;
                    colors.get(prevIdx).count--;
                    
                    prevIdx = idx;
                    minDist = currDist;
                  }
                  else if(!foundMatch && (currDist < minDist)) {
                    colors.get(idx).count++;
                    totalCount++;
                    foundMatch = true;
                    prevIdx = idx;
                    minDist = currDist;
                  }
                }
          }
          
          if(!foundMatch) {
            // couldn't find a matching color
            addPixel(currpix);
            
          }
          
        }
      }
    }
  }
  
  int netCount = totalCount; 
  for(int idx = 0; idx < colors.size(); idx++) { 
    float prop = colors.get(idx).count / ((float)totalCount);
    
    if(prop < proptolerance) {
      netCount -= colors.get(idx).count;
    }
  } 
  rectMode(CORNER);
  float ypos = 0f;
  color prevColor= colors.get(0).pixelcolor;
  
  pushMatrix();
  translate(margin + 700, margin);
  image(images[imgindex], 0,0);
  
  for(int idx = 0; idx < colors.size(); idx++) { 
    float prop = colors.get(idx).count / ((float)netCount);
    if(prop >= proptolerance) {
      float rheight = pgheight*prop;
      
      stroke(colors.get(idx).pixelcolor);
      fill(colors.get(idx).pixelcolor);
    
      rect(palettepos, ypos, 300, rheight);
      ypos += rheight;
      prevColor = colors.get(idx).pixelcolor;
    }
  }
  
  popMatrix();
   
}

void palettePage_print() {
  fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(codeFont, 40);
pushMatrix();
translate(200, 200 );
String code = "";
code += "// for the palette\n";
code += "ArrayList<Pixel> colors = new ArrayList<Pixel>();\n";
code += "float tolerance = 50.0;\n";
code += "int totalCount = 0;\n";
code += "float proptolerance = 0.005;\n";
code += "PImage[] images = new PImage[7];\n";
code += "\n";
code += "public class Pixel {\n";
code += "  public color pixelcolor;\n";
code += "  public int count;\n";
code += "}\n";
code += "\n";
code += "float colorDist(color c1, color c2) {\n";
code += "  float r = red(c1) - red(c2);\n";
code += "  float g = green(c1) - green(c2);\n";
code += "  float b = blue(c1) - blue(c2);\n";
code += "\n";
code += "  return sqrt(sq(r) + sq(g) + sq(b));\n";
code += "}\n";
code += "\n";
code += "void addPixel(color currpix) {\n";
code += "  Pixel p = new Pixel();\n";
code += "  p.pixelcolor = currpix;\n";
code += "  p.count = 1;\n";
code += "  colors.add(p);\n";
code += "  totalCount++;\n";
code += "}\n";
code += "\n";
code += "boolean notBlackorWhite(color col) {\n";
code += "  return ((col != 0.0) && (col != 255.0));\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "}\n";
code += "\n";
code += "void palettePage(int imgindex) {\n";
code += "  //\n";
code += "  totalCount = 0;\n";
code += "  // colors is an ArrayList of pixel objects\n";
code += "  // it is initialized as: ArrayList<Pixel> colors = new ArrayList<Pixel>();\n";
code += "  for(int i = colors.size()-1; i >= 0 ; i--) {\n";
code += "     colors.remove(i);\n";
code += "  }\n";
code += "\n";
code += "  int iwidth = images[imgindex].width;\n";
code += "  int iheight = images[imgindex].height;\n";
code += "  images[imgindex].resize(0, (int)pgheight);\n";
code += "  float palettepos = images[imgindex].width + 50;\n";
code += "\n";
code += "  for(int i = 0; i < iheight; i++) {\n";
code += "    for(int j = 0; j < iwidth; j++) {\n";
code += "      color currpix = images[imgindex].get(i,j);\n";
code += "\n";
code += "      if(notBlackorWhite(currpix)) {\n";
code += "        if(colors.size() == 0) {\n";
code += "          addPixel(currpix);\n";
code += "        }\n";
code += "\n";
code += "        else {\n";
code += "          int idx;\n";
code += "          boolean foundMatch = false;\n";
code += "          int prevIdx = 0;\n";
code += "          float minDist = 1000000.0;\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "          for(idx = 0; idx < colors.size(); idx++) {\n";
code += "            float currDist = colorDist(currpix, colors.get(idx).pixelcolor);\n";
code += "            if(currDist < tolerance) {\n";
code += "                  if(foundMatch && (currDist < minDist)) {\n";
code += "                    colors.get(idx).count++;\n";
code += "                    colors.get(prevIdx).count--;\n";
code += "\n";
code += "                    prevIdx = idx;\n";
code += "                    minDist = currDist;\n";
code += "                  }\n";
code += "                  else if(!foundMatch && (currDist < minDist)) {\n";
code += "                    colors.get(idx).count++;\n";
code += "                    totalCount++;\n";
code += "                    foundMatch = true;\n";
code += "                    prevIdx = idx;\n";
code += "                    minDist = currDist;\n";
code += "                  }\n";
code += "                }\n";
code += "          }\n";
code += "\n";
code += "          if(!foundMatch) {\n";
code += "            // couldn't find a matching color\n";
code += "            addPixel(currpix);\n";
code += "\n";
code += "          }\n";
code += "\n";
code += "        }\n";
code += "      }\n";
code += "    }\n";
code += "  }\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "\n";
code += "  int netCount = totalCount;\n";
code += "  for(int idx = 0; idx < colors.size(); idx++) {\n";
code += "    float prop = colors.get(idx).count / ((float)totalCount);\n";
code += "\n";
code += "    if(prop < proptolerance) {\n";
code += "      netCount -= colors.get(idx).count;\n";
code += "    }\n";
code += "  }\n";
code += "  rectMode(CORNER);\n";
code += "  float ypos = 0f;\n";
code += "  color prevColor= colors.get(0).pixelcolor;\n";
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin + 700, margin);\n";
code += "  image(images[imgindex], 0,0);\n";
code += "\n";
code += "  for(int idx = 0; idx < colors.size(); idx++) {\n";
code += "    float prop = colors.get(idx).count / ((float)netCount);\n";
code += "    if(prop >= proptolerance) {\n";
code += "      float rheight = pgheight*prop;\n";
code += "\n";
code += "      stroke(colors.get(idx).pixelcolor);\n";
code += "      fill(colors.get(idx).pixelcolor);\n";
code += "\n";
code += "      rect(palettepos, ypos, 300, rheight);\n";
code += "      ypos += rheight;\n";
code += "      prevColor = colors.get(idx).pixelcolor;\n";
code += "    }\n";
code += "  }\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(codeFont, 40);
code += "\n";
code += "  popMatrix();\n";
code += "\n";
code += "}\n";
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
