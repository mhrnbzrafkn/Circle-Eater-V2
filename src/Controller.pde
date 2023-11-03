GameENV env; //<>//

void setup() {
  size(400, 400);
  env = new GameENV();
}

void draw() {
  background(0);
  
  env.Draw();
}
