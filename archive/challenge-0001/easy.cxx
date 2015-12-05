#include <iostream>
#include <string>
using std::cout;
using std::cin;
using std::endl;
using std::string;

int main() {
  string name;
  string age;
  string redditname;

  cout << "enter name: ";
  std::getline (cin, name);

  cout << "enter age: ";
  std::getline (cin, age);

  cout << "enter reddit name: ";
  std::getline (cin, redditname);

  cout << "your name is " << name
       << " you are " << age
       << " old, and your username is "
       << redditname << endl;

  return 0;
}
