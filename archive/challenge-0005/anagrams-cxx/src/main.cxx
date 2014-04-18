#include <map>
#include <sstream>
#include <fstream>
#include <iostream>
#include <vector>

using std::cout;   using std::string;
using std::cerr;   using std::endl;
using std::map;    using std::ifstream;
using std::vector; using std::stringstream;

string printMap(map<char,int>& _m) {
  string message;
  stringstream ss;
  map<char,int>::iterator it = _m.begin();

  while (it != _m.end()) {
    ss << it->first << ":" << it->second << " ";
    ++it;
  }
  return ss.str();
}

bool sameMapContents(map<char,int>& _m1, map<char,int>& _m2) {
  map<char,int>::iterator it = _m1.begin();

  /* Check actual contents */
  while(it != _m1.end()) {
    if (_m2[it->first] != it->second) return false;
    ++it;
  }

  return true;
}

int main(int argc, char * argv[]) {
  map<char,int> current;
  map<char,int> checking;
  vector<string> words;
  ifstream ifs; 
  string word;

  if (argc != 2) {
    cerr << "Usage : " << endl;
    cerr << "  anagramcxx <filename>" << endl;
    return -1;
  }

  ifs.open(argv[1]); 

  if (!ifs) {
    cerr << "problem opening file" << endl;
    return -1;
  }

  while (ifs >> word)
    words.push_back(word);

  cout << "Loaded " << words.size() << " word(s)..." << endl;

  for (string& crw : words) {
    
    current.clear();
    for (size_t x = 0; x < crw.length(); ++x) {
      current[crw[x]] += 1;
    }

    cout << crw << ": " << printMap(current) << endl;

    for (string& s : words) {
			if (s.size() != crw.size()) continue;

      checking.clear(); 
      
      for (size_t x = 0; x < crw.length(); ++x) {
        checking[s[x]] += 1;
      }

      if (sameMapContents(checking, current)) {
        cout << "  " << s << endl;
      }
    }
  }
  
  return 0;
}


