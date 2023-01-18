#include "knn.hpp"

// Namespaces
using namespace sw::universal;
using namespace std;


#ifndef USE_Posit
#define Real_t float
#else
#define Real_t posit<32, 2>
#endif // USE_Posit

// #define Real_t double
// #define Real_t posit<32, 2>

#define IRIS_DATA
// #define WINE_DATA
// #define GLASS_DATA
// #define CANCER_DATA
// #define BEAN_DATA

void init_msg()
{
	cout << "Using " << TXT_EXACT << " " << TXT_FMT << " format" << endl;
}

int main(int argc, char **argv){
  init_msg();

#ifdef IRIS_DATA
  const int k = 5; // K
  int attr = 4+1; //number of attribute
  string path_dataset = "../dataset/iris_train.data";
  int num_data = 105; //number of data
  string path_data_test = "../dataset/iris_test.data";
  int num_data_test = 45; //number of data test
#elif defined(WINE_DATA)
  const int k = 7; // K
  int attr = 13+1; //number of attribute
  string path_dataset = "../dataset/wine_train.data";
  int num_data = 125; //number of data
  string path_data_test = "../dataset/wine_test.data";
  int num_data_test = 53; //number of data test
#elif defined(CANCER_DATA)
  const int k = 13; // K
  int attr = 30+1; //number of attribute
  string path_dataset = "../dataset/cancer_train.data";
  int num_data = 398; //number of data
  string path_data_test = "../dataset/cancer_test.data";
  int num_data_test = 171; //number of data test
#elif defined(BEAN_DATA)
  const int k = 5; // K
  int attr = 16+1; //number of attribute
  string path_dataset = "../dataset/drybean_train.data";
  int num_data = 9528; //number of data
  string path_data_test = "../dataset/drybean_test.data";
  int num_data_test = 4083; //number of data test
#elif defined(GLASS_DATA)
  const int k = 5; // K
  int attr = 9+1; //number of attribute
  string path_dataset = "../dataset/glass_train.data";
  int num_data = 150; //number of data
  string path_data_test = "../dataset/glass_test.data";
  int num_data_test = 64; //number of data test
#endif

  vector<vector<Real_t> > feature;
  vector<string> classes;
  vector<vector<Real_t> > feature_test;
  vector<string> classes_test;

  load_data(&feature, &classes, &path_dataset, attr, num_data); //Load Dataset Training
  load_data(&feature_test, &classes_test, &path_data_test, attr, num_data_test); //Load Dataset testing

  kNN<Real_t> knn(k);
  knn.fit(feature,classes); // Train model
  // Check test data
  int acc = 0;
  for(int i=0; i<feature_test.size(); i++) {
    string prediction = knn.predict(feature_test[i]);
    cout << "Class: " << classes_test[i] << endl;
    cout << "Prediction: " << prediction << endl;
    cout << "Score: " << knn.score() << "\n\n";
    acc += classes_test[i] == prediction;
  }
  cout << "Accuracy: " << acc << "/" << feature_test.size() << " = " << 100*(double)(acc)/feature_test.size() << "%\n\n";
  init_msg();

  return 0;
}
