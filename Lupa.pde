class Lupa{
  float x;
  float y;
  float s;
  color col;
  Lupa(float x_,float y_,float s_){
   x=x_;
  y=y_;
 s=s_; 
 col=255;
  }
  void dibujar(){
    noFill();
    stroke(255,10);
    strokeWeight(5);
    ellipseMode(CENTER);
   ellipse(x,y,s,s);   
  }
  void drag(){
    float distanciaMouse= dist(mouseX,mouseY,x,y);
    if(distanciaMouse<10){
   x=mouseX;
  y=mouseY; 
    } 
  }
boolean dragScale(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter && sqrt(sq(disX) + sq(disY)) > diameter/5) {
    return true;
  } else {
    return false;
  }
}
  
  boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/1.7 && sqrt(sq(disX) + sq(disY)) > diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
}
