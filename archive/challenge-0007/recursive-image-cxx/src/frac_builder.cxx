#include "frac_builder.hxx"

using namespace std::literals;

FracBuilder::FracBuilder(std::function<double(double)> iFn) :
  m_fn(iFn),
  m_data(std::vector<std::complex<double> >()),
  m_x(0),
  m_y(0),
  m_value(0.0)
{}

FracBuilder FracBuilder::x(double iX) {
  m_x = iX;
  return *this;
}

FracBuilder FracBuilder::y(double iY) {
  m_y = iY;
  return *this;
}

FracBuilder FracBuilder::value(double iValue) {
  m_value = iValue;
  return *this;
}

double FracBuilder::default_engine(std::complex<double> value) {
  return 0.0;
}

FracBuilder FracBuilder::build() {
  std::complex<double> dflt = 0. + 0i;

  m_data.clear();

  for (size_t i = 0; i < m_x; ++i)
    for (size_t j = 0; j < m_y; ++j)
      m_data.push_back(std::complex<double>(dflt));

  return *this;
}

FracBuilder FracBuilder::process() {
  return *this;
}
