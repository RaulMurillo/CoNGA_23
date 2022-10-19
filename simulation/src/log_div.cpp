#include <universal/number/posit/posit.hpp>
#include "log_div.hpp"

// Namespaces
// using namespace sw::universal;

#define N 8

int main() {
    using Real = sw::universal::posit<N,2>;  

#if 1
	/* Simple test */
    constexpr double pi = 3.14159265358979323846;

    Real a = sqrt(2);
    Real b = -pi;

    std::cout << "A: " << a.get() << std::endl;
    std::cout << "B: " << b.get() << std::endl;
    std::cout << std::endl;
    std::cout << "Result: " << p_div(a, b) << std::endl;
    std::cout << "      : " << p_div(a, b).get() << std::endl;
    std::cout << "PLAD  : " << log_div(a, b) << std::endl;
    std::cout << "      : " << log_div(a, b).get() << std::endl;

    // bitblock<32> ba, bb;

    // ba.load_bits("01000000000000000000000000000000");
    // bb.load_bits("01100001000000000000000000000000");
    // a.setBitblock(ba);
    // b.setBitblock(bb);

    // std::cout << "A: " << a.get() << std::endl;
    // std::cout << "B: " << b.get() << std::endl;
    // std::cout << std::endl;
    // std::cout << "Result: " << p_div(a, b) << std::endl;
    // std::cout << "      : " << p_div(a, b).get() << std::endl;
    // std::cout << "PLAD  : " << log_div(a, b) << std::endl;
    // std::cout << "      : " << log_div(a, b).get() << std::endl;
    
    // ba.load_bits("00100100110011001100110011001100");
    // bb.load_bits("00001110100011110101110000101001");
    // a.setBitblock(ba);
    // b.setBitblock(bb);

    // std::cout << "A: " << a.get() << std::endl;
    // std::cout << "B: " << b.get() << std::endl;
    // std::cout << std::endl;
    // std::cout << "Result: " << p_div(a, b) << std::endl;
    // std::cout << "      : " << p_div(a, b).get() << std::endl;
    // std::cout << "PLAD  : " << log_div(a, b) << std::endl;
    // std::cout << "      : " << log_div(a, b).get() << std::endl;
#else
	/* Exhaustive testbench */
	Real a=0, b=0, exact, approx;
	for (unsigned long long i=0; i < 1ULL<<N; ++i){
		b = 0;
        for (unsigned long long j=0; j < 1ULL<<N; ++j){
			exact = p_div(a, b);
			approx = log_div(a, b);
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
