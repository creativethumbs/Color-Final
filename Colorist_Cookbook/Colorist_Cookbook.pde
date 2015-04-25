import processing.pdf.*;

PFont titleFont; 
PFont mainFont;
PFont codeFont;
int pgnum = 1;
float pgwidth;
float pgheight;
int margin = 200;
int commentFill;
int folderimages = 20;

PShape blob;

// for palette grabber
ArrayList<Pixel> colors = new ArrayList<Pixel>();
float tolerance = 50.0;
int totalCount = 0; 
float proptolerance = 0.005;
PImage[] images = new PImage[folderimages];
String[] names = new String[folderimages];

void setup() {
  size(3508, 2480, PDF, "The Colorist Cookbook.pdf");
  pgwidth = width-(margin*2);
  pgheight = height-(margin*2);
  
  titleFont = createFont("Cheap Potatoes Black Thin.ttf",148); 
  mainFont = createFont("monkey.ttf",148);
  codeFont = createFont("PIXEARG_.TTF",148); 
  
  blob = loadShape("blob.svg");
  
  String path = sketchPath+"/data/images/";
  File[] files = listFiles(path);
  for(int i = 0; i < images.length; i++) { 
    String filename = files[i].getName();
    names[i] = filename.substring(1, filename.length()-4);
    images[i] = loadImage(path+filename);
  }
}

