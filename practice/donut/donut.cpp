#include <cmath>
#include <iostream>
#include <vector>
#include <windows.h>

int main()
{
    // std::cout << "\033[2J\033[H";

    // max r = 76 min thickness = 1 on 2560x1440
    // min r = 0 max thickness = 78 on 2560x1440

    // max r = 58 min thickness = 1 on 1920x1080
    //  min r = 0 max thickness = 60 on 1920x1080

    int r{10}, x{}, y{};
    constexpr int thickness{20}, dots{360};
    double angle{};

    constexpr double pi{3.14159265358979323846}, angle_increment{2 * pi / dots};

    int x_length{4 * (r + thickness) - 3}, y_length{2 * (r + thickness) - 1};

    std::vector<std::vector<char>> grid(y_length, std::vector<char>(x_length, ' '));

    // calc circle
    for (int z{}; z < thickness; z++)
    {
        for (int i{}; i < dots; i++)
        {
            angle = angle_increment * i;
            x = static_cast<int>(cos(angle) * r) * 2;
            y = static_cast<int>(sin(angle) * r);

            x += 2 * r + 2 * (thickness - z) - 2;
            y += r + (thickness - z) - 1;

            grid[y][x] = '.';
        }
        r++;
    }

    // accuracy fix
    for (int u{1}; u < y_length - 1; u++)
    {
        for (int o{2}; o < x_length - 2; o++)
        {
            if (grid[u][o + 2] != ' ' && grid[u][o + -2] != ' ' && grid[u][o] == ' ' ||
                grid[u + 1][o] != ' ' && grid[u - 1][o] != ' ' && grid[u][o] == ' ')
                grid[u][o] = '.';
        }
    }

    // print the circle
    int xxx{};
    while (xxx != 1)
    {
        for (const auto &ordinat : grid)
        {
            for (const auto &apsis : ordinat)
            {
                std::cout << apsis;
            }
            std::cout << '\n';
        }
        xxx += 1;
        // std::cout << "\033[2J\033[H";
    }
    return 0;
}