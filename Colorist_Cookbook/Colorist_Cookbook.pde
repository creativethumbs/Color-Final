import processing.pdf.*;
import java.security.SecureRandom;

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
  
  //titleFont = createFont("Cheap Potatoes Black Thin.ttf",148);
  titleFont = createFont("Whitestone.otf",148); 
  mainFont = createFont("monkey.ttf",148);
  codeFont = createFont("PIXEARG_.TTF",148); 
  
  // sketchPath() works for Processing 3.0+
  // for older versions of Processing just sketchPath should work
  //println(dataPath("")); 
  //String path = sketchPath()+"/data/images/";
  String path = dataPath("")+"/images/";
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

// draws the entire book 
void draw() {
  titlePage();
  //goToNext();
  quotePage();
  goToNext();
  
  /* --------------- CHAPTER 0: Introduction --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 00: Introduction", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  introPage();
  
  goToNext();
  
  /* --------------- CHAPTER 1: 3 Colors Into 4 Part I --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 01: 3 Colors Into 4 Part I", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  chap1Intro(); 
  
  goToNext(); 
  
  // 4 pages for Chapter 1
  for(int i = 0; i < 4; i++) { 
    simContrastPage1();
    goToNext();
  } 
  simContrastPage1_print();
  goToNext();
  
  /* --------------- CHAPTER 2: 3 Colors Into 4 Part II --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 02: 3 Colors Into 4 Part II", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  chap2Intro();
  
  goToNext(); 
  
  // 4 pages for Chapter 2
  for(int i = 0; i < 4; i++) { 
    simContrastPage2();
    goToNext();
  }
  simContrastPage2_print();
  goToNext();
  
  /* --------------- CHAPTER 3: 4 Colors Into 3 --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 03: 4 Colors Into 3", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  chap3Intro();
  
  goToNext(); 
  
  // 3 pages for Chapter 3
  for(int i = 0; i < 3; i++) { 
    make4looklike3();
    goToNext();
  }
  make4looklike3_print();
  goToNext();
  
  /* --------------- CHAPTER 4: 5 Colors Into 3 --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 04: 5 Colors Into 3", width/2, height/2); 
  textAlign(LEFT);
  goToNext();

  chap4Intro(); 

  goToNext(); 
  
  // 3 pages for Chapter 4
  for(int i = 0; i < 3; i++) { 
    make5looklike3();
    goToNext();
  }
  make5looklike3_print();
  goToNext();
  
  /* --------------- CHAPTER 5: Color Modulation --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 05: Color Modulation", width/2, height/2); 
  textAlign(LEFT);
  goToNext();

  chap5Intro();

  goToNext();
  
  // 5 pages for Chapter 5
  for(int i = 0; i < 5; i++) { 
    modulation();
    goToNext();
  }
  modulation_print();
  goToNext();
  
  /* --------------- CHAPTER 6: Bridging Colors --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 06: Bridging Colors", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  // 3 pages for Chapter 6
  for(int i = 0; i < 3; i++) { 
    simContrastPage4();
    goToNext();
  }
  simContrastPage4_print();
  goToNext();
  
  /* --------------- CHAPTER 7: Same Value Studies --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 07: Same Value Studies", width/2, height/2); 
  textAlign(LEFT);
  goToNext();

  int step = 360/2;
  for(int i = 0; i < 360; i += step) {
    println(str(i) + " " + str(i+step));
    sameValue(i,i+step);
    goToNext();
  }

  sameValue_print();
  goToNext();

  /* --------------- CHAPTER 8: Same Saturation Studies --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Chapter 08: Same Saturation Studies", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  for(int i = 0; i < 360; i += step) {
    sameSaturation(i,i+step);
    goToNext();
  }
  
  /* --------------- APPENDIX: Palettes --------------- */
  
  textFont(titleFont, 120);
  fill(commentFill);
  textAlign(CENTER);
  text("Appendix: Palettes", width/2, height/2); 
  textAlign(LEFT);
  goToNext();
  
  int numimages = 10;
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
  
  textFont(titleFont, 100);
  fill(0);
  textAlign(CENTER);
  text("A special thanks to\nClayton Merrell\nand Bob Bingham\nand Rafael Abreu-Canedo\nfor your guidance and support.", width/2, height*0.4 ); 
  
  textAlign(LEFT); 
  
  //goToNext();
  
  //fill(0); 
  //rect(0,0,width,height); 
  
  // Exit the program 
  println("Finished.");
  exit();
}

