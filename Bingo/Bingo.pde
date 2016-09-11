int number[] = new int[75];
int outNumber[] = new int[75];
int count = 0;
int i = 0;
int hist[] = new int[75];
boolean isBingo;
boolean isHist;
boolean isStart;
boolean isEnd;
int machinePosY;
int ballPos;
PFont alg;
PFont yu;
PFont humi;

void setup() {
  size(800, 800);
  alg = loadFont("Algerian-96.vlw");
  yu = loadFont("富士ポップ-48.vlw");
  humi = loadFont("ふみwide-96.vlw");
  textAlign(CENTER, CENTER);
  background(86, 197, 255);
  strokeWeight(3);
  fill(0);
  isBingo = false;
  isHist = false;
  isStart = false;
  isEnd = false;
  machinePosY = height/2;
  ballPos = height/2;
}

void draw() {
  background(86, 197, 255);
  textFont(yu);
  fill(86, 197, 255);
  noStroke();
  rect(0, 0, width, 30);
  if (isHist) {
    history();
  } else {
    if (isStart && isBingo == false) {
      fill(0);
      textSize(24);
      text("履歴：x", height-200, 25);
      bingoMenu();
      bingoMachineReady();
    } else if (isStart && isBingo) {
      bingoMachine();
      if (machinePosY < 80) bingoNum();
    } else {
      menu();
    }
  }
}

void keyPressed() {
  if (keyCode == ENTER) {
    if (isBingo == false && isStart == false) {
      isStart = true;
    } else if (isHist == false && isBingo == false && isStart) {
      isBingo = true;
      count++;
    } else if (isEnd) {
      isBingo = false;
      isEnd = false;
      machinePosY = height/2;
      ballPos = height/2;
      i = 0;
      loop();
    } else if (isBingo && isStart) {
      machinePosY = 0;
    }
  }
  if (key == 'x') {
    if (isHist == false && isBingo == false && isStart) {
      isHist = true;
    } else if (isHist && isBingo == false && isStart) {
      isHist = false;
    }
  }
}

void bingoNum() {
  background(86, 197, 255);
  int ball;
  do {
    ball = (int)random(75);
  } while (number[ball] == -1);
  number[ball] = -1;
  hist[count-1] = ball+1;
  noStroke();
  fill(204, 204, 0);
  ellipse(width/2, height/2, 250, 250);
  stroke(4);
  fill(255, 255, 0);
  ellipse(width/2, height/2, 250, 250);
  textSize(56);
  textFont(alg);
  fill(0);
  text(nf(ball+1, 2), width/2, height/2);
  isEnd = true;
  noLoop();
}

void bingoMachineReady() {
  pushMatrix();
  translate(width/2, height/2-100);
  rotate(radians(i));
  i+=1;
  if (i == 360) i = 0;
  fill(200, 165, 103);
  beginShape();
  vertex(-150, 80);
  vertex(-80, 150);
  vertex(80, 150);
  vertex(150, 80);
  vertex(150, -80);
  vertex(80, -150);
  vertex(-80, -150);
  vertex(-150, -80);
  vertex(-150, 80);
  endShape();

  noStroke();
  fill(219, 214, 162);
  beginShape();
  vertex(-135, 72);
  vertex(-72, 135);
  vertex(72, 135);
  vertex(135, 72);
  vertex(135, -72);
  vertex(72, -135);
  vertex(-72, -135);
  vertex(-135, -72);
  vertex(-135, 72);
  endShape();

  fill(110, 110, 110);
  ellipse(0, 0, 20, 20);
  fill(150, 150, 150);
  ellipse(0, 0, 10, 10);
  rectMode(CENTER);
  rect(0, -30, 10, 60);
  fill(158, 79, 45);
  ellipse(0, -60, 25, 25);
  popMatrix();
}

void bingoMachine() {
  if (i >= 585) {
    stroke(0);
    strokeWeight(2);
    fill(255, 255, 0);
    ellipse(width/2, ballPos, 50, 50);
    ballPos += 10;
  }
  noStroke();
  pushMatrix();
  translate(width/2, machinePosY);
  if (i >= 585) machinePosY -= 5;
  rotate(radians(i));
  if (i >= 585) {
    i=585;
  } else {
    i+=8;
  }
  fill(200, 165, 103);
  beginShape();
  vertex(-150, 80);
  vertex(-80, 150);
  vertex(80, 150);
  vertex(150, 80);
  vertex(150, -80);
  vertex(80, -150);
  vertex(-80, -150);
  vertex(-150, -80);
  vertex(-150, 80);
  endShape();

  noStroke();
  fill(219, 214, 162);
  beginShape();
  vertex(-135, 72);
  vertex(-72, 135);
  vertex(72, 135);
  vertex(135, 72);
  vertex(135, -72);
  vertex(72, -135);
  vertex(-72, -135);
  vertex(-135, -72);
  vertex(-135, 72);
  endShape();

  fill(110, 110, 110);
  ellipse(0, 0, 20, 20);
  fill(150, 150, 150);
  ellipse(0, 0, 10, 10);
  rectMode(CENTER);
  rect(0, -30, 10, 60);
  fill(158, 79, 45);
  ellipse(0, -60, 25, 25);
  popMatrix();
}

void menu() {
  textSize(72);
  fill(245, 216, 116);
  textFont(humi);
  text("＊ ＢＩＮＧＯ ＊", width/2, height/2-100);
  textFont(alg);
  textSize(40);
  text("Press ENTER to START", width/2, height/2+200);
}

void bingoMenu() {
  if (count < 75) {
    textSize(30);
    text((count+1) + "回目", width/2, height/2+200);
    text("Ｐｒｅｓｓ ＥＮＴＥＲ！", width/2, height/2+250);
  } else {
    textSize(32);
    text("全ての数字が出ました！", width/2, height/2+100);
    textSize(40);
    fill(109, 154, 74);
    text("Thanks for Playing!!", width/2, height/2+200);
    noLoop();
  }
}

void history() {
  int j = 0;
  fill(0);
  textSize(32);
  text("履歴一覧", 150, 60);
  textSize(22);
  for (int n = count; n > 0; n--) {  //count分の履歴表示
    if (j < 30) {
      text(nf(n, 2) + " 回目：" + nf(hist[n-1], 2), width/6, 100+j*22);
    } else if (j >= 30 && j < 60) {
      text(nf(n, 2) + " 回目：" + nf(hist[n-1], 2), width/2, 100+j*22-660);
    } else {
      text(nf(n, 2) + " 回目：" + nf(hist[n-1], 2), width*5/6, 100+j*22-1320);
    }
      j++;
  }
}