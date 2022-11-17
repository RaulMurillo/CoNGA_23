#include "knn.hpp"

// Namespaces
using namespace sw::universal;
using namespace std;


#ifndef USE_Posit
#define Real_t double
#else
#define Real_t posit<32, 2>
#endif // USE_Posit

// #define Real_t double
// #define Real_t posit<32, 2>

// #define IRIS_DATA
// #define WINE_DATA
#define CANCER_DATA

int main(int argc, char **argv){

#ifdef IRIS_DATA
  int attr = 5; //number of attribute
  string path_dataset = "./dataset/iris.data";
  int num_data = 147; //number of data
  string path_data_test = "./dataset/iris_test.data";
  int num_data_test = 4; //number of data test
#elif defined(WINE_DATA)
  int attr = 14; //number of attribute
  string path_dataset = "./dataset/wine.data";
  int num_data = 172; //number of data
  string path_data_test = "./dataset/wine_test.data";
  int num_data_test = 6; //number of data test
#elif defined(CANCER_DATA)
  int attr = 32; //number of attribute
  string path_dataset = "./dataset/cancer.data";
  int num_data = 563; //number of data
  string path_data_test = "./dataset/cancer_test.data";
  int num_data_test = 6; //number of data test
#endif

  vector<vector<Real_t> > feature;
  vector<string> classes;
  vector<vector<Real_t> > feature_test;
  vector<string> classes_test;

  load_data(&feature, &classes, &path_dataset, attr, num_data); //Load Dataset Training
  load_data(&feature_test, &classes_test, &path_data_test, attr, num_data_test); //Load Dataset testing

  int k = 5; // K
  kNN<Real_t> knn(k);
  knn.fit(feature,classes); // Train model
  // Check test data
  for(int i=0; i<feature_test.size(); i++) {
	string prediction = knn.predict(feature_test[i]);
	cout << "Class: " << classes_test[i] << endl;
	cout << "Prediction: " << prediction << endl;
	cout << "Score: " << knn.score() << "\n\n";
  }

  return 0;
}
