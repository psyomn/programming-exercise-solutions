#pragma once

#include <complex>
#include <vector>
#include <functional>

class FracBuilder {
  public:
    FracBuilder(std::function<double(double)>);
    ~FracBuilder();

    FracBuilder x(double);
    FracBuilder y(double);

    std::vector< std::complex<double> > image();

  private:
    /** What function to apply to the fractal */
    std::function<double(double)> m_fn;
    size_t m_x;
    size_t m_y;
};
