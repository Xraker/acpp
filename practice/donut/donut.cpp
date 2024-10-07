#include <chrono>
#include <cmath>
#include <iostream>
#include <thread>
#include <vector>

int main()
{
    constexpr int timer{1};

    std::cout << "\033[2J\033[H";
    constexpr int dots{360};
    constexpr double pi{3.14159265358979323846};
    constexpr int r{35};
    double x{}, y{};

    std::vector<std::vector<char>> grid(75, std::vector<char>(250, ' '));

    for (int t{20}; t < r; t += 4)
    {
        for (int i{}; i < dots; i++)
        {
            double angle{2 * pi * i / dots};
            x = (int)(cos(angle) * t);
            y = (int)(sin(angle) * t);
            x += r + 15;
            x *= 2;
            y += r;
            grid[y][x] = '$';
        }

        for (int u{}; u < 1; u++)
        {
            for (const auto &cycle : grid)
            {
                for (const auto &row : cycle)
                {
                    std::cout << row;

                    std::this_thread::sleep_for(std::chrono::nanoseconds(100 * timer));
                }
                std::cout << "\n";
            }
            std::this_thread::sleep_for(std::chrono::seconds(timer));
        }

        std::cout << "\033[2J\033[H";
    }
    return 0;
}
