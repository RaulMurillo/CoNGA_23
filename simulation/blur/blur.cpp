/* https://ieeexplore.ieee.org/document/8715112 */

#include "loadpng.hpp"
// #include "cuda_runtime.h"
// #include "device_launch_parameters.h"
#include <stdio.h>
#include <ctime>
#include <iostream>
#include <string>
#include <omp.h>
#include <universal/number/posit/posit.hpp>

// Namespaces
using namespace std;
using namespace sw::universal;

#ifndef USE_Posit
#define TXT_FMT "Float"
#define TXT_EXACT "exact"
#define Real_t float
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
// #define SQRT(x) (std::sqrt(x))
#else
#define TXT_FMT "Posit"
#define Real_t posit<32, 2>

#ifndef LOG_APPROX
#define TXT_EXACT "exact"
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
// #define SQRT(x) (sqrt(x))
#else
#define TXT_EXACT "approx"
#include "../src/log_mult.hpp"
#define MULT(a, b) log_mult((a), (b))
// #define MULT(a, b) ((a) * (b))
#include "../src/log_div.hpp"
#define DIV(a, b) log_div((a), (b))
// #define DIV(a, b) ((a) / (b))
// #include "../src/log_sqrt.hpp"
// #define SQRT(x) log_sqrt(x)
#endif // LOG_APPROX

#endif // USE_Posit

unsigned char* filterCPU(unsigned char* input_image, unsigned char* output_image, int width, int height) {
#pragma omp parallel for num_threads(8)
	for (int offset = 0; offset <= width*height-1; offset++){

		const int x = offset % width;
		const int y = (offset - x) / width;
		const int fsize = 3; // Filter size: 2*fsize+1

		Real_t output_red = 0;
		Real_t output_green = 0;
		Real_t output_blue = 0;
		int hits = 0;

		for (int ox = -fsize; ox < fsize + 1; ++ox) {
			for (int oy = -fsize; oy < fsize + 1; ++oy) {
				if ((x + ox) > -1 && (x + ox) < width && (y + oy) > -1 && (y + oy) < height) {
					const int currentoffset = (offset + ox + oy * width) * 3;
					output_red += (Real_t)(input_image[currentoffset]);
					output_green += (Real_t)(input_image[currentoffset + 1]);
					output_blue += (Real_t)(input_image[currentoffset + 2]);
					hits++;
				}
			}
		}

		output_image[offset * 3] = (float)(DIV(output_red, (Real_t)(hits)));
		output_image[offset * 3 + 1] = (float)(DIV(output_green, (Real_t)(hits)));
		output_image[offset * 3 + 2] = (float)(DIV(output_blue, (Real_t)(hits)));
	}
	
	return output_image;
}

int main(int argc, char** argv) {
	
	cout << "Blurring the given image..." << endl;

	// Read the arguments
	// const string input_file = "ALP.png";
	const string fname = "imgs/baboon";
	const string input_file = fname+(string)(".png");
#ifdef USE_Posit
  #ifdef LOG_APPROX
	const string output_fileCPU = fname+(string)("_blurred_approx.png");
  #else
	const string output_fileCPU = fname+(string)("_blurred_posit.png");
  #endif
#else
	const string output_fileCPU = fname+(string)("_blurred.png");
#endif
	// const string output_fileGPU = "blurred_GPU.png";

	vector<unsigned char> in_image;
	unsigned int width, height;

	// Load the data
	unsigned error = lodepng::decode(in_image, width, height, input_file);
	if (error) cout << "decoder error " << error << ": " << lodepng_error_text(error) << endl;
	else {
		cout << "Image loaded." << endl;
	}

	// Prepare the data
	unsigned char* input_image = new unsigned char[(in_image.size() * 3) / 4];
	unsigned char* output_imageCPU = new unsigned char[(in_image.size() * 3) / 4];
	// unsigned char* output_imageGPU = new unsigned char[(in_image.size() * 3) / 4];
	int where = 0;
	for (int i = 0; i < in_image.size(); ++i) {
		if ((i + 1) % 4 != 0) {
			input_image[where] = in_image.at(i);
			output_imageCPU[where] = 255;
			// output_imageGPU[where] = 255;
			where++;
		}
	}

	// Run the filter on CPU
	clock_t t_CPU_start, t_CPU_stop;
	t_CPU_start = clock();
	cout << endl << "Processing on CPU. " << endl;

	output_imageCPU = filterCPU(input_image, output_imageCPU, width, height);
	
	cout << "CPU Image blurred with success!" << endl;

	t_CPU_stop = clock();
	double t_CPU = (double)(t_CPU_stop - t_CPU_start) / CLOCKS_PER_SEC;
	cout << "CPU - time: " << t_CPU << endl;


	// // Run the filter on GPU
	// clock_t t_GPU_start, t_GPU_stop;
	// t_GPU_start = clock();
	// cout << endl << "Processing with CUDA. " << endl;

	// cudaError_t cudaStatus = filterGPU(input_image, output_imageGPU, width, height);
	// if (cudaStatus != cudaSuccess) {
	// 	fprintf(stderr, "filer failed!");
	// 	return 1;
	// }
	// else cout << "GPU Image blurred with success!" << endl;

	// t_GPU_stop = clock();
	// double t_GPU = (double)(t_GPU_stop - t_GPU_start) / CLOCKS_PER_SEC;
	// cout << "GPU - time: " << t_GPU << endl << endl;

	// Prepare data for output
	vector<unsigned char> out_imageCPU;
	// vector<unsigned char> out_imageGPU;
	
	for (int i = 0; i < in_image.size()*3/4; ++i) {
		out_imageCPU.push_back(output_imageCPU[i]);
		// out_imageGPU.push_back(output_imageGPU[i]);
		if ((i + 1) % 3 == 0) {
			out_imageCPU.push_back(255);
			// out_imageGPU.push_back(255);
		}
	}
	// Output the data
	error = lodepng::encode(output_fileCPU, out_imageCPU, width, height);
	// if (error == 0)
	// error = lodepng::encode(output_fileGPU, out_imageGPU, width, height);

	//if there's an error, display it
	if (error) cout << "encoder error " << error << ": " << lodepng_error_text(error) << endl;
	else {
		cout << "CPU Image saved as " << output_fileCPU << endl;
		// cout << "GPU Image saved as " << output_fileGPU << endl;
	}

	delete[] input_image;
	delete[] output_imageCPU;
	// delete[] output_imageGPU;
	return 0;
}