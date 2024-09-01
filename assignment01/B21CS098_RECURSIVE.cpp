#include <iostream>
#include <vector>
#include <chrono>
#include <complex>

using namespace std;
using namespace std::chrono;

const int WIDTH = 800;
const int HEIGHT = 600;
const int MAX_ITER = 1000;

void mandelbrot(const int width, const int height, vector<vector<int>>& output) {
    for (int x = 0; x < width; ++x) {
        for (int y = 0; y < height; ++y) {
            complex<double> c((x - width / 2.0) * 4.0 / width, (y - height / 2.0) * 4.0 / height);
            complex<double> z(0, 0);
            int iter = 0;
            while (abs(z) < 2.0 && iter < MAX_ITER) {
                z = z * z + c;
                ++iter;
            }
            output[x][y] = iter;
        }
    }
}

int main() {
    vector<vector<int>> output(WIDTH, vector<int>(HEIGHT, 0));

    auto start = high_resolution_clock::now();

    mandelbrot(WIDTH, HEIGHT, output);

    auto end = high_resolution_clock::now();
    auto duration = duration_cast<milliseconds>(end - start);

    cout << "Time taken: " << duration.count() << " ms" << endl;

    return 0;
}
