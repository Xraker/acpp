#include <cmath>
#include <iostream>
#include <vector>

int main()
{

    std::cout << "\033[2J\033[H";

    int r{30}, dots{360};
    double x{}, y{}, angle{}, pi{3.14159265358979323846};

    std::vector<std::vector<char>> grid(75, std::vector<char>(250, ' '));

    for (int i{}; i < dots; i++)
    {
        angle = 2 * pi * i / dots;
        x = 2 * ((int)(cos(angle) * r + r));
        y = (int)(sin(angle) * r + r);

        grid[y][x] = '$';
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
