
#include "local_model.h"

LocalModel::LocalModel(const GlobalModel& global_model, int num_samples) {
    m_weights = global_model.get_weights();
    // Initialize bias term to 0
    m_weights.push_back(0.0f);
}

void LocalModel::train(const std::vector<std::vector<float>>& samples, const std::vector<int>& labels, float learning_rate) {
    const int num_features = samples[0].size();
    const int num_samples = samples.size();
    for (int i = 0; i < num_samples; i++) {
        // Add bias term to sample
        std::vector<float> sample = samples[i];
        sample.push_back(1.0f);
        // Compute prediction
        float pred = 0.0f;
        for (int j = 0; j < num_features + 1; j++) {
            pred += m_weights[j] * sample[j
