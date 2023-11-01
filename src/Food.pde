public class Food {
  private float x = 0; // Food X
  private float y = 0; // Food Y
  private int size = 30;
  
  public Food() {
    this.x = random(size / 2, width - size / 2);
    this.y = random(size / 2, height - size / 2);
  }
  
  public void Draw() {
    fill(0, 255, 0);
    ellipse(this.x, this.y, this.size, this.size);
  }
  
  public void Respown() {
    this.x = random(size / 2, width - size / 2);
    this.y = random(size / 2, height - size / 2);
  }
}
