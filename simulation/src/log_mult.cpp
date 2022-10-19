#include <universal/number/posit/posit.hpp>
#include "log_mult.hpp"

// Namespaces
// using namespace sw::universal;

#define N 8

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
#else
	/* Exhaustive testbench */
	Real a=0, b=0, exact, approx;
	for (unsigned long long i=0; i < 1ULL<<N; ++i){
		b = 0;
		for (unsigned long long j=0; j < 1ULL<<N; ++j){
			exact = p_mult(a, b);
			approx = log_mult(a, b);
			// if (exact != approx)
			// 	std::cout << a.get() << " " << b.get() << " " << exact.get() << " " << approx.get() << std::endl;
			std::cout << a.get() << " " << b.get() << " " << approx.get() << std::endl;
			b++;
		}
		a++;
	}
#endif

    return 0;
}
