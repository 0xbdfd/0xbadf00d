// game_of_life.pde
// by 0xbadf00d

int cols = 108;
int rows = 96;
int cWidth, cHeight;
boolean[][] grid = new boolean[cols][rows];

void setup() {
   size(1080, 960);
   background(0);
   noStroke();
   smooth(2);
   colorMode(HSB, cols);
   frameRate(15);
   cWidth = width / cols;
   cHeight = height / rows;
   createGeneration(2000);
}

void draw() {
   boolean[][] buffer = new boolean[cols][rows];
   for (int row = 0; row < rows; row++) 
      for (int col = 0; col < cols; col++) {
         drawCell(col, row);
         updateCell(col, row, buffer);
      }
   grid = buffer;
}

void createGeneration(int population) {
   for (int i = 0; i < population; i++)
      grid[int(random(cols))][int(random(rows))] = true;
}

void drawCell(int col, int row) {
   if (grid[col][row]) fill(col, 255, 255);
   else fill(0);
   float x = col * cWidth + cWidth / 2.0;
   float y = row * cHeight + cHeight / 2.0;
   ellipse(x, y, cWidth / 2.0, cHeight / 2.0);
}

void updateCell(int col, int row, boolean[][] buffer) {
   if (grid[col][row]) // alive
      buffer[col][row] = aliveNeighbours(col, row) > 1 &&
         aliveNeighbours(col, row) < 4;
   else // dead
      buffer[col][row] = aliveNeighbours(col, row) == 3;
}

int aliveNeighbours(int col, int row) {
   return isAlive(col-1, row-1) + isAlive(col, row-1) + isAlive(col+1, row-1) +
      isAlive(col-1, row) + isAlive(col+1, row) +
      isAlive(col-1, row+1) + isAlive(col, row+1) + isAlive(col+1, row+1);
}

int isAlive(int col, int row) {
   return grid[(col + cols) % cols][(row + rows) % rows]? 1: 0;
}