void quotePage() { 
  background(255); 
  textAlign(LEFT); 
  textFont(titleFont, 148);
  
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

void nextChapter() {
  PGraphicsPDF pdf = (PGraphicsPDF) g;
  pdf.nextPage();
  
  pgnum++;
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

/* ========================= INTRO PAGES ========================= */

void introPage() {
  fill(0); 
  String para = ""; 
 
para += "Color, \"the property possessed by an object of producing different sensations on the eye as a result of the way the object reflects or emits light\"--according to the Dictionary app on my laptop. Here's another: \"one, or any mixture, of the constituents into which light can be separated in a spectrum or rainbow, sometimes including (loosely) black and white\". Whatever that means. ";
para += "\n\n";
para += "It is believed that color 'ought' to be separate from language, and that the more we try to define or describe color the further we are from truly experiencing it. When I started writing this book it was never my intention to emerge with a definition of what color is--rather, I was interested in understanding color and seeing whether the things we see with our eyes can be reproduced systematically. Methodically. Algorithmically. But the more I tried to develop these algorithms, the more I realized that describing color was exactly what I was trying to do. ";
para += "\n\n";
para += "I am at a stage in my life where I am still trying to understand how things in the world work, still trying to figure out who I am, still suffering from the occasional existential crisis. Since I am probably unqualified to articulate something on behalf of other people, this book is not about how color works for everyone. This is about how color works for me. ";
para += "\n\n";
para += "This is The Colorist's Cookbook. ";
  
  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap1Intro() {
  String para = ""; 
  
para += "Remember the dress that turned into a viral phenomenon? Not that thing Lady Gaga wore to the VMA's that one year--but the one that got famous just because people couldn't decide whether it was black and blue or white and gold? In February 2015, a woman took a picture of a dress she wanted to wear to a wedding, and released the photo on Tumblr after many of her friends disagreed over the color. The picture spread quickly across the Internet, and sparked an intense public debate about the color of the dress. It turns out that this phenomenon can be explained by the pure science of color vision. When scientists pitched in to provide insight into what was going on they found that if the dress was shown in yellow lighting the majority of people would see it as blue and black, while lighting with a blue bias caused people to view the dress as white and gold.* ";
para += "\n\n";
para += "According to color theory, having a color in the background removes that color from the foreground--this is why the dress shown against yellow lighting would make it look less yellow and more blue. I won't get into the specifics of the science behind this because I'm running out of space on this page and frankly I don't fully understand it myself--but this is a very important and interesting concept in color theory that is the basis of many optical illusions. (It also really f**ked me up and made me question whether I was worthy of having perfect color vision.) This chapter is about using this very concept to make 3 colors look like 4. I hope it causes you to lose as much faith in your eyeballs as I did. ";
para += "\n\n";
para += "\n\n";
para += "*Look up #thedress or Dressgate if my summary displeased you and you want to find out more ";

  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap2Intro() {
  String para = ""; 

para += "If you've been keeping up with the code (which you should--I painstakingly included it for a reason!), you could probably observe that everything boils down to just a bunch of math. This is because in computerland, colors (and all other things) are just numbers. Consider this: since every color is expressed as a number, then for a encoding scheme with 6 hexadecimal* numbers the value of colors ranges from 0 to 16,777,215--that gives us a total of 16,777,216 possible colors! Does that mean there are 16 million colors that exist in the world? \n";
para += "\n";
para += "Well...no. It turns out that humans, on average, can only see about 10 million colors in a single viewing condition--so computers really encode 6 million more colors than necessary. So is the answer 10 million, then? Remember that the 10 million refers to the number of colors we can see in a SINGLE viewing condition. How many possible viewing conditions are there? And how do we take into account that color perception can differ from one person to another? That means the real answer is infinity. Now the question is: is the number of colors that exist in the world countably infinite, or uncountably infinite?** I suck at discrete math, so maybe someone else can answer this question for me. \n";
para += "\n";
para += "\n";
para += "*this is just a way of saying base-16, which is a very common numerical system for computers. Normal people think in base-10. \n";
para += "**for those who are not familiar with these terms: in mathland there are two infinities, the uncountable and countable. If that isn't weird enough, it has also been proven that the uncountable infinity is 'bigger' than the countable infinity. \n";

  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap3Intro() {
  String para = ""; 

para += "A guy named Pablo Picasso once said, \"Why do two colors, put one next to the other, sing? Can one really explain this? No. Just as one can never learn how to paint.\" I'm sorry Pab, but I'm going to have to disagree with you on this one because: \n";
para += "\n";
para += "1) I started learning how to paint the moment I taught myself how to hold a brush. I'm still learning. \n";
para += "\n";
para += "2) Although it's true that color harmony is complex and often tricky to articulate, it is not entirely inexplicable. Color theorists are better equipped to answer this than I am, but one reason why two colors may 'sing' when placed next to each other is because aesthetic responses can be evoked by complementary hues that are juxtaposed against each other, or analogous hues that are meshed with each other. \n";
para += "\n";
para += "The logician in me believes that we can always find a reasonable explanation for almost all observable phenomena. The philosopher in me believes that, without the aid of some kind of 'oracle', there is no way for us to really confirm that our explanations are reasonable. I guess this is why I decided to write this book--because I wanted to see if I could prove my selves wrong (and therefore right) by turning the logician into a philosopher, and the philosopher into a logician. \n";
  
  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap4Intro() {
  String para = ""; 

para += "So I probably should be saying something about the next chapter, but I want to tell you a story instead. Last Tuesday, I had to go to my professor's office hours to prepare for an exam. My friend and I made our way to the back corner of the room and sat down, taking out our notes and note-taking instruments and whatever else people possess when they need to study. As more students shuffled into the small office with questions about the material, the afternoon proceeded unremarkably. Some time passed, and as the questions began to slow down I started to have a fairly unremarkable conversation with my friend about Windows computers: ";
para += "\n\n";
para += "\"Oh, you're a Windows person?\" I asked him. \n";
para += "\"Yeah,\" he replied. \n";
para += "\"Okay, I'm not judging,\" I lied. \n";
para += "And then: \n";
para += "\"I am,\" chimed in my professor. \"Macs are better.\"";
para += "\n\n";
para += "And that's when the room was thrown into a passive-aggressive debate about whether Macs were better than Windows machines (or rather, why Windows machines were better than Macs). ";
para += "\n\n";
para += "Now I have a confession to make: for the majority of public situations in which I am surrounded by people who are some combination of scientists/engineers/mathematicians, I generally avoid declaring myself as an art student--not out of shame but as a precautionary measure to avoid hostility and having metaphorical daggers thrown at my back. But for whatever reason, on that unremarkable Tuesday, during that unremarkable conversation, it was exactly what I did. ";
  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap5Intro() {
  String para = ""; 

para += "\"I think as an art person,\" I started boldly. \"I am naturally inclined to like Macs more,\" I could feel the daggers digging into my spine. \"It's just--\" as the daggers made their way deeper into my skin, I found myself helplessly fumbling for words--\"I don't know, the colors are just...nicer?\" ";
para += "\n\n";
para += "A heavy silence. ";
para += "\n\n";
para += "And then: ";
para += "\"That's not a valid reason,\" argued the guy across the table. ";
para += "\n\n";
para += "Is it? ";
para += "\n\n";
para += "When were colors ever 'a valid reason'? ";

  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

void chap6Intro() {
  String para = ""; 

para += "You may have noticed that some of the studies you've seen so far work pretty effectively, while others don't seem to work at all. ";
para += "\n\n";
para += "You may be waiting for me to provide you with some sort of explanation for that. ";
para += "\n\n";
para += "You may be stopping and asking yourself, 'Is this really ART???' ";
para += "\n\n";
para += "You may be debating whether you should just skip this useless expository text or read on. ";
para += "\n\n";
para += "You may be sitting on your living room couch right now--winding and rewinding your mind--trying to pull yourself back to the time when you were able to feel the warm sun on your face without having to worry about getting burned later, when Tuesdays were good and you didn't miss the tingle of someone else's breath on your skin. ";
para += "\n\n";
para += "You may be wondering what that previous sentence has to do with anything. ";
para += "\n\n";
para += "You may not even care. But even if you don't, thanks for caring enough to read on.";

  pushMatrix();

  textFont(mainFont, 60);
  text(para, width*0.2, height*0.2, width*0.6, height*0.8);
  popMatrix();
}

/* ========================= MAIN PAGES ========================= */

// simple demonstrations of simulataneous contrast
void simContrastPage1() {
  // recipe for making 3 colors look like 4
  
  // prepare the first color
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 255;
  int r1 = random.nextInt(max-min+1)+min;
  int g1 = random.nextInt(max-min+1)+min;
  int b1 = random.nextInt(max-min+1)+min;
  color col1 = color(r1, g1, b1);
  
  // then prepare the second color
  int r2 = random.nextInt(max-min+1)+min;
  int g2 = random.nextInt(max-min+1)+min;
  int b2 = random.nextInt(max-min+1)+min;
  color col2 = color(r2, g2, b2);
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
  
  // arrange the first two colors beside each other
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
text("  // recipe for making 3 colors look like 4", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 255;\n";
code += "  int r1 = random.nextInt(max-min+1)+min;\n";
code += "  int g1 = random.nextInt(max-min+1)+min;\n";
code += "  int b1 = random.nextInt(max-min+1)+min;\n";
code += "  color col1 = color(r1, g1, b1);\n";
code += "\n";
fill(commentFill);
text("  // then prepare the second color", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  int r2 = random.nextInt(max-min+1)+min;\n";
code += "  int g2 = random.nextInt(max-min+1)+min;\n";
code += "  int b2 = random.nextInt(max-min+1)+min;\n";
code += "  color col2 = color(r2, g2, b2);\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));\n";
code += "  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));\n";
code += "  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));\n";
code += "\n";
code += "  color mid = color(mixedred, mixedgreen, mixedblue);\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 1656, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 1725, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
fill(commentFill);
text("  // arrange the first two colors beside each other", 0, 69, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle color", 0, 621, width*0.8, height*0.8);
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
  // recipe for making 3 colors look like 4...with holes!
  
  // prepare the first color
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 255;
  int r1 = random.nextInt(max-min+1)+min;
  int g1 = random.nextInt(max-min+1)+min;
  int b1 = random.nextInt(max-min+1)+min;
  color col1 = color(r1, g1, b1);
  
  // then prepare the second color
  int r2 = random.nextInt(max-min+1)+min;
  int g2 = random.nextInt(max-min+1)+min;
  int b2 = random.nextInt(max-min+1)+min;
  color col2 = color(r2, g2, b2);
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
  
  // arrange first two colors beside each other
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
text("  // recipe for making 3 colors look like 4...with holes!", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 255;\n";
code += "  int r1 = random.nextInt(max-min+1)+min;\n";
code += "  int g1 = random.nextInt(max-min+1)+min;\n";
code += "  int b1 = random.nextInt(max-min+1)+min;\n";
code += "  color col1 = color(r1, g1, b1);\n";
code += "\n";
fill(commentFill);
text("  // then prepare the second color", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  int r2 = random.nextInt(max-min+1)+min;\n";
code += "  int g2 = random.nextInt(max-min+1)+min;\n";
code += "  int b2 = random.nextInt(max-min+1)+min;\n";
code += "  color col2 = color(r2, g2, b2);\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));\n";
code += "  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));\n";
code += "  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));\n";
code += "\n";
code += "  color mid = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 1725, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 1794, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange first two colors beside each other", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth/2f,pgheight);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(pgwidth/2f,0,pgwidth/2f,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle color", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  rectMode(CENTER);\n";
code += "  fill(mid);\n";
code += "  noStroke();\n";
code += "  rect((pgwidth)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "  rect((pgwidth*3f)/4f,pgheight/2f,pgwidth/5f,pgheight/2f);\n";
code += "\n";
fill(commentFill);
text("  // slice holes in the middle for a more dramatic effect", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // waffle aesthetic", 0, 1242, width*0.8, height*0.8);
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
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  pushMatrix();\n";
code += "\n";
code += "  for(int rows = 0; rows < 6; rows++) {\n";
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

void modulation() {
  // recipe for color modulation 
  
  SecureRandom random = new SecureRandom();
  
  // prepare the first color
  int min = 0;
  int max = 255;
  int r1 = random.nextInt(max-min+1)+min;
  int g1 = random.nextInt(max-min+1)+min;
  int b1 = random.nextInt(max-min+1)+min;
  color col1 = color(r1, g1, b1);
  
  // then prepare the second color
  int r2 = random.nextInt(max-min+1)+min;
  int g2 = random.nextInt(max-min+1)+min;
  int b2 = random.nextInt(max-min+1)+min;
  color col2 = color(r2, g2, b2);
  
  // make preliminary calculations
  float numsteps = 7;
  float step = (1.0)/(numsteps-1); 
  float c1_weight = 1; // the starting weight for the first color
  float c2_weight = 0;  // the starting weight for the second color
  float gapsize = 10; 
  float rectwidth = pgwidth/numsteps - gapsize; 
  
  pushMatrix();
  translate(margin, margin);
  noStroke();
  textFont(mainFont, 60);
  for(int i = 0; i < numsteps; i++) { 
    // get a weighted average of the red, green, blue channels
    float mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(col2))*c2_weight));
    float mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(col2))*c2_weight));
    float mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(col2))*c2_weight));
    
    // prepare the color strip
    color stripcol = color(mixedred, mixedgreen, mixedblue);
    fill(stripcol);
    float posx = (rectwidth + gapsize)*i; 
    
    // lay down the color strip
    rect(posx, 0, rectwidth, pgheight);
    
    text("0x"+hex(stripcol), posx, height*0.05 - margin);
    c1_weight -= step;
    c2_weight += step;
    
  }
  
  popMatrix();
}

void modulation_print() {
  fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for color modulation", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
fill(commentFill);
text("  // prepare the first color", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 255;\n";
code += "  int r1 = random.nextInt(max-min+1)+min;\n";
code += "  int g1 = random.nextInt(max-min+1)+min;\n";
code += "  int b1 = random.nextInt(max-min+1)+min;\n";
code += "  color col1 = color(r1, g1, b1);\n";
code += "\n";
fill(commentFill);
text("  // then prepare the second color", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  int r2 = random.nextInt(max-min+1)+min;\n";
code += "  int g2 = random.nextInt(max-min+1)+min;\n";
code += "  int b2 = random.nextInt(max-min+1)+min;\n";
code += "  color col2 = color(r2, g2, b2);\n";
code += "\n";
fill(commentFill);
text("  // make preliminary calculations", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float numsteps = 7;\n";
code += "  float step = (1.0)/(numsteps-1);\n";
code += "  float c1_weight = 1; // the starting weight for the first color\n";
code += "  float c2_weight = 0;  // the starting weight for the second color\n";
code += "  float gapsize = 10;\n";
code += "  float rectwidth = pgwidth/numsteps - gapsize;\n";
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "  noStroke();\n";
code += "  textFont(mainFont, 60);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  for(int i = 0; i < numsteps; i++) {\n";
fill(commentFill);
text("    // get a weighted average of the red, green, blue channels", 0, 69, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    float mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(col2))*c2_weight));\n";
code += "    float mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(col2))*c2_weight));\n";
code += "    float mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(col2))*c2_weight));\n";
code += "\n";
fill(commentFill);
text("    // prepare the color strip", 0, 414, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    color stripcol = color(mixedred, mixedgreen, mixedblue);\n";
code += "    fill(stripcol);\n";
code += "    float posx = (rectwidth + gapsize)*i;\n";
code += "\n";
fill(commentFill);
text("    // lay down the color strip", 0, 759, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    rect(posx, 0, rectwidth, pgheight);\n";
code += "\n";
code += "    text(\"0x\"+hex(stripcol), posx, height*0.05 - margin);\n";
code += "    c1_weight -= step;\n";
code += "    c2_weight += step;\n";
code += "\n";
code += "  }\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();

}
// make 4 colors look like 3
void make4looklike3() {
  // recipe for making 5 colors look like 3 
  // prepare the first and second colors
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 255;
  int r1 = random.nextInt(max-min+1)+min;
  int g1 = random.nextInt(max-min+1)+min;
  int b1 = random.nextInt(max-min+1)+min;
  color col1 = color(r1, g1, b1);
  
  // the second color is opposite from the first color
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
  
  // calculate a weighted average of the first color and middle color
  mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(mid))*c2_weight));
  mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(mid))*c2_weight));
  mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(mid))*c2_weight));
  
  color mixed1 = color(mixedred, mixedgreen, mixedblue);
  
  // calculate a weighted average of the second color and middle color
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
  rect(0,0,pgwidth,pgheight/2);
  fill(col2);
  stroke(col2); 
  rect(0,pgheight/2,pgwidth,pgheight/2);
  
  // top with the middle colors
  fill(mixed1);
  noStroke(); 
  rect(pgwidth/3, pgheight/6, pgwidth/3, pgheight/6);  
  
  fill(mixed2); 
  rect((pgwidth)/3, (pgheight*2)/3, pgwidth/3, pgheight/6); 
  
  
  popMatrix();
  
  textFont(mainFont, 60);
  fill(col1);
  text("0x"+hex(col1), width*0.05, height*0.05);
  fill(col2);
  text("0x"+hex(col2), width*0.05 + 300, height*0.05);
  fill(mixed1);
  text("0x"+hex(mixed1), width*0.05 + 600, height*0.05);
  fill(mixed2);
  text("0x"+hex(mixed2), width*0.05 + 900, height*0.05);
  
}

