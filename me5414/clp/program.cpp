
#include "ClpSimplex.hpp"

int main(int argc, const char *argv[])
{
  std::string mps_file = "../data/s250r10.mps";

  ClpSimplex  model;
  int status;
  // Keep names
  if (argc < 2) {
      status = model.readMps(mps_file.c_str(), true);
  } else {
      status = model.readMps(argv[1], true);
  }
  if (status)
      exit(10);

  int numberColumns = model.numberColumns();
  int numberRows = model.numberRows();

  if (numberColumns > 80 || numberRows > 80) {
      printf("model too large\n");
      exit(11);
  }
  printf("This prints x wherever a non-zero element exists in the matrix.\n\n\n");

  char x[81];

  int iRow;
  // get row copy
  CoinPackedMatrix rowCopy = *model.matrix();
  rowCopy.reverseOrdering();
  const int * column = rowCopy.getIndices();
  const int * rowLength = rowCopy.getVectorLengths();
  const CoinBigIndex * rowStart = rowCopy.getVectorStarts();

  x[numberColumns] = '\0';
  for (iRow = 0; iRow < numberRows; iRow++) {
      memset(x, ' ', numberColumns);
      for (CoinBigIndex k = rowStart[iRow]; k < rowStart[iRow] + rowLength[iRow]; k++) {
            int iColumn = column[k];
            x[iColumn] = 'x';
      }
      printf("%s\n", x);
  }
  printf("\n\n");
  return 0;
}
