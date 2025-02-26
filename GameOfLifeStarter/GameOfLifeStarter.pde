import java.util.Random; //<>//
final int SPACING = 20; // each cell's width/height //<>//
final float DENSITY = 0.1; // how likely each cell is to be alive at the start
int rows;
int columns;
int[][] grid; // the 2D array to hold 0's and 1's
boolean isPaused = false;

void setup() {
  background(0);
  fullScreen();
  //size(800, 600); // adjust accordingly, make sure it's a multiple of SPACING
  noStroke(); // don't draw the edges of each cell
  frameRate(2); // controls speed of regeneration
  grid = new int[height / SPACING + 2][width / SPACING + 2];
  // populate initial grid
  // your code here
  rows = height / SPACING;
  columns = width / SPACING;
  for (int row = 1; row <= rows; row++) {
    for (int column = 1; column <= columns ; column++) {
      int randomNum = new Random().nextInt(int(1 / DENSITY));
      if (randomNum == 0) {
        grid[row][column] = 1;
      }
    }
  }
}

void draw() {
  showGrid();
  if (!isPaused) {
    grid = calcNextGrid();
  }
}

void keyPressed() {
  if (key == ' ') {
    isPaused = !isPaused;
  } 
}


void mousePressed() {
  int row = mouseY / SPACING + 1;
  int column = mouseX / SPACING + 1;
  if (grid[row][column] == 0) {
    grid[row][column] = 1;
  } else {
    grid[row][column] = 0;
  }
  showGrid();
}

int[][] calcNextGrid() {
  int[][] newGrid = new int[rows+2][columns+2];
  for (int row = 1; row <= rows; row++) {
    for (int column = 1; column <= columns; column++) {
      if (countNeighbors(row, column) == 3 || (grid[row][column] != 0 && countNeighbors(row, column) == 2)) {
        newGrid[row][column] = grid[row][column] + 1;
      } 
    }
  }
  // your code here

  return newGrid;
}

int countNeighbors(int y, int x) {
  int count = 0;
  if (grid[y-1][x] != 0) {
    count++;
  }
  if (grid[y+1][x] != 0) {
    count++;
  }
  if (grid[y][x+1] != 0) {
    count++;
  }
  if (grid[y][x-1] != 0) {
    count++;
  }
  if (grid[y-1][x-1] != 0) {
    count++;
  }
  if (grid[y-1][x+1] != 0) {
    count++;
  }
  if (grid[y+1][x-1] != 0) {
    count++;
  }
  if (grid[y+1][x+1] != 0) {
    count++;
  }
  return count;
}

void showGrid() {
  for (int row = 1; row <= rows; row++) {
    for (int column = 1; column <= columns; column++) {
      int posX = (column - 1) * SPACING;
      int posY = (row - 1) * SPACING;
      stroke(0);
      if (grid[row][column] == 0) {
        fill(0);
      } else {
        fill(min(grid[row][column] * 10, 255), 255, 0);
        //print(grid[row][column]); 
      }
      square(posX,posY,SPACING);
    }
  }
  // your code here
  // use square() to represent each cell
  // use fill(r, g, b) to control color: black for empty, red for filled (or alive)
}