void make4looklike3_print() {
  fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for making 4 colors look like 3", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // prepare the first and second colors", 0, 69, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 255;\n";
code += "  int r1 = random.nextInt(max-min+1)+min;\n";
code += "  int g1 = random.nextInt(max-min+1)+min;\n";
code += "  int b1 = random.nextInt(max-min+1)+min;\n";
code += "  color col1 = color(r1, g1, b1);\n";
code += "\n";
fill(commentFill);
text("  // the second color is opposite from the first color", 0, 759, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color col2 = color(255 - red(col1),\n";
code += "                      255 - green(col1),\n";
code += "                      255 - blue(col1));\n";
code += "\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1104, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));\n";
code += "  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));\n";
code += "  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));\n";
code += "\n";
code += "  color mid = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
code += "  float c1_weight = 0.35;\n";
code += "  float c2_weight = 0.65;\n";
code += "\n";
fill(commentFill);
text("  // calculate a weighted average of the first color and middle color", 0, 1863, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(mid))*c2_weight));\n";
code += "  mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(mid))*c2_weight));\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(mid))*c2_weight));\n";
code += "\n";
code += "  color mixed1 = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
fill(commentFill);
text("  // calculate a weighted average of the second color and middle color", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  mixedred = sqrt((sq(red(col2))*c1_weight +sq(red(mid))*c2_weight));\n";
code += "  mixedgreen = sqrt((sq(green(col2))*c1_weight +sq(green(mid))*c2_weight));\n";
code += "  mixedblue = sqrt((sq(blue(col2))*c1_weight +sq(blue(mid))*c2_weight));\n";
code += "\n";
code += "  color mixed2 = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 759, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange opposing colors beside each other", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth,pgheight/2);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(0,pgheight/2,pgwidth,pgheight/2);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle colors", 0, 1794, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(mixed1);\n";
code += "  noStroke();\n";
code += "  rect(pgwidth/3, pgheight/6, pgwidth/3, pgheight/6);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
code += "  fill(mixed2);\n";
code += "  rect((pgwidth)/3, (pgheight*2)/3, pgwidth/3, pgheight/6);\n";
code += "\n";
code += "\n";
code += "  popMatrix();\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();

}
 
 
void make5looklike3() {
  // recipe for making 5 colors look like 3 
  // prepare the first and second colors
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 255;
  int r1 = random.nextInt(max-min+1)+min;
  int g1 = random.nextInt(max-min+1)+min;
  int b1 = random.nextInt(max-min+1)+min;
  color col1 = color(r1, g1, b1);
  
  // the second color is opposite from the first color
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
  
  // calculate a weighted average of the first color and middle color
  mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(mid))*c2_weight));
  mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(mid))*c2_weight));
  mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(mid))*c2_weight));
  
  color mixed1 = color(mixedred, mixedgreen, mixedblue);
  
  // calculate a weighted average of the second color and middle color
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
  rect(0,0,pgwidth,pgheight/2);
  fill(col2);
  stroke(col2); 
  rect(0,pgheight/2,pgwidth,pgheight/2);
  
  // top with the middle colors
  fill(mixed1);
  noStroke(); 
  rect(pgwidth/3, pgheight/6, pgwidth/3, pgheight/6);  
  
  fill(mixed2); 
  rect((pgwidth)/3, (pgheight*2)/3, pgwidth/3, pgheight/6); 
  
  fill(mid); 
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

