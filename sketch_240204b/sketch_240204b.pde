class Blob {
  float x, y; // Posizione del centro del blob
  float radius; // Raggio del blob
  float noiseFactor; // Fattore di noise unico per il blob
  float rotation; // Angolo di rotazione unico per il blob

  // Costruttore aggiornato con i nuovi attributi
  Blob(float x, float y, float radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.noiseFactor = random(0.5, 2); // Assegna un fattore di noise casuale
    this.rotation = random(TWO_PI); // Assegna una rotazione casuale
  }
  
  // Metodo per disegnare il blob con noise e rotazione unici
  void display(float t) {
    pushMatrix(); // Salva la configurazione corrente della matrice di trasformazione
    translate(x, y); // Sposta l'origine al centro del blob
    rotate(rotation); // Applica la rotazione
    drawBlob(0, 0, radius, t, noiseFactor); // Disegna il blob con il suo noise e al centro della nuova origine
    popMatrix(); // Ripristina la configurazione precedente della matrice
  }
}


ArrayList<Blob> blobs = new ArrayList<Blob>();
float t = 0; // Parametro del tempo per l'animazione

void setup() {
  size(1800, 1200); // Imposta una dimensione più grande per avere più spazio
  smooth();
  noLoop(); // Disabilita il loop automatico per il primo posizionamento
  placeBlobs();
}

void draw() {
  background(255);
  for (Blob b : blobs) {
    b.display(t);
  }
  t += 0.01;
}

void placeBlobs() {
  int attempts = 0;
  int offset = 200;
  while (blobs.size() < 30 && attempts < 1000) { // Prova a posizionare 10 blob con un massimo di 1000 tentativi
    float r = random(50, offset); // Sceglie un raggio casuale tra 100 e 300
    float x = random(r+offset, width - r-offset);
    float y = random(r+offset, height - r-offset);
    Blob newBlob = new Blob(x, y, r);
    boolean canPlace = true;
    for (Blob b : blobs) {
      float d = dist(x, y, b.x, b.y);
      if (d < r + b.radius) { // Verifica la sovrapposizione
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

void drawBlob(float x, float y, float radius, float t, float noiseFactor) {
  beginShape();
  for (int i = 0; i < 360; i++) {
    float angle = radians(i);
    // Utilizza il fattore di noise specifico del blob nel calcolo
    float r = radius + noise(cos(angle) * noiseFactor + t, sin(angle) * noiseFactor + t) * 20;
    float px = r * cos(angle);
    float py = r * sin(angle);
    vertex(px, py);
  }
  endShape(CLOSE);
}
