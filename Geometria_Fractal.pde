ArrayList<Bee> bees;
int maxBees = 20; // Número máximo de abejas
float hexRadius = 20; // Radio de los hexágonos

void setup() {
  size(400, 400);
  background(255);
  noStroke();
  bees = new ArrayList<Bee>();
  frameRate(10); // Velocidad de actualización de fotogramas
  drawHoneycomb(width / 2, height / 2, hexRadius, 3);
}

void draw() {
  // Mueve y muestra las abejas
  for (Bee bee : bees) {
    bee.move();
    bee.display();
  }
}

void drawHexagon(float x, float y, float radius) {
  float angle = TWO_PI / 6;
  beginShape();
  for (int i = 0; i < 6; i++) {
    float xVertex = x + cos(angle * i) * radius;
    float yVertex = y + sin(angle * i) * radius;
    vertex(xVertex, yVertex);
  }
  endShape(CLOSE);
}

void drawHoneycomb(float x, float y, float radius, int depth) {
  if (depth > 0) {
    for (int i = 0; i < 6; i++) {
      float xPos = x + cos(PI/6 + TWO_PI/6 * i) * radius;
      float yPos = y + sin(PI/6 + TWO_PI/6 * i) * radius;
      drawHoneycomb(xPos, yPos, radius, depth - 1);
    }
  } else if (bees.size() < maxBees) {
    bees.add(new Bee(x, y, random(-2, 2), random(-2, 2)));
  }
}

class Bee {
  float x, y;
  float speedX, speedY;

  Bee(float startX, float startY, float initialSpeedX, float initialSpeedY) {
    x = startX;
    y = startY;
    speedX = initialSpeedX;
    speedY = initialSpeedY;
  }

  void move() {
    x += speedX;
    y += speedY;

    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }
  }

  void display() {
    fill(35, 16, 150); // Color amarillo para las abejas
    ellipse(x, y, 10, 10);
  }
}
