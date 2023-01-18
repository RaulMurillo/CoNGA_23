/*----------------------------------------------------------------------
+----------------------------------------------------------------------+
| @file knn.h                                                          |
| @author Lucas Fontes Buzuti                                          |
| @version V0.0.1                                                      |
| @created 01/08/2019                                                  |
| @modified 01/08/2019                                                 |
| @e-mail lucas.buzuti@outlook.com                                     |
| @url https://github.com/buzutilucas/k-NN                             |
+----------------------------------------------------------------------+
Header file containing the KNN and KNNException class
----------------------------------------------------------------------*/

#ifndef KNN_HPP
#define KNN_HPP

#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <fstream>
#include <cctype>
#include <set>
#include <map>
#include <string>
#include <math.h>
#include <stdlib.h>

#include <universal/number/posit/posit.hpp>

// Namespaces
using namespace sw::universal;
// using namespace std;

#ifndef USE_Posit
#define TXT_FMT "Float"
#define TXT_EXACT "exact"
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
#define SQRT(x) (sqrt(x))
#else
#define TXT_FMT "Posit"

#ifndef LOG_APPROX
#define TXT_EXACT "exact"
#define MULT(a, b) ((a) * (b))
#define DIV(a, b) ((a) / (b))
#define SQRT(x) (sqrt(x))
#else
#define TXT_EXACT "approx"
#include "../../src/log_mult.hpp"
#define MULT(a, b) log_mult((a), (b))
// #define MULT(a, b) ((a) * (b))
#include "../../src/log_div.hpp"
#define DIV(a, b) log_div((a), (b))
// #define DIV(a, b) ((a) / (b))
#include "../../src/log_sqrt.hpp"
#define SQRT(x) log_sqrt(x)
#endif // LOG_APPROX

#endif // USE_Posit

template <typename Type>
class kNN
{
private:
	int k;
	int target_class;
	std::vector<std::vector<Type>> dataset;
	std::vector<std::string> attr_class;
	std::set<std::string> classes;

	/*The function returns the Euclidean distance between two data.*/
	Type euclidean_distance(std::vector<Type> &ind1, std::vector<Type> &ind2)
	{
		/*
		Param:
			vector<Type> - Vector with numeric predictive attributes (feature).
		Return: euclidean distance of tow elements.
		*/
		typename std::vector<Type>::iterator it1, it2;
		Type sum = 0.;

		it1 = ind1.begin();
		it2 = ind2.begin();
// #pragma omp parallel for reduction(+: sum) num_threads(16)
		while (it1 != ind1.end() && it2 != ind2.end())
		{
			// sum += pow((*it1 - *it2), 2);
			sum += MULT((*it1 - *it2), (*it1 - *it2));
			it1++;
			it2++;
		}
		return SQRT(sum);
	}

	/*Detects all classes*/
	void set_classes(std::vector<std::string> &attr_class)
	{
		/*
		Param:
			vector<string> - Vector of the dataset, where it contains
							the class attributes of the dataset.
		*/
		std::set<std::string> classes(attr_class.begin(), attr_class.end());
		this->classes = classes;
	}

public:
	// Default constructor (kNN class).
	kNN<Type>(int k = 3)
	{
		/*
		Param:
			int k  - `k` is the number of neighbors that will be taken into
					account to classify new data, it is recommended that it
					will be odd so there will not be tie.
		*/
		if (k % 2 == 0)
		{
			throw "The k is even, change to odd.";
			exit(0);
		}
		if (k < 0)
		{
			throw "The k is negative, change to positive.";
			exit(0);
		}
		this->k = k;
	}
	// Destructor (kNN class).
	~kNN<Type>()
	{
		dataset.clear();
		attr_class.clear();
		classes.clear();
	}

	/*Function fit*/
	void fit(std::vector<std::vector<Type>> &dataset, std::vector<std::string> &attr_class)
	{
		/*
		Param:
		vector<vector<Type> >  - Matrix of the dataset, where it contains
								the numeric predictive attributes (feature)
								of the dataset.
		vector<string>         - Vector of the dataset, where it contains
								the class attributes of the dataset.
		*/
		this->dataset = dataset;
		this->attr_class = attr_class;
	}

	/*Function predict*/
	std::string predict(std::vector<Type> &ind1)
	{
		/*
		Param:
		vector<Type>  -  Vector of the dataset, where it contains the
						predictive numerical attributes (feature)
						to be predicted.
		Return: string that it is prediction.
		*/
		std::set<std::pair<Type, int>> distances;
		typename std::set<std::pair<Type, int>>::iterator it;

		for (int i = 0; i < dataset.size(); i++)
		{
			Type distance = euclidean_distance(dataset.at(i), ind1);
			distances.insert(std::make_pair(distance, i));
		}

		set_classes(attr_class);
		std::set<std::string>::iterator itclass;

		std::vector<int> count_classes(classes.size(), 0);
		std::vector<int>::iterator itcount;

		// Counts number of class classify
		it = distances.begin();
		int max_k = 0;
		while (it != distances.end() && max_k != k)
		{
			itcount = count_classes.begin();
			itclass = classes.begin();
			while (itcount != count_classes.end() && itclass != classes.end())
			{
				if (attr_class[it->second] == *itclass)
				{
					(*itcount)++;
				}
				itcount++;
				itclass++;
			}
			max_k++;
			it++;
		}

		// determination of the class
		int p = 0;
		target_class = count_classes[0];
		for (int i = 1; i < count_classes.size(); i++)
		{
			if (target_class < count_classes[i])
			{
				target_class = count_classes[i];
				p = i;
			}
		}
		itclass = classes.begin();
		int c = 0;
		while (c != p)
		{
			itclass++;
			c++;
		}

		return *itclass;
	}

	/*Return probability of class K for the example*/
	double score()
	{
		return (double)target_class / k;
	}
	// Type score()
	// {
	// 	return DIV((Type)target_class, (Type)k);
	// }
};

template <class Type>
void load_data(std::vector< std::vector<Type> > *feature, std::vector<std::string> *classes, std::string *path_to_dataset, int attr, int num)
{
    std::ifstream read(*path_to_dataset);

    std::vector<std::string> temp_vet;
    std::string line;
    std::string temp;

    if (read.fail())
    {
        std::cout << "Failure to open a file." << std::endl;
        std::cout << "File: " << *path_to_dataset << std::endl;
        exit(0);
    }

    while (getline(read, line))
    {
        std::istringstream iss(line); // string stream
        while (getline(iss, temp, ','))
        {
            temp_vet.push_back(temp);
        }
    }

    read.close();

    int k = 0;
    for (int i = 0; i < num; i++)
    {
        std::vector<Type> myvector;
        for (int j = 0; j < attr; j++)
        {
            if (isalpha(temp_vet[k].c_str()[0]))
                classes->push_back(temp_vet[k]);
            else
                myvector.push_back(atof(temp_vet[k].c_str()));
            k++;
        }
        feature->push_back(myvector);
    }
};

#endif // KNN_HPP