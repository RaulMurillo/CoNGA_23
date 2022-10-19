#ifndef LOG_MULT_HPP
#define LOG_MULT_HPP

#include <universal/number/posit/posit.hpp>

namespace sw { namespace universal {

// Exact operation -- just for comparison 
template<typename Real>
Real p_mult(const Real& a, const Real& b) {
    return a * b;  // replace this with your kernel computation
}

template <typename Posit>
Posit log_mult(const Posit& lhs, const Posit& rhs) {
    Posit log_mult;
    constexpr size_t fbits = Posit::fbits;

	internal::value<fbits> a, b;
	internal::value<fbits + 1> result;
	
	lhs.normalize(a);
	rhs.normalize(b);
	
	if (a.isinf() || b.isinf()) {
		log_mult.setnar();
		return log_mult;
	}
	if (a.iszero() || b.iszero()) {
		log_mult.setzero();
		return log_mult;
	}

	bool new_sign = a.sign() ^ b.sign();
	int new_scale = a.scale() + b.scale();

	internal::bitblock<fbits> r1 = a.fraction();
	internal::bitblock<fbits> r2 = b.fraction();
	internal::bitblock<fbits + 1> result_fraction;
	add_unsigned(r1, r2, result_fraction);
	
	if (result_fraction.test(fbits)) {  // Carry from the fraction
		new_scale += 1;
	}
	result_fraction <<= static_cast<size_t>(1);    // shift extra addition bit out
	result.set(new_sign, new_scale, result_fraction, false, false, false);
	
	convert(result, log_mult);	
	return log_mult;
}

}} // namespace sw::universal

#endif