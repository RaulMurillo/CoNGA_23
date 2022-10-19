#ifndef LOG_DIV_HPP
#define LOG_DIV_HPP

#include <universal/number/posit/posit.hpp>

namespace sw { namespace universal {

// Exact operation -- just for comparison 
template<typename Real>
Real p_div(const Real& a, const Real& b) {
    return a / b;  // replace this with your kernel computation
}

template <typename Posit>
Posit log_div(const Posit& lhs, const Posit& rhs) {
    Posit log_div;
    constexpr size_t fbits = Posit::fbits;

	internal::value<fbits> a, b;
	internal::value<fbits + 1> result;
	
	lhs.normalize(a);
	rhs.normalize(b);
	
	if (a.isinf() || b.isinf() || b.iszero()) {
		log_div.setnar();
		return log_div;
	}
	if (a.iszero()) {
		log_div.setzero();
		return log_div;
	}

	bool new_sign = a.sign() ^ b.sign();
	int new_scale = a.scale() - b.scale();

	internal::bitblock<fbits> r1 = a.fraction();
	internal::bitblock<fbits> r2 = b.fraction();
	internal::bitblock<fbits + 1> result_fraction;
	subtract_unsigned(r1, r2, result_fraction);
	std::cout << "New Fraction: " << result_fraction << std::endl;

	
	if (result_fraction.test(fbits)) {  // Carry from the fraction
		new_scale -= 1;
	}
	result_fraction <<= static_cast<size_t>(1);    // shift extra addition bit out
	std::cout << "New Fraction: " << result_fraction << std::endl;

	result.set(new_sign, new_scale, result_fraction, false, false, false);
	
	convert(result, log_div);	
	return log_div;
}

}} // namespace sw::universal

#endif