#include <universal/number/posit/posit.hpp>
#include "log_sqrt.hpp"

// Namespaces
// using namespace sw::universal;

#define N 16

int main() {
    using Real = sw::universal::posit<N,2>;  

#if 0
	/* Simple test */
    constexpr double pi = 3.14159265358979323846;

    Real a = 0.46875;
    Real b = -pi;

    std::cout << "A: " << a.get() << std::endl;
    // std::cout << "B: " << b.get() << std::endl;
    std::cout << std::endl;
    std::cout << "Result: " << p_sqrt(a) << std::endl;
    std::cout << "      : " << p_sqrt(a).get() << std::endl;
    std::cout << "PLAD  : " << log_sqrt(a) << std::endl;
    std::cout << "      : " << log_sqrt(a).get() << std::endl;

    // bitblock<32> ba, bb;

    // ba.load_bits("01000000000000000000000000000000");
    // bb.load_bits("01100001000000000000000000000000");
    // a.setBitblock(ba);
    // b.setBitblock(bb);

    // std::cout << "A: " << a.get() << std::endl;
    // std::cout << "B: " << b.get() << std::endl;
    // std::cout << std::endl;
    // std::cout << "Result: " << p_sqrt(a, b) << std::endl;
    // std::cout << "      : " << p_sqrt(a, b).get() << std::endl;
    // std::cout << "PLAD  : " << log_sqrt(a, b) << std::endl;
    // std::cout << "      : " << log_sqrt(a, b).get() << std::endl;
    
    // ba.load_bits("00100100110011001100110011001100");
    // bb.load_bits("00001110100011110101110000101001");
    // a.setBitblock(ba);
    // b.setBitblock(bb);

    // std::cout << "A: " << a.get() << std::endl;
    // std::cout << "B: " << b.get() << std::endl;
    // std::cout << std::endl;
    // std::cout << "Result: " << p_sqrt(a, b) << std::endl;
    // std::cout << "      : " << p_sqrt(a, b).get() << std::endl;
    // std::cout << "PLAD  : " << log_sqrt(a, b) << std::endl;
    // std::cout << "      : " << log_sqrt(a, b).get() << std::endl;
#else
	/* Exhaustive testbench */
    // Real max=0.0;
	Real a=0, exact, approx;
	for (unsigned long long i=0; i < 1ULL<<N; ++i){
        exact = p_sqrt(a);
        approx = log_sqrt(a);
        // if (exact != approx) 
        // {
        //     max = max >= abs((exact - approx)/exact) ? max: abs((exact - approx)/exact);
        //     std::cout << abs((exact - approx)/exact) << std::endl;
        // 	// std::cout << a.get() << " " << exact.get() << " " << approx.get() << std::endl;
        // }
        std::cout << a.get() << " " << approx.get() << std::endl;
		a++;
	}
    // std::cout << "\n*****\n" << max << "\n";
#endif

    return 0;
}
