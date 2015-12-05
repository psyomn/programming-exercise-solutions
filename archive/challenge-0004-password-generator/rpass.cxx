#include <iostream>
#include <vector>
#include <cstdint>
#include <cstdlib>
#include <sstream>
#include <ctime>

using std::cout;
using std::endl;
using std::vector;

vector<std::uint8_t> generate(size_t, size_t);
void print_vector(std::vector<std::uint8_t>&);

int main(int argc, char * argv[]) {

  if (argc < 3) {
    cout << "Usage: " << endl;
    cout << "  " << argv[0] << " <number> <number> " << endl;
    return -1;
  }
  std::srand(std::time(0));

  std::uint32_t x;
  std::uint32_t y;

  std::istringstream (argv[1]) >> x;
  std::istringstream (argv[2]) >> y;

  vector<std::uint8_t> password = generate(x, y);
  print_vector(password);

  return 0;
}

void print_vector(std::vector<std::uint8_t>& vv) {
  for (auto& c : vv) {
    cout << c;
  }
}

vector<std::uint8_t> generate(size_t x, size_t y) {
  std::vector<uint8_t> v;

  if (x < 0 || y < 0) {
    return v;
  }

  for (int i = 0; i < y; ++i) {
    for (int j = 0; j < x; ++j) {
      uint8_t c = std::rand();
      while (!(c >= 32 && c <= 126)) {
        c = std::rand();
      }
      v.push_back(c);
    }
    v.push_back(0xA);
  }

  return v;
}

