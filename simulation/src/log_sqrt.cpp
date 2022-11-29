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
	Real a=0.0, exact, approx;
    long double r_err;
    long double max_e=0.0;
	for (unsigned long long i=0; i < 1ULL<<(N-1); ++i){
	// for (unsigned long long i=0; i < 100000; ++i){
    // while (a <= 4){
        exact = p_sqrt(a);
        approx = log_sqrt(a);
        r_err = ((long double)(exact) - (long double)(approx))/((long double)(exact));
        max_e = max_e < r_err ? max_e : r_err;
        // if (exact != approx) 
        // {
        //     max = (max >= abs((exact - approx)/exact)) ? max: abs((exact - approx)/exact);
        //     // std::cout << abs((exact - approx)/exact) << std::endl;
        // 	// std::cout << a.get() << " " << exact.get() << " " << approx.get() << std::endl;
        // }
        // std::cout << a.get() << " " << exact.get() <<  " " << approx.get() << std::endl;
        // std::cout << std::setprecision(20) << a << " " << exact <<  " " << approx << std::endl;
        std::cout << std::setprecision(20) << r_err << std::endl;
		a++;
        // a += 2*1e-5;
	}
    std::cout << "\n*****\n" << max_e << "\n";
#endif

    return 0;
}
