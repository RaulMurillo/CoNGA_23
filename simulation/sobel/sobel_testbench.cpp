#include <iostream>
#include <stdio.h>
#include <math.h>
#include <cstdlib>
#include <string>
// #include <time.h>
#include <ctime>

#include "sobel.hpp"
#include "loadpng.hpp"
// #include "yuv_io.h"


using namespace std;

int main(int argc, char** argv) {
	
	cout << "Sobel edge detection..." << endl;

	// Read the arguments
	const unsigned int channels = 2;
	const string fname = "imgs/peppers";
	const string input_file = fname+(string)(".png");
#ifdef USE_Posit
  #ifdef LOG_APPROX
	const string output_fileCPU = fname+(string)("_edges_approx.png");
  #else
	const string output_fileCPU = fname+(string)("_edges_posit.png");
  #endif
#else
	const string output_fileCPU = fname+(string)("_edges_golden.png");
#endif

	vector<unsigned char> in_image;
	unsigned int width, height;

	// Load the data
	unsigned error;
	if (channels == 3){
		error = lodepng::decode(in_image, width, height, input_file, LCT_RGB);
	}
	else{
		error = lodepng::decode(in_image, width, height, input_file, LCT_GREY);
	}
	if (error) cout << "decoder error " << error << ": " << lodepng_error_text(error) << endl;
	else {
		cout << "Image loaded." << endl;
	}

	// Prepare the data
	int out_size = width * height;
	Real_t* input_image = new Real_t[out_size];
	Real_t* output_imageCPU = new Real_t[out_size];
	Real_t* gx = new Real_t[out_size];
	Real_t* gy = new Real_t[out_size];
	Real_t* output_image_angle = new Real_t[out_size];

	// Convert RGB image to Greyscale
	if (channels == 3) {
		// cout << endl << "Input image size is " << in_image.size() << endl;
#pragma omp parallel for num_threads(8)
		for (int i=0; i<height; i++) {
			for (int j=0; j<width; j++) {
				input_image[i*width+j] = (Real_t) ((float)(in_image.at(i*width*3+j*3) + in_image.at(i*width*3+j*3+1) + in_image.at(i*width*3+j*3+2))/3);
				// input_image[i*width+j] =  0.299 * in_image.at(i*width*3+j*3) + 0.587 * in_image.at(i*width*3+j*3+1) + 0.114 * in_image.at(i*width*3+j*3+2);
			}
		}
	}
	else{
		// cout << endl << "Input image size is " << in_image.size() << endl;
#pragma omp parallel for num_threads(8)
		for (int i=0; i<height; i++) {
			for (int j=0; j<width; j++) {
				input_image[i*width+j] = (Real_t) in_image.at(i*width+j);
			}
		}
		// for (int i = 0; i < in_image.size(); ++i)
		// 	input_image[i] = (float) in_image.at(i);
	}

	//Running Algorithm
	clock_t t_CPU_start, t_CPU_stop;
	t_CPU_start = clock();
	cout << endl << "Processing on CPU. " << endl;

	run_algorithm((Real_t *)input_image, (Real_t *)gx, (Real_t *)gy, (Real_t *)output_imageCPU, (Real_t *)output_image_angle, width, height);
	
	cout << "CPU Image edge detection with success!" << endl;

	t_CPU_stop = clock();
	double t_CPU = (double)(t_CPU_stop - t_CPU_start) / CLOCKS_PER_SEC;
	cout << "CPU - time: " << t_CPU << endl;

	//////
	// Prepare data for output
	vector<unsigned char> out_imageCPU;
	// vector<unsigned char> out_imageGPU;
	// for (int i = 0; i < out_size; ++i) {
	// 	out_imageCPU.push_back(input_image[i]);
	// }
	for (int i=0; i<height; i++) {
		for (int j=0; j<width; j++) {
			out_imageCPU.push_back((float)output_imageCPU[i*width+j]);
		}
	}

	// Output the data
	error = lodepng::encode(output_fileCPU, out_imageCPU, width, height, LCT_GREY);
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
	delete[] gx;
	delete[] gy;
	delete[] output_image_angle;


	return 0;
}