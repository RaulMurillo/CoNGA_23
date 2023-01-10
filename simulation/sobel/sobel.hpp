/* https://github.com/vaxevane/Sobel-Edge-Detection-cpp */
#include <iostream>
#include <cmath>
#include <omp.h>
#include <universal/number/posit/posit.hpp>

// Namespaces
// using namespace std;
using namespace sw::universal;

#ifndef USE_Posit
#define TXT_FMT "Float"
#define TXT_EXACT "exact"
#define Real_t float
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
#define SQRT(x) (std::sqrt(x))
#else
#define TXT_FMT "Posit"
#define Real_t posit<32, 2>

#ifndef LOG_APPROX
#define TXT_EXACT "exact"
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
#define SQRT(x) (sqrt(x))
#else
#define TXT_EXACT "approx"
#include "../src/log_mult.hpp"
#define MULT(a, b) log_mult((Real_t)(a), (Real_t)(b))
// #define MULT(a, b) ((a) * (b))
#include "../src/log_div.hpp"
#define DIV(a, b) log_div((Real_t)(a), (Real_t)(b))
// #define DIV(a, b) ((a) / (b))
#include "../src/log_sqrt.hpp"
#define SQRT(x) log_sqrt(x)
#endif // LOG_APPROX

#endif // USE_Posit

// const int N = 288;
// const int M = 352;

void padding(Real_t *image, const int width, const int height){
	
	//Preprocessing: making the bounds zero
#pragma omp parallel for num_threads(8)
	for (int i = 0; i < width; i++){
		image[i*height+0] = 0;
		image[i*height+(height-1)] = 0;
	}

#pragma omp parallel for num_threads(8)
	for (int j = 0; j < height; j++){
		image[0*height+j] = 0;
		image[(width-1)*height+j] = 0;		
	}
}

//float convolution(float window[N][M],float kernel[W][W]){
Real_t convolution(Real_t *window, Real_t *kernel, const int width, const int height){
	
	Real_t sum = 0;
	for (int i = 0; i < width; i++){
		for(int j = 0; j < height; j++){
		//	sum += window[i+row-1][j+col-1]*kernel[i*height+j]; //without sliding buff
			sum += MULT(window[i*height+j], kernel[i*height+j]);
		}
	}
	return sum;
}

void Sobel_algorithm(Real_t *image, Real_t *Gx, Real_t *Gy, Real_t *edges,Real_t *angle, const int width, const int height){

	const int W = 3;
	Real_t kx[W][W] = {{0, 0, 0},{-2, 0, 2},{-1, 0, 1}};
	Real_t ky[W][W] = {{-1, -2, -1},{0, 0, 0},{1, 2, 1}};
	
	Real_t window[W][W]; 
	typedef Real_t linebuffer[height];
	linebuffer lb[2];
	
	Real_t tempx,tempy,sq_sum;
	for (int i = 0; i < width; i++) {
		for (int j = 0; j < height; j++) {
			
			//Sliding window
			for (int l=0; l < W; l++) {
				window[0][l] = (l==W-1) ? lb[0][j] : window[0][l+1];
				window[1][l] = (l==W-1) ? lb[1][j] : window[1][l+1];
				window[2][l] = (l==W-1) ? image[i*height+j]: window[2][l+1];
			}
			lb[0][j]=lb[1][j];
			lb[1][j]=image[i*height+j];	

			if(i > 1 && j > 1){
				tempx = (Gx[(i-1)*height+(j-1)] = convolution((Real_t *)window, (Real_t *)kx, W, W));
			    tempy =	(Gy[(i-1)*height+(j-1)] = convolution((Real_t *)window, (Real_t *)ky, W, W));
				sq_sum = MULT(tempx, tempx) + MULT(tempy, tempy);
				edges[(i-1)*height+(j-1)] = SQRT(sq_sum);
				angle[(i-1)*height+(j-1)] = atan2(tempy,tempx);	
			}			
		}
	}
	
/*	for(int i = 1; i < width-1; i++){
		for(int j = 1; j< height-1; j++){
			tempx = (Gx[i-1][j-1] = convolution(window, kx));
			tempy = (Gy[i-1][j-1] = convolution(window, ky));
			sq_sum = tempx*tempx +tempy*tempy;
			edges[i-1][j-1] = sqrt(sq_sum);
			angle[i-1][j-1] = atan2(tempy,tempx);	
		}
	}*/
}

void min_max_normalization(Real_t *image, const int width, const int height) {
	Real_t min_val = 1000000, max_val = 0;
	int i, j;
// #ifndef USE_Posit	
// #pragma omp parallel for collapse(2) reduction(max:max_val) reduction(min:min_val) num_threads(8)
// #endif
	for(i = 0; i < width; i++) {
		for(j = 0; j < height; j++) {
			min_val = min_val < image[i*height+j] ? min_val : image[i*height+j];
			max_val = max_val > image[i*height+j] ? max_val : image[i*height+j];
		}
	}

// #pragma omp parallel for collapse(2) num_threads(8)
	for(i = 0; i < width; i++) {
		for(j = 0; j < height; j++) {
			Real_t ratio = (Real_t) DIV((image[i*height+j] - min_val), (max_val - min_val));
			image[i*height+j] = MULT(ratio, 255);
		}
	} 
}

void run_algorithm(Real_t *image, Real_t *Gx, Real_t *Gy, Real_t *edges, Real_t *angle, const int width, const int height){
	
	std::cout<<"Preprocessing Image: By changing boundaries to zero"<< "\n";
	padding(image, width, height);
	
	std::cout<<"Running Sobel Algorithm for edge detection"<<"\n";
	
	Sobel_algorithm(image,Gx,Gy,edges,angle, width, height);
	
	std::cout<<"Filtering each Gradient in order to improve the results"<<"\n\n";
	// min_max_normalization(Gx, width, height);
	// min_max_normalization(Gy, width, height);
	min_max_normalization(edges, width, height);
}