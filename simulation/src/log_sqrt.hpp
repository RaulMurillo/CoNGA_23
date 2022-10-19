#ifndef LOG_SQRT_HPP
#define LOG_SQRT_HPP

#include <universal/number/posit/posit.hpp>

namespace sw { namespace universal {

// Exact operation -- just for comparison 
template<typename Real>
Real p_sqrt(const Real& a) {
    return sqrt(a);  // replace this with your kernel computation
}

// https://stackoverflow.com/questions/43120045/how-does-this-float-square-root-approximation-work
float f_sqrt(float f)
{
    const int result = 0x1fbb4000 + (*(int*)&f >> 1);
    return *(float*)&result;   
}

template <typename Posit>
Posit log_sqrt(const Posit& lhs) {
    Posit log_sqrt;
    constexpr size_t fbits = Posit::fbits;

	internal::value<fbits> a;
	internal::value<fbits + 1> result;
	
	lhs.normalize(a);
	
	// Special cases
	if (a.isinf() || a.isneg()) {
		log_sqrt.setnar();
		return log_sqrt;
	}
	if (a.iszero()) {
		log_sqrt.setzero();
		return log_sqrt;
	}


	// TODO!!
	bool new_sign = a.sign();
	int new_scale = a.scale() >> 1;

	internal::bitblock<fbits> f = a.fraction();
	internal::bitblock<fbits + 1> result_fraction;
	for (int i = 0; i<fbits; i++) result_fraction[i] = f[i];
	result_fraction.set(fbits, a.scale()%2);

	// std::cout << "\nOld Scale: " << a.scale() << std::endl;
	// std::cout << "New Scale: " << new_scale << std::endl;
	// std::cout << "Fraction: " << f << std::endl;
	// std::cout << "New Fraction: " << result_fraction << std::endl;

	result.set(new_sign, new_scale, result_fraction, false, false, false);

	convert(result, log_sqrt);
	/////////
	return log_sqrt;
	/////////

	// internal::bitblock<fbits> r1 = a.fraction();
	// internal::bitblock<fbits> r2 = b.fraction();
	// internal::bitblock<fbits + 1> result_fraction;
	// subtract_unsigned(r1, r2, result_fraction);
	
	// if (result_fraction.test(fbits)) {  // Carry from the fraction
	// 	new_scale -= 1;
	// }
	// result_fraction <<= static_cast<size_t>(1);    // shift extra addition bit out
	// result.set(new_sign, new_scale, result_fraction, false, false, false);
	
	// convert(result, log_sqrt);	
	// return log_sqrt;
}

}} // namespace sw::universal

#endif