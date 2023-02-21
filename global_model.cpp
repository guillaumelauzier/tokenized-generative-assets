#include "global_model.h"

GlobalModel::GlobalModel(int num_weights) {
    m_weights = std::vector<float>(num_weights, 0.0f);
}

void GlobalModel::update_weights(const std::vector<float>& delta_weights) {
    for (int i = 0; i < delta_weights.size(); i++) {
        m_weights[i] += delta_weights[i];
    }
}

const std::vector<float>& GlobalModel::get_weights() const {
    return m_weights;
}


