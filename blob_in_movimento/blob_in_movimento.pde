
ArrayList<Blob> blobs = new ArrayList<Blob>();
float t = 0; // Parametro del tempo per l'animazione
String[] colors = {"FCA491", "FBD701", "36A1CB", "F55243", "2C2A2B", "9DC9EC"};

void setup() {
  size(1800, 1200); // Dimensione del canvas
  smooth();
  placeBlobs();
}

void draw() {
  background(255);
  for (Blob b : blobs) {
    b.updatePosition();
    b.display(t);
  }
  t += 0.004;

  // Ogni 120 frame scambia le posizioni di due blob
  if (frameCount % 120 == 0) {
    swapBlobsPositions();
  }
}

void placeBlobs() {
  int attempts = 0;
  float minX = 300; // Distanza dal bordo sinistro per la cornice
  float minY = 300; // Distanza dal bordo superiore per la cornice
  float maxX = width - 300; // Distanza dal bordo destro per la cornice
  float maxY = height - 300; // Distanza dal bordo inferiore per la cornice

  while (blobs.size() < 10 && attempts < 1000) {
    float r = random(100, 300);
    float x = random(minX + r, maxX - r);
    float y = random(minY + r, maxY - r);

    Blob newBlob = new Blob(x, y, r);
    boolean canPlace = true;
    for (Blob b : blobs) {
      float d = dist(x, y, b.x, b.y);
      if (d < r + b.radius) {
        canPlace = false;
        break;
      }
    }
    if (canPlace) {
      blobs.add(newBlob);
    }
    attempts++;
  }
}

void swapBlobsPositions() {
  if (blobs.size() > 1) {
    int indexA = int(random(blobs.size()));
    int indexB = int(random(blobs.size()));
    while (indexA == indexB) {
      indexB = int(random(blobs.size()));
    }

    Blob blobA = blobs.get(indexA);
    Blob blobB = blobs.get(indexB);
    float tempX = blobA.destX;
    float tempY = blobA.destY;
    blobA.destX = blobB.destX;
    blobA.destY = blobB.destY;
    blobB.destX = tempX;
    blobB.destY = tempY;

    blobA.lerpAmt = 0;
    blobB.lerpAmt = 0;
  }
}

class Blob {
  float x, y;
  float destX, destY;
  float radius;
  float noiseFactor;
  float rotation;
  float lerpAmt = 0.0;
    int col; // Proprietà per il colore del blob

  Blob(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.destX = x;
    this.destY = y;
    this.radius = radius;
    this.noiseFactor = random(0.5, 2);
    this.rotation = random(TWO_PI);
    this.col = unhex("FF" + colors[int(random(colors.length))]);  }

  void updatePosition() {
    if (lerpAmt < 1) {
      x = lerp(x, destX, lerpAmt);
      y = lerp(y, destY, lerpAmt);
      lerpAmt += 0.007;
    }
  }

  void display(float t) {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    noStroke();
        fill(col); // Utilizza il colore assegnato per riempire il blob
    drawBlob(0, 0, radius, t, noiseFactor);
    popMatrix();
  }
}

void drawBlob(float x, float y, float radius, float t, float noiseFactor) {
  beginShape();
  for (int i = 0; i < 360; i++) {
    float angle = radians(i);
    float r = radius + noise(cos(angle) * noiseFactor + t, sin(angle) * noiseFactor + t) * 20;
    float px = r * cos(angle);
    float py = r * sin(angle);
    vertex(px, py);
  }
  endShape(CLOSE);
}
