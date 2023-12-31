public class Agent {
  private float x = 0; // Player X
  private float y = 0; // Player Y
  private int size = 20;
  private int score = 0;
  private float speed = 5; // Adjust the speed for smoother movement
  //private float x_speed = 0; // Player's horizontal speed
  //private float y_speed = 0; // Player's vertical speed
  private float distance = 0;
  private float previous_distance = 0;
  
  private int[] nnlayers;
  private NeuralNetwork nn;
  private float learningRate;
  
  private int trainNumbers = 0;
  
  public Agent() {
    this.x = width / 2;
    this.y = height / 2;
    
    nnlayers = new int[] { 4, 5, 8, 5, 4 };
    learningRate = 0.1;
    nn = new NeuralNetwork(nnlayers, Activation.sigmoid);
  }
  
  public void Respown() {
    this.x = width / 2;
    this.y = height / 2;
  }
  
  public void Draw() {
    x = constrain(x, size / 2, width - size / 2);
    y = constrain(y, size / 2, height - size / 2);
    
    fill(0, 0, 255);
    ellipse(this.x, this.y, this.size, this.size);
  }
  
  public void Action(float foodX, float foodY) {
    //Calculate Distance Befor Action
    previous_distance = CalculateDistanceToFood(foodX, foodY);
    
    double[] inputs = new double[] { this.x / width, this.y / height, foodX / width, foodY / height };
    double[] predicted_output = nn.feedForward(inputs);
    //println(predicted_output[0]+ " - " + predicted_output[1]+ " - " + predicted_output[2]+ " - " + predicted_output[3]);
    
    // Move to right and left
    if (predicted_output[0] > predicted_output[1]) {
      StepRight(this.speed);
    } else if (predicted_output[0] < predicted_output[1]) {
      StepLeft(this.speed);
    }
    
    // Move to up and down
    if (predicted_output[2] > predicted_output[3]) {
      StepUp(this.speed);
    } else if (predicted_output[2] < predicted_output[3]) {
      StepDown(this.speed);
    }
    
    //Calculate Distance After Action
    distance = CalculateDistanceToFood(foodX, foodY);
    
    if (distance >= previous_distance) {
      println("Train Step: " + trainNumbers++);
      
      double[] target_output = new double[] { 0.0, 0.0, 0.0, 0.0 };
      
      if (this.x > foodX) {
        target_output[0] = 0;
        target_output[1] = 1;
      } else if (x < foodX) {
        target_output[0] = 1;
        target_output[1] = 0;
      }
      
      if (y > foodY) {
        target_output[2] = 1;
        target_output[3] = 0;
      } else if (y < foodY) {
        target_output[2] = 0;
        target_output[3] = 1;
      }
      
      nn.backpropagate(inputs, target_output, learningRate);
    }
  }
  
  public float CalculateDistanceToFood(float foodX, float foodY) {
    float distance = dist(this.x, this.y, foodX, foodY);
    
    return distance;
  }
  
  public boolean CheckCollision(float foodX, float foodY, int foodSize) {
    float distance = CalculateDistanceToFood(foodX, foodY);
    if (distance < size / 2 + foodSize / 2) {
      return true;
    } else {
      return false;
    }
  }
  
  public void StepLeft(double s) {
    this.x -= s;
  }
  
  public void StepRight(double s) {
    this.x += s;
  }
  
  public void StepUp(double s) {
    this.y -= s;
  }
  
  public void StepDown(double s) {
    this.y += s;
  }
  
  //End Of Agent Class
}
