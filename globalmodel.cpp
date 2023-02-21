#include <iostream>
#include <vector>

using namespace std;

class GlobalModel {
public:
    vector<double> weights;
    double bias;
    double learningRate;
    
    GlobalModel(int size, double rate) {
        weights = vector<double>(size, 0.0);
        bias = 0.0;
        learningRate = rate;
    }
    
    void train(vector<vector<double>> localGradients, int numLocalModels) {
        vector<double> totalGradients(weights.size(), 0.0);
        double totalBiasGradient = 0.0;
        
        for (int i = 0; i < numLocalModels; i++) {
            for (int j = 0; j < weights.size(); j++) {
                totalGradients[j] += localGradients[i][j];
            }
            totalBiasGradient += localGradients[i][weights.size()];
        }
        
        for (int i = 0; i < weights.size(); i++) {
            weights[i] -= learningRate * (totalGradients[i] / numLocalModels);
        }
        bias -= learningRate * (totalBiasGradient / numLocalModels);
    }
};

class LocalModel {
public:
    vector<vector<double>> data;
    vector<double> labels;
    vector<double> weights;
    double bias;
    double learningRate;
    
    LocalModel(vector<vector<double>> d, vector<double> l, double rate) {
        data = d;
        labels = l;
        weights = vector<double>(d[0].size(), 0.0);
        bias = 0.0;
        learningRate = rate;
    }
    
    vector<double> computeGradient() {
        vector<double> gradient(weights.size() + 1, 0.0);
        
        for (int i = 0; i < data.size(); i++) {
            double prediction = 0.0;
            for (int j = 0; j < weights.size(); j++) {
                prediction += weights[j] * data[i][j];
            }
            prediction += bias;
            
            gradient[weights.size()] += prediction - labels[i];
            for (int j = 0; j < weights.size(); j++) {
                gradient[j] += (prediction - labels[i]) * data[i][j];
            }
        }
        
        return gradient;
    }
};
