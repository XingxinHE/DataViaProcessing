float lat;
float lon;

PImage mapImg;

float centerLat = 31.2304;
float centerLon = 121.4737;

float zoomLv = 2.5;

int pixW = 1024;
int pixH = 512;

String [] earthquakesData;

float mercX(float lon) {
  lon = radians(lon);
  float a = (256/PI)*pow(2, zoomLv);
  float b = lon+PI;
  return a*b;
}

float mercY(float lat) {
  lat = radians(lat);
  float a = (256 / PI) * pow(2, zoomLv);
  float b = tan(PI / 4 + lat / 2);
  float c = PI - log(b);
  return a * c;
}

void setup() {
  String url ="https://api.mapbox.com/styles/v1/mapbox/dark-v9/static/" +
    centerLon + "," + centerLat + "," + zoomLv + "/" +
    pixW + "x" + pixH +
    "?access_token=pk.eyJ1IjoiY29kaW5ndHJhaW4iLCJhIjoiY2l6MGl4bXhsMDRpNzJxcDh0a2NhNDExbCJ9.awIfnl6ngyHoB3Xztkzarw";
  mapImg = loadImage(url, "jpg");

  earthquakesData = loadStrings("http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv");

  size(pixW, pixH);
  translate(width/2, height/2);
  imageMode(CENTER);
  image(mapImg, 0, 0);

  for (int i = 1; i < earthquakesData.length; i++) {
    String [] data = earthquakesData[i].split(","); //the earthquakes data is csv, using split function
    float lat = float(data[1]);
    float lon = float(data[2]);

    float mag = float(data[4]);
    mag = pow(10, mag);
    mag = sqrt(mag);

    float magmax = sqrt(pow(10, 10));

    float diameter = map(mag, 0, magmax, 0, 1600);
    // var trans = map(mag,0,magmax,0,1000);

    float cx = mercX(centerLon);
    float cy = mercY(centerLat);

    float x = mercX(lon) - cx;
    float y = mercY(lat) - cy;
    if (x < -width / 2) {
      x += width;
    } else if (x > width / 2) {
      x -= width / 2;
    }
    stroke(208, 16, 76, 100);
    fill(208, 16, 76, 100);
    ellipse(x, y, diameter, diameter);
  }
}




