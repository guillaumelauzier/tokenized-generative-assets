#pragma once

#include <vector>
#include "global_model.h"

class LocalModel {
public:
    LocalModel(const GlobalModel& global_model, int num_samples);
    void train(const std::vector<std::vector<float>>& samples, const std::vector<int>& labels, float learning_rate);
    std::vector<float> get_weights() const;
    float evaluate(const std::vector<std::vector<float>>& samples, const std::vector<int>& labels) const;
private:
    std::vector<float> m_weights;
};