//taken from http://processing.org/learning/topics/directorylist.html
File[] listFiles(String dir) {
 File file = new File(dir);
 if (file.isDirectory()) {
   File[] files = file.listFiles();
   return files;
 } else {
   // If it's not a directory
   return null;
 }
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
  goToNext();
  // 3 pages of the second example of simulataneous contrast
  for(int i = 0; i < 4; i++) { 
    simContrastPage2();
    goToNext();
  }
  
  simContrastPage2_print();
  goToNext();
  /*
  simContrastPage3();
  goToNext();
  
  simContrastPage3_print();
  goToNext();*/
  
  for(int i = 0; i < 3; i++) { 
    make4looklike3();
    goToNext();
  }
  
  for(int i = 0; i < 3; i++) { 
    simContrastPage4();
    goToNext();
  }
  simContrastPage4_print();
  goToNext();
  
  for(int i = 0; i < 3; i++) { 
    johannesitten();
    goToNext();
  }
  
  int numimages = 6;
  ArrayList<Integer> indices = new ArrayList<Integer>();
  
  while(numimages > 0){
    int selectedimage = int(random(folderimages));
    // is the image already included in the book?
    boolean foundidx = false;
    for(int i = 0; i < indices.size(); i++) {
      foundidx = (indices.get(i) == selectedimage);
      if(foundidx)
        break;
    }
    if(!foundidx) {
      palettePage(selectedimage);
      textFont(mainFont, 60);
      fill(0);
      text("artist: \n"+names[selectedimage], margin, margin); 
      
      goToNext();
      numimages--;
      indices.add(selectedimage);
    }
  }
  
  palettePage_print();
  goToNext();
  
  //monochromePage();
  
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
      text(pgnum, width*0.05, height*0.97);
    else
      text(pgnum, width*0.95, height*0.97);
    
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
  
  //color col1 = color(r_col1, g_col1, b_col1);
  color col1 = color(random(0,255), random(0,255), random(0,255));
  
  // prepare the color opposite to the first color
  // season with a touch of randomness
  /*
  color col2 = color(255 - r_col1 + random(-7,7), 
                      255 - g_col1 + random(-7,7), 
                      255 - b_col1 + random(-7,7));
  */
  color col2 = color(random(0,255), random(0,255), random(0,255));
  // evenly mix the first two colors to create 
  // the 'middle' color
  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));
  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));
  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));
  
  color mid = color(mixedred, mixedgreen, mixedblue);
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
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(col2);
  text("0x"+hex(col2), width*0.05 + 300, height*0.05);
  fill(mid);
  text("0x"+hex(mid), width*0.05 + 600, height*0.05);
}
void simContrastPage1_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for simple simultaneous contrast", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
fill(commentFill);
text("  // prepare the color opposite to the first color", 0, 621, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // season with a touch of randomness", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1035, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1104, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // (recommended) season with randomness", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-15,15),\n";
code += "                    (g_col1+green(col2))/2f + random(-15,15),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 1518, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 1587, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange opposing colors beside each other", 0, 2001, width*0.8, height*0.8);
fill(0);
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle color", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
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
  
  //color col1 = color(r_col1, g_col1, b_col1);
  color col1 = color(random(0,255), random(0,255), random(0,255));
  
  // prepare the 'opposite' color to the first color
  // season with a touch of randomness
  /*
  color col2 = color(255 - r_col1 + random(-20,20), 
                      255 - g_col1 + random(-20,20), 
                      255 - b_col1 + random(-20,20));
  */
  color col2 = color(random(0,255), random(0,255), random(0,255));
  // evenly mix the first two colors to create 
  // the 'middle' color
  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));
  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));
  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));
  
  color mid = color(mixedred, mixedgreen, mixedblue);
  
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
  // waffle aesthetic
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
  
  for(int rows = 0; rows < 6; rows++) {
    for(int cols = 0; cols < 4; cols++) {
      rect(pgwidth * 0.668 + 140*cols, pgheight * 0.3 + 140*rows,100,100);
    }
  }  
  popMatrix();
  
  popMatrix();
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(col2);
  text("0x"+hex(col2), width*0.05 + 300, height*0.05);
  fill(mid);
  text("0x"+hex(mid), width*0.05 + 600, height*0.05);
}
void simContrastPage2_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for holed simultaneous contrast", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
fill(commentFill);
text("  // prepare the 'opposite' color to the first color", 0, 621, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // season with a touch of randomness", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1035, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1104, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // (recommended) season with randomness", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-15,15),\n";
code += "                    (g_col1+green(col2))/2f + random(-15,15),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 1518, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 1587, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange opposing colors beside each other", 0, 2001, width*0.8, height*0.8);
fill(0);
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle color", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  rectMode(CENTER);\n";
code += "  fill(mid);\n";
code += "  noStroke();\n";
code += "  rect((pgwidth)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "  rect((pgwidth*3f)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "\n";
fill(commentFill);
text("  // slice holes in the middle for a more dramatic effect", 0, 966, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // waffle aesthetic", 0, 1035, width*0.8, height*0.8);
fill(0);
code += "\n";
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
code += "\n";
code += "  for(int rows = 0; rows < 6; rows++) {\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "    for(int cols = 0; cols < 4; cols++) {\n";
code += "      rect(pgwidth * 0.668 + 140*cols, pgheight * 0.3 + 140*rows,100,100);\n";
code += "    }\n";
code += "  }\n";
code += "  popMatrix();\n";
code += "\n";
code += "  popMatrix();\n"; 
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

// make 4 colors look like 3
void make4looklike3() {
  // recipe for making 4 colors look like 3 
  // prepare the first and second colors
  float r1 = random(0,25.5);
  float g1 = random(0,25.5);
  float b1 = random(0,25.5);
  color col1 = color(r1*10, g1*10, b1*10);
  //color col1 = color(random(0,255), random(0,255), random(0,255));
  //color col2 = color(random(0,255), random(0,255), random(0,255));
  
  color col2 = color(255 - red(col1), 
                      255 - green(col1), 
                      255 - blue(col1));
  
  // evenly mix the first two colors to create 
  // the 'middle' color
  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));
  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));
  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));
  
  color mid = color(mixedred, mixedgreen, mixedblue);
  
  float c1_weight = 0.35;
  float c2_weight = 0.65; 
  
  mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(mid))*c2_weight));
  mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(mid))*c2_weight));
  mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(mid))*c2_weight));
  
  color mixed1 = color(mixedred, mixedgreen, mixedblue);
  
  mixedred = sqrt((sq(red(col2))*c1_weight +sq(red(mid))*c2_weight));
  mixedgreen = sqrt((sq(green(col2))*c1_weight +sq(green(mid))*c2_weight));
  mixedblue = sqrt((sq(blue(col2))*c1_weight +sq(blue(mid))*c2_weight));
  
  color mixed2 = color(mixedred, mixedgreen, mixedblue);
  
  // pre-translate the transformation matrix
  // to the size of your margins
  pushMatrix();
  translate(margin, margin);
  
  rectMode(CORNER);
  
  // arrange opposing colors beside each other
  fill(col1);
  stroke(col1);
  //rect(0,0,pgwidth/2f,pgheight);
  rect(0,0,pgwidth,pgheight/2);
  fill(col2);
  stroke(col2);
  //rect(pgwidth/2f,0,pgwidth/2f,pgheight);
  rect(0,pgheight/2,pgwidth,pgheight/2);
  
  // top with the middle color
  fill(mixed1);
  noStroke();
  //rect(pgwidth/6, pgheight/3, pgwidth/6, pgheight/3);
  rect(pgwidth/3, pgheight/6, pgwidth/3, pgheight/6);  
  
  fill(mixed2);
  //rect((pgwidth*2)/3, pgheight/3, pgwidth/6, pgheight/3); 
  rect((pgwidth)/3, (pgheight*2)/3, pgwidth/3, pgheight/6); 
  
  fill(mid);
  //rect((pgwidth * 0.4375), pgheight/3, pgwidth/8, pgheight/3);
  rect(pgwidth/3, pgheight*0.4375, pgwidth/3, pgheight/8);  
  
  popMatrix();
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(col2);
  text("0x"+hex(col2), width*0.05 + 300, height*0.05);
  fill(mixed1);
  text("0x"+hex(mixed1), width*0.05 + 600, height*0.05);
  fill(mid);
  text("0x"+hex(mid), width*0.05 + 900, height*0.05);
  fill(mixed2);
  text("0x"+hex(mixed2), width*0.05 + 1200, height*0.05);
  
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
  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));
  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));
  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));
  
  color mid = color(mixedred, mixedgreen, mixedblue);
  
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
  
  // arrange squares in a Georg Nees fashion  
  rectMode(CORNER);
  fill(mid);
  stroke(col1); 
  for(int rows = 0; rows < 25; rows++) {
    for(int cols = 0; cols < 15; cols++) {
      pushMatrix();
      translate(pgwidth * 0.1 + 60*cols, pgheight * 0.2 + 60*rows);
      // let squares scatter more near the bottom
      float rotamnt = random(-rows*0.05,rows*0.05);
      rotate(rotamnt);
      rect(0,0,60,60);
      popMatrix();
      
    }
  }   
  // repeat previous step
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
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(col2);
  text("0x"+hex(col2), width*0.05 + 300, height*0.05);
  fill(mid);
  text("0x"+hex(mid), width*0.05 + 600, height*0.05);
}
void simContrastPage3_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for schotter simultaneous contrast", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float r_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float g_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "  float b_col1 = random(2,84) + random(2,84) + random(2,84);\n";
code += "\n";
code += "  color col1 = color(r_col1, g_col1, b_col1);\n";
code += "\n";
fill(commentFill);
text("  // prepare the 'opposite' color to the first color", 0, 621, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // season with a touch of randomness", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color col2 = color(255 - r_col1 + random(-7,7),\n";
code += "                      255 - g_col1 + random(-7,7),\n";
code += "                      255 - b_col1 + random(-7,7));\n";
code += "\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1035, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1104, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // (recommended) season with randomness", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color mid = color((r_col1+red(col2))/2f + random(-20,20),\n";
code += "                    (g_col1+green(col2))/2f + random(-20,20),\n";
code += "                    (b_col1+blue(col2))/2f + random(-15,15)) ;\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 1518, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 1587, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange opposing colors beside each other", 0, 2001, width*0.8, height*0.8);
fill(0);
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // arrange squares in a Georg Nees fashion", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  fill(mid);\n";
code += "  stroke(col1);\n";
code += "  for(int rows = 0; rows < 25; rows++) {\n";
code += "    for(int cols = 0; cols < 15; cols++) {\n";
code += "      pushMatrix();\n";
code += "      translate(pgwidth * 0.1 + 60*cols, pgheight * 0.2 + 60*rows);\n";
fill(commentFill);
text("      // let squares scatter more near the bottom", 0, 1035, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "      float rotamnt = random(-rows*0.05,rows*0.05);\n";
code += "      rotate(rotamnt);\n";
code += "      rect(0,0,60,60);\n";
code += "      popMatrix();\n";
code += "\n";
code += "    }\n";
code += "  }\n";
fill(commentFill);
text("  // repeat previous step", 0, 1587, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  fill(mid);\n";
code += "  stroke(col2);\n";
code += "  for(int rows = 0; rows < 25; rows++) {\n";
code += "    for(int cols = 0; cols < 15; cols++) {\n";
code += "      pushMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "      translate(pgwidth * 0.6 + 60*cols, pgheight * 0.2 + 60*rows);\n";
code += "      float rotamnt = random(-rows*0.05,rows*0.05);\n";
code += "      rotate(rotamnt);\n";
code += "      rect(0,0,60,60);\n";
code += "      popMatrix();\n";
code += "\n";
code += "    }\n";
code += "  }\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

// painterly study 
void simContrastPage4() {
  // recipe for using bridging colors
  
  // switch working color mode to HSB
  // before preparing the foreground color
  colorMode(HSB,360,100,100); 
  float h1 = random(0,3.6);
  color col1 = color(h1*100, random(90,100), random(80,100));
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin, margin);
  noStroke(); 
  
  // glaze with the background color, which is opposite from the foreground color
  // add a touch of randomness
  color bg = color((hue(col1)+180)%360, random(90,100), random(80,100));
  fill(bg);
  rect(0, 0, pgwidth,pgheight);
  
  // randomly add 90 slices of the foreground color 
  for(int i = 0; i < 90; i++) {
    float posX = random(0, pgwidth-200);
    float posY = random(0, pgheight-200);  
    
    float rectw = random(100, min(1200, pgwidth-posX));
    float recth = random(200, min(800, pgheight-posY));
    
    // the slices can overlap with each other, 
    // but they must be thin
    // like prosciutto
    fill(col1, 50);
    rect(posX, posY, rectw,recth);
    
  }
  
  // for balance, top with a few thin slices of the background color 
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
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(bg);
  text("0x"+hex(bg), width*0.05 + 300, height*0.05); 
}

void simContrastPage4_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for using bridging colors", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // switch working color mode to HSB", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // before preparing the foreground color", 0, 207, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  colorMode(HSB,360,100,100);\n";
code += "  color col1 = color(random(0,360), random(90,100), random(80,100));\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "  noStroke();\n";
code += "\n";
fill(commentFill);
text("  // glaze with the background color, which is opposite from the foreground color", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // add a touch of randomness", 0, 897, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color bg = color((hue(col1)+180)%360, random(90,100), random(80,100));\n";
code += "  fill(bg);\n";
code += "  rect(0, 0, pgwidth,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // randomly add 90 slices of the foreground color", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < 90; i++) {\n";
code += "    float posX = random(0, pgwidth-200);\n";
code += "    float posY = random(0, pgheight-200);\n";
code += "\n";
code += "    float rectw = random(100, min(1200, pgwidth-posX));\n";
code += "    float recth = random(200, min(800, pgheight-posY));\n";
code += "\n";
fill(commentFill);
text("    // the slices can overlap with each other,", 0, 1794, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("    // but they must be thin", 0, 1863, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("    // like prosciutto", 0, 1932, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    fill(col1, 50);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "    rect(posX, posY, rectw,recth);\n";
code += "\n";
code += "  }\n";
code += "\n";
fill(commentFill);
text("  // for balance, top with a few thin slices of the background color", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < 10; i++) {\n";
code += "    float posX = random(0, pgwidth-200);\n";
code += "    float posY = random(0, pgheight-200);\n";
code += "\n";
code += "    float rectw = random(100, min(1200, pgwidth-posX));\n";
code += "    float recth = random(200, min(800, pgheight-posY));\n";
code += "\n";
code += "    fill(bg,70);\n";
code += "    rect(posX, posY, rectw,recth);\n";
code += "\n";
code += "  }\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

void johannesitten() {
  // recipe for Johannes Itten studies
  
  // switch working color mode to HSB
  // before preparing the foreground color
  colorMode(HSB,360,100,100); 
  float value = random(20,100);
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin + 500, margin);
  noStroke(); 
  
  for(int row = 0; row < 5; row++) {
    for(int col = 0; col < 5; col++) {
      color squarecol = color(random(0,360), random(30,100), value);
      
      fill(squarecol);
      stroke(squarecol);
      rect(400*col, 400*row, 400, 400);
    }
    
  }
  
  
  popMatrix();
  colorMode(RGB);
  
  textFont(mainFont, 60);
  fill(0);
  text("value: " +value, width*0.05, height*0.05);
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

// recipe for palette grabber
public class Pixel {
  public ArrayList pixelgroup;   
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
  // head of  the color group 
  p.pixelgroup = new ArrayList();
  p.pixelgroup.add(currpix);
  p.count = 1;
  colors.add(p);
  totalCount++;
}

boolean notBlackorWhite(color col) {
  return ((col != 0.0) && (col != 255.0)); 
}

void palettePage(int imgindex) { 
  totalCount = 0;
  
  // rinse palette before use
  for(int i = colors.size()-1; i >= 0 ; i--) {
     colors.remove(i);
  } 
  PImage sourceimg = images[imgindex];
  
  sourceimg.resize(0, (int)pgheight);
  int iwidth = sourceimg.width;
  int iheight = sourceimg.height;
  color temp = sourceimg.get(0,0);
  float palettepos = sourceimg.width + 50;
  
  // extract colors from image
  // and add them to the palette
  for(int i = 0; i < iheight; i++) {
    for(int j = 0; j < iwidth; j++) {
      color currpix = sourceimg.get(i,j);
      
      if(notBlackorWhite(currpix)) {
        if(colors.size() == 0) {
          addPixel(currpix);
        }
        
        else {
          int idx;
          boolean foundMatch = false;
          int prevIdx = 0;
          float minDist = 0.0;
          
          // look through existing colors in the palette
          for(idx = 0; idx < colors.size(); idx++) {
            float currDist = colorDist(currpix, (Integer) colors.get(idx).pixelgroup.get(0));
            // if the color is in the palette
            if(currDist < tolerance) {
                  // increase the count for the palette color closest to 
                  // the current pixel 
                  if(foundMatch && (currDist < minDist)) {
                    colors.get(idx).count++;
                    colors.get(prevIdx).count--;
                    colors.get(idx).pixelgroup.add(currpix);
                    
                    prevIdx = idx;
                    minDist = currDist;
                  }
                  else if(!foundMatch) {
                    colors.get(idx).count++;
                    colors.get(idx).pixelgroup.add(currpix);
                    totalCount++;
                    foundMatch = true;
                    prevIdx = idx;
                    minDist = currDist;
                  } 
                }
          }
          
          if(!foundMatch) { 
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
  
  pushMatrix();
  // place image a little to the right of your margins
  translate(margin + 700, margin);
  image(sourceimg, 0,0);
  // place palette beside image
  for(int i = 0; i < colors.size(); i++) { 
    float prop = colors.get(i).count / ((float)netCount);
    
    // if there is enough of the color in the image, display it
    if(prop >= proptolerance) {
      float rheight = pgheight*prop;
      float totred = 0;
      float totgreen = 0; 
      float totblue = 0;  
      
      // calculate an average value of the colors in each group
      int groupsize = colors.get(i).pixelgroup.size();
      for(int j = 0; j < groupsize; j++) {
        Pixel thepixel = colors.get(i);
        color currcolor = (Integer) thepixel.pixelgroup.get(j);
        totred += red(currcolor);
        totgreen += green(currcolor);
        totblue += blue(currcolor);
      } 
      color paletteColor = color(totred/groupsize, totgreen/groupsize,totblue/groupsize);
      
      stroke(paletteColor);
      fill(paletteColor);
      rect(palettepos, ypos, 300, rheight);
      
      // top it off with the hex value for the colors
      textFont(mainFont, 40);
      fill(paletteColor);
      text("0x"+hex(paletteColor), palettepos + 350, ypos+30);
      
      ypos += rheight; 
      
    }
  }
  
  popMatrix();
  
}

void palettePage_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("// prepare initial ingredients", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "ArrayList<Pixel> colors = new ArrayList<Pixel>();\n";
code += "float tolerance = 50.0;\n";
code += "int totalCount = 0;\n";
code += "float proptolerance = 0.005;\n";
code += "PImage[] images = new PImage[6];\n";
code += "\n";
code += "public class Pixel {\n";
code += "  public ArrayList pixelgroup;\n";
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
fill(commentFill);
text("  // head of  the color group", 0, 1518, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  p.pixelgroup = new ArrayList();\n";
code += "  p.pixelgroup.add(currpix);\n";
code += "  p.count = 1;\n";
code += "  colors.add(p);\n";
code += "  totalCount++;\n";
code += "}\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "boolean notBlackorWhite(color col) {\n";
code += "  return ((col != 0.0) && (col != 255.0));\n";
code += "}\n";
code += "\n";
code += "void palettePage(int imgindex) {\n";
code += "  totalCount = 0;\n";
code += "\n";
fill(commentFill);
text("  // rinse palette before use", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = colors.size()-1; i >= 0 ; i--) {\n";
code += "     colors.remove(i);\n";
code += "  }\n";
code += "\n";
code += "  int iwidth = images[imgindex].width;\n";
code += "  int iheight = images[imgindex].height;\n";
code += "  images[imgindex].resize(0, (int)pgheight);\n";
code += "  float palettepos = images[imgindex].width + 50;\n";
code += "\n";
fill(commentFill);
text("  // extract colors from image", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // and add them to the palette", 0, 1242, width*0.8, height*0.8);
fill(0);
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
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "          boolean foundMatch = false;\n";
code += "          int prevIdx = 0;\n";
code += "          float minDist = 0.0;\n";
code += "\n";
fill(commentFill);
text("          // look through existing colors in the palette", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "          for(idx = 0; idx < colors.size(); idx++) {\n";
code += "            float currDist = colorDist(currpix, (Integer) colors.get(idx).pixelgroup.get(0));\n";
fill(commentFill);
text("            // if the color is in the palette", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "            if(currDist < tolerance) {\n";
fill(commentFill);
text("                  // increase the count for the palette color closest to", 0, 621, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("                  // the current pixel", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "                  if(foundMatch && (currDist < minDist)) {\n";
code += "                    colors.get(idx).count++;\n";
code += "                    colors.get(prevIdx).count--;\n";
code += "                    colors.get(idx).pixelgroup.add(currpix);\n";
code += "\n";
code += "                    prevIdx = idx;\n";
code += "                    minDist = currDist;\n";
code += "                  }\n";
code += "                  else if(!foundMatch) {\n";
code += "                    colors.get(idx).count++;\n";
code += "                    colors.get(idx).pixelgroup.add(currpix);\n";
code += "                    totalCount++;\n";
code += "                    foundMatch = true;\n";
code += "                    prevIdx = idx;\n";
code += "                    minDist = currDist;\n";
code += "                  }\n";
code += "                }\n";
code += "          }\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "          if(!foundMatch) {\n";
code += "            addPixel(currpix);\n";
code += "\n";
code += "          }\n";
code += "\n";
code += "        }\n";
code += "      }\n";
code += "    }\n";
code += "  }\n";
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
code += "\n";
code += "  pushMatrix();\n";
fill(commentFill);
text("  // place image a little to the right of your margins", 0, 1518, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  translate(margin + 700, margin);\n";
code += "  image(images[imgindex], 0,0);\n";
code += "\n";
fill(commentFill);
text("  // place palette beside image", 0, 1794, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < colors.size(); i++) {\n";
code += "    float prop = colors.get(i).count / ((float)netCount);\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
fill(commentFill);
text("    // if there is enough of the color in the image, display it", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    if(prop >= proptolerance) {\n";
code += "      float rheight = pgheight*prop;\n";
code += "      float totred = 0;\n";
code += "      float totgreen = 0;\n";
code += "      float totblue = 0;\n";
code += "\n";
code += "      int groupsize = colors.get(i).pixelgroup.size();\n";
code += "      for(int j = 0; j < groupsize; j++) {\n";
code += "        Pixel thepixel = colors.get(i);\n";
code += "        color currcolor = (Integer) thepixel.pixelgroup.get(j);\n";
code += "        totred += red(currcolor);\n";
code += "        totgreen += green(currcolor);\n";
code += "        totblue += blue(currcolor);\n";
code += "      }\n";
code += "      color paletteColor = color(totred/groupsize, totgreen/groupsize,totblue/groupsize);\n";
code += "\n";
code += "      stroke(paletteColor);\n";
code += "      fill(paletteColor);\n";
code += "      rect(palettepos, ypos, 300, rheight);\n";
code += "\n";
fill(commentFill);
text("      // top it off with the hex value for the colors", 0, 1449, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "      textFont(mainFont, 40);\n";
code += "      fill(paletteColor);\n";
code += "      text(\"0x\"+hex(paletteColor), palettepos + 350, ypos+30);\n";
code += "\n";
code += "      ypos += rheight;\n";
code += "\n";
code += "    }\n";
code += "  }\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
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
  int titleFill = int(random(3));
  
  if(titleFill == 0) {
    // fill with pink
    fill(#EC394E);
    commentFill = #FF5891;
  }
  else if(titleFill == 1) {
    // fill with yellow
    fill(#ECDA39);
    commentFill = #EC9E0D;
  }
  else {
    // fill with blue
    fill(#8DEDFF);
    commentFill = #3ED3F0;
  }
  text("Colorist", 0, 0);
  fill(255);
  text("Cookbook", 0, 250);
 
  
  popMatrix();
}
