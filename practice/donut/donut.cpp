#include <cmath>
#include <iostream>
#include <vector>

int main()
{
    std::cout << "\033[2J\033[H";

    int r{20}, x{}, y{};
    double angle{};

    constexpr int thickness{7}, dots{360};
    constexpr double pi{3.14159265358979323846}, angle_increment{2 * pi / dots};

    int x_length{4 * (r + thickness) - 3}, y_length{2 * (r + thickness) - 1};

    std::vector<std::vector<char>> grid(y_length, std::vector<char>(x_length, ' '));

    for (int z{}; z < thickness; z++)
    {
        for (int i{}; i < dots; i++)
        {
            angle = angle_increment * i;
            x = static_cast<int>(cos(angle) * r) * 2;
            y = static_cast<int>(sin(angle) * r);

            x += 2 * r + 2 * (thickness - z) - 2;
            y += r + (thickness - z) - 1;

            grid[y][x] = '$';
            // std::cout << y << " - " << x << "\n";
        }
        r++;
    }

    while (1)
    {
        for (const auto &ordinat : grid)
        {
            for (const auto &apsis : ordinat)
            {
                std::cout << apsis;
            }
            std::cout << '\n';
        }
    }
    return 0;
}