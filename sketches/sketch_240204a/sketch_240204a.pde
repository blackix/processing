float t = 0;
void setup() {
  size(600, 400); // Imposta le dimensioni del canvas
  smooth(); // Per una migliore qualità del rendering
}

void draw() {
  background(255); // Imposta il colore di sfondo a bianco
  drawBlob(width / 2, height / 2, 150, t);
    t += 0.01; // Aggiorna il parametro del tempo per l'animazione

}

void drawBlob(float x, float y, float radius, float t) {
  beginShape();
    float noiseMax = 1; // Aumenta questo valore per un'animazione più dinamica
  for (int i = 0; i < 360; i++) {
    float angle = radians(i);
    // Calcola il raggio variabile usando il noise Perlin
    float r = radius + noise(cos(angle) * noiseMax + t, sin(angle) * noiseMax + t) * 50;    // Converti le coordinate polari in coordinate cartesiane
    float px = x + r * cos(angle);
    float py = y + r * sin(angle);
    vertex(px, py);
  }
  endShape(CLOSE);
}
