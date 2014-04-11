/* 
 * Solution for challenge 14 on /r/dailyprogrammer
 * @author Simon Symeonidis
 */

#include <iostream>
#include <vector>
#include <sstream>
#include <algorithm>

using std::cout;
using std::endl;
using std::string;
using std::vector;
using std::stringstream;

int main(int argc, char * argv[]) {
  int blockSize = 0;
  stringstream ss; 
  vector<string*> elements;
  vector<string*>::iterator itPrev;
  vector<string*>::iterator itAfter;

  if (argc < 3) {
    cout << "usage: " << endl;
    cout << "  reverseblock <block-num> <element>+" << endl;
    return -1;
  }

  /* Get the blocksize */
  ss << argv[1];
  ss >> blockSize;

	if (!(blockSize <= argc - 2)) {
    cout << "Error: blocksize must be equal or smaller than the element set"
		     << endl;
		return -1;
	}

  /* ignore bin name and block size */
  for (size_t x = 2; x < argc; ++x) {
    elements.push_back(new string(argv[x]));
  }

  itPrev  = elements.begin(); 

  for (size_t x = 0; x + blockSize < elements.size(); x += blockSize) {
    std::reverse(itPrev, itPrev + blockSize);
		itPrev += blockSize;
	}

  for (size_t x = 0; x < elements.size(); ++x) {
    cout << *elements[x] << " ";
  }
  cout << endl;

  /* clean */
  for (size_t x = 2; x < argc; ++x) {
    delete(elements.back());
    elements.pop_back();
  }

  return 0;
}