void make5looklike3_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix();
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for making 5 colors look like 3", 0, 0, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // prepare the first and second colors", 0, 69, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 255;\n";
code += "  int r1 = random.nextInt(max-min+1)+min;\n";
code += "  int g1 = random.nextInt(max-min+1)+min;\n";
code += "  int b1 = random.nextInt(max-min+1)+min;\n";
code += "  color col1 = color(r1, g1, b1);\n";
code += "\n";
fill(commentFill);
text("  // the second color is opposite from the first color", 0, 759, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color col2 = color(255 - red(col1),\n";
code += "                      255 - green(col1),\n";
code += "                      255 - blue(col1));\n";
code += "\n";
fill(commentFill);
text("  // evenly mix the first two colors to create", 0, 1104, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // the 'middle' color", 0, 1173, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  float mixedred = sqrt((sq(red(col1))*0.5 +sq(red(col2))*0.5));\n";
code += "  float mixedgreen = sqrt((sq(green(col1))*0.5 +sq(green(col2))*0.5));\n";
code += "  float mixedblue = sqrt((sq(blue(col1))*0.5 +sq(blue(col2))*0.5));\n";
code += "\n";
code += "  color mid = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
code += "  float c1_weight = 0.35;\n";
code += "  float c2_weight = 0.65;\n";
code += "\n";
fill(commentFill);
text("  // calculate a weighted average of the first color and middle color", 0, 1863, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  mixedred = sqrt((sq(red(col1))*c1_weight +sq(red(mid))*c2_weight));\n";
code += "  mixedgreen = sqrt((sq(green(col1))*c1_weight +sq(green(mid))*c2_weight));\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "  mixedblue = sqrt((sq(blue(col1))*c1_weight +sq(blue(mid))*c2_weight));\n";
code += "\n";
code += "  color mixed1 = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
fill(commentFill);
text("  // calculate a weighted average of the second color and middle color", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  mixedred = sqrt((sq(red(col2))*c1_weight +sq(red(mid))*c2_weight));\n";
code += "  mixedgreen = sqrt((sq(green(col2))*c1_weight +sq(green(mid))*c2_weight));\n";
code += "  mixedblue = sqrt((sq(blue(col2))*c1_weight +sq(blue(mid))*c2_weight));\n";
code += "\n";
code += "  color mixed2 = color(mixedred, mixedgreen, mixedblue);\n";
code += "\n";
fill(commentFill);
text("  // pre-translate the transformation matrix", 0, 759, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // to the size of your margins", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "\n";
fill(commentFill);
text("  // arrange opposing colors beside each other", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(col1);\n";
code += "  stroke(col1);\n";
code += "  rect(0,0,pgwidth,pgheight/2);\n";
code += "  fill(col2);\n";
code += "  stroke(col2);\n";
code += "  rect(0,pgheight/2,pgwidth,pgheight/2);\n";
code += "\n";
fill(commentFill);
text("  // top with the middle colors", 0, 1794, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  fill(mixed1);\n";
code += "  noStroke();\n";
code += "  rect(pgwidth/3, pgheight/6, pgwidth/3, pgheight/6);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
code += "  fill(mixed2);\n";
code += "  rect((pgwidth)/3, (pgheight*2)/3, pgwidth/3, pgheight/6);\n";
code += "\n";
code += "  fill(mid);\n";
code += "  rect(pgwidth/3, pgheight*0.4375, pgwidth/3, pgheight/8);\n";
code += "\n";
code += "  popMatrix();\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

// painterly study 
void simContrastPage4() {
  // recipe for using bridging colors
  
  // switch working color mode to HSB
  // before preparing the foreground color
  colorMode(HSB,360,100,100); 
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 360;
  int h1 = random.nextInt(max-min+1)+min;
  int h2 = random.nextInt(max-min+1)+min;
  
  color col1 = color(h1, random(90,100), random(80,100));
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin, margin);
  noStroke(); 
  
  // glaze with the background color, which is opposite from the foreground color
  // with a touch of randomness
  color bg = color((hue(col1)+180+h2)%360, random(90,100), random(80,100));
  
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
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 0;\n";
code += "  int max = 360;\n";
code += "  int h1 = random.nextInt(max-min+1)+min;\n";
code += "\n";
code += "  color col1 = color(h1, random(90,100), random(80,100));\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  pushMatrix();\n";
code += "  translate(margin, margin);\n";
code += "  noStroke();\n";
code += "\n";
fill(commentFill);
text("  // glaze with the background color, which is opposite from the foreground color", 0, 1242, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // with a touch of randomness", 0, 1311, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  color bg = color((hue(col1)+180+h2)%360, random(90,100), random(80,100));\n";
code += "  fill(bg);\n";
code += "  rect(0, 0, pgwidth,pgheight);\n";
code += "\n";
fill(commentFill);
text("  // randomly add 90 slices of the foreground color", 0, 1656, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < 90; i++) {\n";
code += "    float posX = random(0, pgwidth-200);\n";
code += "    float posY = random(0, pgheight-200);\n";
code += "\n";
code += "    float rectw = random(100, min(1200, pgwidth-posX));\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "    float recth = random(200, min(800, pgheight-posY));\n";
code += "\n";
fill(commentFill);
text("    // the slices can overlap with each other,", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("    // but they must be thin", 0, 207, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("    // like prosciutto", 0, 276, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    fill(col1, 50);\n";
code += "    rect(posX, posY, rectw,recth);\n";
code += "\n";
code += "  }\n";
code += "\n";
fill(commentFill);
text("  // for balance, top with a few thin slices of the background color", 0, 690, width*0.8, height*0.8);
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
code += "  colorMode(RGB);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();


}

void sameValue(int huemin, int huemax) {
  // recipe for same value studies (a la Johannes Itten)
  
  // we're working in HSB space now!
  // RGB is for posers
  colorMode(HSB,360,100,100); 
  SecureRandom random = new SecureRandom();
  
  int min = 40;
  int max = 95;
  int value = random.nextInt(max-min+1)+min;

  // boundaries for saturation
  int satmin = 0;
  int satmax = 100;
  
  // noise variables
  int noisemin = 0;
  int noisemax = 100;
  float hoff = random.nextInt(noisemax-noisemin+1)+noisemin; 
  float soff = random.nextInt(noisemax-noisemin+1)+noisemin; 
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin + 500, margin);
  noStroke(); 
  
  // sprinkle squares in a matrix
  for(int row = 0; row < 5; row++) {
    for(int col = 0; col < 5; col++) {

      // instead of using random, I'm mapping the colors to noise
      // noise is a bit more 'organic' than random
      float hue = map(noise(hoff), 0,1, huemin,huemax); 
      float sat = map(noise(soff), 0,1, satmin,satmax); 
      color squarecol = color(hue, sat, value); 
      
      fill(squarecol);
      stroke(squarecol);
      rect(400*col, 400*row, 400, 400);

      // add a touch of magic numbers
      hoff += 0.55; 
      soff += 0.3; 
    }
    
  }
  
  popMatrix();
  colorMode(RGB);
  
  textFont(mainFont, 60);
  fill(0);
  text("value: " +value, width*0.05, height*0.05);
}

void sameValue_print() {
fill(0);
textAlign(LEFT);
rectMode(CORNER);
textFont(mainFont, 60);
pushMatrix(); 
translate(200, 200 );
String code = "";
fill(commentFill);
text("  // recipe for same value studies (a la Johannes Itten)", 0,0,width*0.8,height*0.8);
fill(0);
code += "\n";code += "\n";
fill(commentFill);
text("  // we're working in HSB space now!", 0,138,width*0.8,height*0.8);
fill(0);
code += "\n";fill(commentFill);
text("  // RGB is for posers", 0,207,width*0.8,height*0.8);
fill(0);
code += "\n";code += "  colorMode(HSB,360,100,100);\n";
code += "  SecureRandom random = new SecureRandom();\n";
code += "\n";
code += "  int min = 40;\n";
code += "  int max = 95;\n";
code += "  int value = random.nextInt(max-min+1)+min;\n";
code += "\n";
fill(commentFill);
text("  // boundaries for saturation", 0,759,width*0.8,height*0.8);
fill(0);
code += "\n";code += "  int satmin = 0;\n";
code += "  int satmax = 100;\n";
code += "\n";
fill(commentFill);
text("  // noise variables", 0,1035,width*0.8,height*0.8);
fill(0);
code += "\n";code += "  int noisemin = 0;\n";
code += "  int noisemax = 100;\n";
code += "  float hoff = random.nextInt(noisemax-noisemin+1)+noisemin;\n";
code += "  float soff = random.nextInt(noisemax-noisemin+1)+noisemin;\n";
code += "\n";
code += "  rectMode(CORNER);\n";
code += "  pushMatrix();\n";
code += "  translate(margin + 500, margin);\n";
code += "  noStroke();\n";
code += "\n";
fill(commentFill);
text("  // sprinkle squares in a matrix", 0,1794,width*0.8,height*0.8);
fill(0);
code += "\n";code += "  for(int row = 0; row < 5; row++) {\n";
code += "    for(int col = 0; col < 5; col++) {\n";
code += "\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
fill(commentFill);
text("      // instead of using random, I'm mapping the colors to noise", 0,0,width*0.8,height*0.8);
fill(0);
code += "\n";fill(commentFill);
text("      // noise is a bit more 'organic' than random", 0,69,width*0.8,height*0.8);
fill(0);
code += "\n";code += "      float hue = map(noise(hoff), 0,1, huemin,huemax);\n";
code += "      float sat = map(noise(soff), 0,1, satmin,satmax);\n";
code += "      color squarecol = color(hue, sat, value);\n";
code += "\n";
code += "      fill(squarecol);\n";
code += "      stroke(squarecol);\n";
code += "      rect(400*col, 400*row, 400, 400);\n";
code += "\n";
fill(commentFill);
text("      // add a touch of magic numbers", 0,690,width*0.8,height*0.8);
fill(0);
code += "\n";code += "      hoff += 0.55;\n";
code += "      soff += 0.3;\n";
code += "    }\n";
code += "\n";
code += "  }\n";
code += "\n";
code += "  popMatrix();\n";
code += "  colorMode(RGB);\n";
code += "\n";
code += "  textFont(mainFont, 60);\n";
code += "  fill(0);\n";
code += "  text(\"value: \" +value, width*0.05, height*0.05);\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
}


void sameSaturation(int huemin, int huemax) {
  // recipe for same saturation studies
  
  // we're working in HSB space now!
  // RGB is for posers
  colorMode(HSB,360,100,100); 
  SecureRandom random = new SecureRandom();
  
  int min = 0;
  int max = 100;
  int sat = random.nextInt(max-min+1)+min;

  // boundaries for value
  // (can't go too dark or else it will hardly be visible)
  int valmin = 40;
  int valmax = 95;
  
  // noise variables
  int noisemin = 0;
  int noisemax = 100;
  float hoff = random.nextInt(noisemax-noisemin+1)+noisemin; 
  float voff = random.nextInt(noisemax-noisemin+1)+noisemin; 
  
  rectMode(CORNER);
  pushMatrix();
  translate(margin + 500, margin);
  noStroke(); 
  
  // sprinkle squares in a matrix
  for(int row = 0; row < 5; row++) {
    for(int col = 0; col < 5; col++) {

      // instead of using random, I'm mapping the colors to noise
      // noise is a bit more 'organic' than random
      float hue = map(noise(hoff), 0,1, huemin,huemax); 
      float val = map(noise(voff), 0,1, valmin,valmax); 
      color squarecol = color(hue, sat, val); 
      
      fill(squarecol);
      stroke(squarecol);
      rect(400*col, 400*row, 400, 400);

      // add a touch of magic numbers
      hoff += 0.55; 
      voff += 0.3; 
    }
    
  }
  
  popMatrix();
  colorMode(RGB);
  
  textFont(mainFont, 60);
  fill(0);
  text("saturation: " +sat, width*0.05, height*0.05);
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
code += "ArrayList<Pixel> colors = new ArrayList<Pixel>();\n";
code += "float tolerance = 50.0;\n";
code += "int totalCount = 0;\n";
code += "float proptolerance = 0.005;\n";
code += "PImage[] images = new PImage[folderimages];\n";
code += "String[] names = new String[folderimages];\n";
code += "\n";
fill(commentFill);
text("// recipe for palette grabber", 0, 483, width*0.8, height*0.8);
fill(0);
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
text("  // head of  the color group", 0, 1587, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  p.pixelgroup = new ArrayList();\n";
code += "  p.pixelgroup.add(currpix);\n";
code += "  p.count = 1;\n";
code += "  colors.add(p);\n";
code += "  totalCount++;\n";
code += "}\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
code += "boolean notBlackorWhite(color col) {\n";
code += "  return ((col != 0.0) && (col != 255.0));\n";
code += "}\n";
code += "\n";
code += "void palettePage(int imgindex) {\n";
code += "  totalCount = 0;\n";
code += "\n";
fill(commentFill);
text("  // rinse palette before use", 0, 552, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = colors.size()-1; i >= 0 ; i--) {\n";
code += "     colors.remove(i);\n";
code += "  }\n";
code += "  PImage sourceimg = images[imgindex];\n";
code += "\n";
code += "  sourceimg.resize(0, (int)pgheight);\n";
code += "  int iwidth = sourceimg.width;\n";
code += "  int iheight = sourceimg.height;\n";
code += "  color temp = sourceimg.get(0,0);\n";
code += "  float palettepos = sourceimg.width + 50;\n";
code += "\n";
fill(commentFill);
text("  // extract colors from image", 0, 1380, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("  // and add them to the palette", 0, 1449, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < iheight; i++) {\n";
code += "    for(int j = 0; j < iwidth; j++) {\n";
code += "      color currpix = sourceimg.get(i,j);\n";
code += "\n";
code += "      if(notBlackorWhite(currpix)) {\n";
code += "        if(colors.size() == 0) {\n";
code += "          addPixel(currpix);\n";
code += "        }\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
code += "        else {\n";
code += "          int idx;\n";
code += "          boolean foundMatch = false;\n";
code += "          int prevIdx = 0;\n";
code += "          float minDist = 0.0;\n";
code += "\n";
fill(commentFill);
text("          // look through existing colors in the palette", 0, 483, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "          for(idx = 0; idx < colors.size(); idx++) {\n";
code += "            float currDist = colorDist(currpix, (Integer) colors.get(idx).pixelgroup.get(0));\n";
fill(commentFill);
text("            // if the color is in the palette", 0, 690, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "            if(currDist < tolerance) {\n";
fill(commentFill);
text("                  // increase the count for the palette color closest to", 0, 828, width*0.8, height*0.8);
fill(0);
code += "\n";
fill(commentFill);
text("                  // the current pixel", 0, 897, width*0.8, height*0.8);
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
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "                }\n";
code += "          }\n";
code += "\n";
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
text("  // place image a little to the right of your margins", 0, 1725, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  translate(margin + 700, margin);\n";
code += "  image(sourceimg, 0,0);\n";
fill(commentFill);
text("  // place palette beside image", 0, 1932, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "  for(int i = 0; i < colors.size(); i++) {\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "    float prop = colors.get(i).count / ((float)netCount);\n";
code += "\n";
fill(commentFill);
text("    // if there is enough of the color in the image, display it", 0, 138, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "    if(prop >= proptolerance) {\n";
code += "      float rheight = pgheight*prop;\n";
code += "      float totred = 0;\n";
code += "      float totgreen = 0;\n";
code += "      float totblue = 0;\n";
code += "\n";
fill(commentFill);
text("      // calculate an average value of the colors in each group", 0, 621, width*0.8, height*0.8);
fill(0);
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
text("      // top it off with the hex value for the colors", 0, 1656, width*0.8, height*0.8);
fill(0);
code += "\n";
code += "      textFont(mainFont, 40);\n";
code += "      fill(paletteColor);\n";
code += "      text(\"0x\"+hex(paletteColor), palettepos + 350, ypos+30);\n";
code += "\n";
code += "      ypos += rheight;\n";
text(code, 0, 0, width*0.8, height*0.8);
popMatrix();
goToNext();
code = "";
pushMatrix();
translate(200, 200 );
textFont(mainFont, 60);
code += "\n";
code += "    }\n";
code += "  }\n";
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
  //translate(width/2,height/2); 
  
  textAlign(CENTER); 
  textFont(titleFont, 45);
  //text("The", width/2, height/2);
 
  textFont(titleFont, 148);
 
  // value determines the color of 'Colorist'
  int titleFill = int(random(4));
  
  if(titleFill == 0) {
    // fill with pink
    fill(#EC394E);
    commentFill = #FF5891;
  }
  else if(titleFill == 1) {
    // fill with orange
    fill(#FFA500);
    commentFill = #ffa500;
  }
  else if(titleFill == 2) {
    // fill with green
    commentFill = #b8da44;
  }
  else {
    // fill with blue
    fill(#40e0d0);
    commentFill = #40e0d0;
  }
  //text("Colorist's", width/2, height/2+200);
  //fill(255);
  //text("Cookbook", width/2, height/2+450);
 
  
  popMatrix();
}