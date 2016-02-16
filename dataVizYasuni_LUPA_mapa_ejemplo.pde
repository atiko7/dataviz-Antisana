PFont font1;
PShape mapa;
PImage flecha;
float s;
  float s1;
  float s11;
import de.looksgood.ani.*;
Ball [] ball;

Lupa lupa;

JSONObject json; // creando mi objeto JSON
color col;
int conteo;
Boolean mouse=false;
float valores;

void setup() {
  background(#1e1e24);
  size(900, 800);
  loadData();
  col=255;
  s=600;
  s1=1;
  mapa= loadShape("mapaEcuador.svg");
  lupa= new Lupa(0.2*width, 0.2*height, 50);
  Ani.init(this);
  font1= loadFont("HelveticaLTStd-BoldCond-48.vlw");
  flecha= loadImage("flecha.png");
}
void draw() {
  background(#1e1e24);
  pushMatrix();
  shapeMode(CENTER);
  translate(0.5*width, 0.5*height);
  //scale(s);
  shape(mapa, 0, 0,s,s);
  noStroke();
  fill(#2ebe62,200);
  ellipseMode(CENTER);
//ellipse(0,0,s/15,s/15);
  popMatrix();
  textFont(font1);
  textAlign(CENTER);
  pushStyle();
  fill(#065143, 150);
  textSize(52);
  text(conteo, 0.75*width, 0.86*height);
  popStyle();
  pushStyle();
  fill(#2ebe62,100);
  textSize(18);
  text("A n i m a l e s", 0.75*width, 0.77*height);
  popStyle();

  for ( int i=0; i<ball.length; i++) {
    ball[i].dibujar();
    if (lupaCerca()&&mouse) {
      conteo= int(random(3000));
      if(i>0){
       conteo+=i; 
      }
    }  
    lupa.dibujar();
  }
  if (lupa.overCircle(lupa.x, lupa.y, lupa.s)) {
    image(flecha, mouseX, mouseY, 30, 30);
  }
}
void loadData() {
  json= loadJSONObject("data.json");// inicializo mi objeto y cargo mi archivo JSON 
  JSONArray ubicaciones= json.getJSONArray("ubicaciones"); // CREO Y COJO mi array "ubicaciones" dentro de mi json
 ball = new Ball[ubicaciones.size()]; // en un array siempre debo decir cuantos elementos va a tener. y va depender del tamano de ubicaciones

  for ( int i=0; i<ubicaciones.size (); i++) { /// CREO un loop para poder coger todos los datos dentro de cada objeto de mi array
    JSONObject objetos= ubicaciones.getJSONObject(i); // coger todos los objetos disponibles dentro de mi array ubicaciones
    //cojo y de los valores que obtengo de elevacion ubicacion
    double lat= objetos.getFloat("verbat_latitud_ubicacion"); // cogo mi flaot "elevacionubicacion" de cada uno de mi objetos
    double lon= objetos.getFloat("verbat_longitud_ubicacion");

    UTMRef conversion = new UTMRef(lat, lon, 'M', 17); // declaro y creo mi variable UTMref de mi libreria para convertir valores de lat y long.
    //CONVERTIR EL VALOR DE LAT Y LON A STRING//
    String conversionlatlng=conversion.toLatLng().toString();  
    //QUITAR CARACTERES FINALES, PRIMERO Y COMA//
    String text1 = conversionlatlng.substring (  1, conversionlatlng.length()-1  ); // (indice primero, indice final) como los extremos.
    float [] valorlatlng= float(split(text1, ","));
    //println(valorlat[0]);// si pongo 0 me da el primer valor antes de la coma, si pongo 1 me da el segundo valor despues de la coma
    float xlat= map(valorlatlng[0], -0.45446828, -0.54077464, 0.4*width, 0.6*width);
    float ylng= map(valorlatlng[1], -78.158066, -78.24428, 0.35*height, 0.5*height);
    println(valorlatlng[0]+","+valorlatlng[1]);
   ball[i]= new Ball(xlat, ylng);
  }
}

void mouseDragged() {

  lupa.drag();

  mouse=true;
//  for (int i=0; i <ball.length; i++) {
//    if (mouseX<pmouseX&& mouseX>lupa.x&&lupa.dragScale(lupa.x,lupa.y,lupa.s)) {
//      if (ball[i].s<10&&ball[i].s1<3) {
//        //ball[i].agrandar();
//        ball[i].s1+=0.1;
//      }
//    }else if (mouseX>pmouseX&& mouseX>lupa.x&&lupa.dragScale(lupa.x,lupa.y,lupa.s)) {
//      if (ball[i].s>5&&ball[i].s1>0.7) { 
//      //ball[i].reducir();
//      ball[i].s1-=0.1;
//      }
//    }
//  }
float map1= map(lupa.s, 25,75,1.5,0.5);
  if (lupa.dragScale(lupa.x,lupa.y,lupa.s)) {
    if (mouseX<pmouseX&& mouseX>lupa.x) {
      if (lupa.s>25 ) {
        lupa.s--;
        s+=5;
       
        s1=map1;
     
      }
    } else if (mouseX>pmouseX&& mouseX>lupa.x) {
      if (lupa.s<75) {
        lupa.s++;
        s-=5;
        
//        s1-=0.1;
    s1=map1;
      }
    }
    if (mouseX<pmouseX && mouseX<lupa.x) {
      if (lupa.s<75 ) {
        lupa.s++;
        s-=5;
       
//        s1-=0.1;
s1=map1;
        }
      
    } else if (mouseX>pmouseX && mouseX<lupa.x) {
      if (lupa.s>25) {
        lupa.s--;
        s+=5;
       
//  s1+=0.1;
  s1=map1;
        
      }
    }
  }
}



void mouseReleased() {
  mouse=false;
}

boolean lupaCerca() {
  for (int i=0; i<ball.length; i++) {
    float distanciaLupaDato= dist(lupa.x, lupa.y, ball[i].x, ball[i].y);
    if (distanciaLupaDato<10) {
      return true;
    }
  }
  return false;
}

void conversionLimitesMapa() {
  float [] limitesMapax= {
    -1.128379, -0.974597, 1.376298, -5.008915
  };
  float [] limitesMapay= {
    -80.902442, -75.211524, -78.793067, -79.015617
  };
  for (int i=0; i<4; i++) {
    //UTMRef limites = new UTMRef(limitesMapax[i], limitesMapay[i], 'M', 17);
    UTMRef limites = new UTMRef(limitesMapax[i], limitesMapay[i], 'M', 17);
    String conversionLimites= limites.toLatLng().toString();
    String texto= conversionLimites.substring(1, conversionLimites.length()-1);
    String [] limitesMapa= (split(texto, ","));
    String valorXsinletra= limitesMapa[0].substring(0, limitesMapa[0].length()-3);
    String valorYsinletra= limitesMapa[1].substring(0, limitesMapa[1].length()-3);
    float mapaX= map(float(valorXsinletra), -2.0620434099453104, -2.0899946539140314, 0, width);
    float mapaY= map(float(valorYsinletra), 8.442246292631185, 8.556684305631663, 0, height);
    //paraquitarlaletra

    //float limitesX=map(limitesMapa[0],
    //println(mapaY);
  }
}

