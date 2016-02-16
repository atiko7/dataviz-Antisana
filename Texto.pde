class Texto {
  float x;
  float y;
  float dato;
  Texto() {
    x= 0.5*width;
    y=0.5*height;
    dato=0;
  } 
  Texto(float x_, float y_, float dato_) {
    x= x_;
    y=y_;
    dato=dato_;
  } 

  void dibujar() {
    textFont(font1);
    fill(#065143);
    textSize(32);
    strokeWeight(0.2);
    textAlign(CENTER);
    text(dato, x, y);
  }
}

