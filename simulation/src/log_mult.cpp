#include <universal/number/posit/posit.hpp>
#include "log_mult.hpp"
#include <random>   // for random_device, uniform_X_distribution

// Namespaces
// using namespace sw::universal;

#define N 32
#define RANDOM 1000

template<typename Real>
inline double rel_error(Real exact, Real approx){
	return std::abs(((double)(exact) - (double)(approx))/((double)(exact)));
}

int main() {
    using Real = sw::universal::posit<N,2>;  

#if 0
	/* Simple test */
	constexpr double pi = 3.14159265358979323846;

    Real a = sqrt(2);
    Real b = -pi;

    std::cout << "A: " << a.get() << std::endl;
    std::cout << "B: " << b.get() << std::endl;
    std::cout << std::endl;
    std::cout << "Result: " << p_mult(a, b) << std::endl;
    std::cout << "      : " << p_mult(a, b).get() << std::endl;
    std::cout << "PLAM  : " << log_mult(a, b) << std::endl;
    std::cout << "      : " << log_mult(a, b).get() << std::endl;
#endif
#ifndef RANDOM
	/* Exhaustive testbench */
	Real a=0, b=0, exact, approx;
	double rerr, maxerr = 0;
	for (unsigned long long i=0; i < 1ULL<<N; ++i){
		b = 0;
		for (unsigned long long j=0; j < 1ULL<<N; ++j){
			exact = p_mult(a, b);
			approx = log_mult(a, b);
			rerr = rel_error(exact, approx);
				std::cout << a.get() << " " << b.get() << " " << exact.get() << " " << approx.get() << std::endl;
			if (exact != approx){
			std::cout << rerr << std::endl;
				return 1;
			}
			// std::cout << a.get() << " " << b.get() << " " << approx.get() << std::endl;
			maxerr = maxerr > rerr ? maxerr : rerr;
			b++;
		}
		a++;
	}
	std::cout << maxerr << std::endl;
#else
	/* Random testbench */

	// random numbers logic
    std::random_device rd; // obtain a random number from hardware
    std::mt19937 gen(rd()); // seed the generator
	const uint64_t max_k = (1ULL<<(N))-1ULL;    // N-bit posits
    std::uniform_int_distribution<uint64_t> distr(0, max_k); // define the range, in EXTRA-bit format
	uint64_t p_rnd;

	Real a=0, b=0, exact, approx;
	double rerr, maxerr = 0;
	for (unsigned long long i=0; i < RANDOM; ++i){
		p_rnd = distr(gen);
		a.setbits(p_rnd);
		p_rnd = distr(gen);
		b.setbits(p_rnd);

		exact = p_mult(a, b);
		approx = log_mult(a, b);
		rerr = rel_error(exact, approx);
		std::cout << a.get() << " " << b.get() << " " << exact.get() << " " << approx.get() << " " << rerr << std::endl;
		// if (exact != approx){
		// std::cout << rerr << std::endl;
		// 	return 1;
		// }
		// std::cout << a.get() << " " << b.get() << " " << approx.get() << std::endl;
		maxerr = maxerr > rerr ? maxerr : rerr;
	}
	std::cout << maxerr << std::endl;
#endif

    return 0;
}
