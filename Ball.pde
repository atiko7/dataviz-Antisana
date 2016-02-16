
class Ball {
  String [] colores= {
    "ff065143", 
    "ff2ebe62", 
    "ff00a878", 
    "ff7dc95e", 
    "ffbef2b3",
  };
  color col;
  float yinit;
  float x;
  float y;
  //float s;


  float vel;
  Ball(float x_, float y_) {
    col=color(unhex(colores[int(random(5))]));
    x=x_;
    y=y_;
    vel=2.5;
   

    yinit=0.9*height;
  }
  void dibujar() {
    pushMatrix();
    noStroke();
    translate(x, y);
    scale(s1);
    ellipseMode(CENTER);
    fill(col);
    ellipse(0, 0, s/50, s/50);
    popMatrix();
  }
  void subir() {
    Ani.to(this, vel, "yinit", y);
  }
  void agrandar() {
    s+=0.1;
  }
  void reducir() {
    s-=0.1;
  }
  //  void parar() {
  //    if (yinit<y) {
  //      vel=0;
  //    }
  //  }
}

