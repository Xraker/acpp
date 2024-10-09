#include <cmath>
#include <iostream>
#include <vector>

int main()
{

    std::cout << "\033[2J\033[H";

    int r{20}, thickness{15}, dots{360}, x{}, y{};
    double angle{}, pi{3.14159265358979323846};

    std::vector<std::vector<char>> grid(75, std::vector<char>(250, ' '));

    for (int z{}; z < thickness; z++)
    {
        for (int i{}; i < dots; i++)
        {
            angle = 2 * pi * i / dots;
            x = static_cast<int>(cos(angle) * r) * 2;
            y = static_cast<int>(sin(angle) * r);

            x += 2 * r + 2 * (thickness - z);
            y += r + (thickness - z);

            grid[y][x] = '$';
        }
        r++;
    }

    for (const auto &ordinat : grid)
    {
        for (const auto &apsis : ordinat)
        {
            std::cout << apsis;
        }
        std::cout << '\n';
    }

    return 0;
}