#include <iostream>
#include <string>
#include <ctime>
#include <cstdlib>
#include <cstdint>
#include <sstream>

using std::endl;
using std::cout;
using std::cin;

class Asker {
  public:
  Asker(std::uint32_t iMax) :
    m_max(iMax),
    m_secret_number(std::rand() % iMax),
    m_tries(0)
  {}

  bool is_num(std::uint32_t num) {
    return num == m_secret_number;
  }

  void interactive() {
    std::string input;
    std::uint32_t num;

    cout << "Guess the number from 0 to " << m_max << endl;
    while (num != m_secret_number) {
      ++m_tries;
      std::getline (cin, input);
      std::istringstream (input) >> num;
      input.clear();
      cout << (num == m_secret_number ? "found it!" : "nopers") << endl;
    }

    cout << "You have found the secret number " << m_secret_number << "!" << endl;
    cout << "It took you " << m_tries << " tries" << endl;
  }

  private:

  std::uint32_t m_secret_number;
  std::uint32_t m_max;
  std::uint32_t m_tries;
};

int main() {
  std::srand(std::time(0));
  Asker a(10);
  a.interactive();
}

