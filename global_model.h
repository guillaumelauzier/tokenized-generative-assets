#pragma once

#include <vector>

class GlobalModel {
public:
    GlobalModel(int num_weights);
    void update_weights(const std::vector<float>& delta_weights);
    const std::vector<float>& get_weights() const;
private:
    std::vector<float> m_weights;
};

