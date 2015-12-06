#include <iostream>
#include <complex>

#include "frac_builder.hxx"

using std::cout;
using std::endl;

int main() {
  FracBuilder frac(FracBuilder::default_engine);

  frac.x(1000)
      .y(1000)
      .build()
      .process();

  return 0;
}
