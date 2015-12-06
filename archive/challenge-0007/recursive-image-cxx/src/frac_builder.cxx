#include "frac_builder.hxx"

FracBuilder::FracBuilder(std::function<double(double)> iFn) :
  m_fn(iFn)
{}

FracBuilder FracBuilder::x(double iX) {
  m_x = iX;
  return *this;
}

FracBuilder FracBuilder::y(double iY) {
  m_y = iY;
  return *this;
}
