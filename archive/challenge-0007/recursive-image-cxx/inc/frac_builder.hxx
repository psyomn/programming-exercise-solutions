#pragma once

#include <complex>
#include <vector>
#include <functional>
#include <cmath>
#include <iomanip>

class FracBuilder {
  public:
    FracBuilder(std::function<double(double)>);
    ~FracBuilder() {};

    FracBuilder x(double);
    FracBuilder y(double);
    FracBuilder value(double);

    std::vector< std::complex<double> > image();

    static double default_engine(std::complex<double>);

    FracBuilder build();

    FracBuilder process();

  private:
    /** What function to apply to the fractal */
    std::function<double(double)> m_fn;
    std::vector< std::complex<double> > m_data;
    size_t m_x;
    size_t m_y;
    double m_value;
};
