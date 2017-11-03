//Hard-code an array with data
int [] bardata = {12, 5, 14, 74, 20, 36, 54, 87, 14, 52, 65, 14, 3, 22, 52, 10};


void setup() {
  size(800, 400);
}


void draw() {
  background(0);
  fill(255);
  strokeWeight(2);
  stroke(125);

  //Each bar's width
  float barwidth = width/bardata.length;

  //Since the data is just small number, it cant show
  //clearly on the screen, so has to be multiple as long enough
  float barMul = 4;

  for (int i=0; i<bardata.length; i++) {

    //the sketch start from the top of the windows
    //we need to find a way to reverse the bar chart
    //make it looks like start from the bottom
    float barPos = height - bardata[i]*barMul;

    rect(barwidth*i, barPos, barwidth, bardata[i]*barMul);
  }
}
