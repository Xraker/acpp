#include <array>
#include <cmath>
#include <fstream>
#include <iostream>
#include <limits>

constexpr int sizearray{4};
constexpr int lightsize{1};

struct vec3f
{
    float x{};
    float y{};
    float z{};
    constexpr vec3f(float x_val, float y_val, float z_val) : x(x_val), y(y_val), z(z_val)
    {
    }
    constexpr vec3f() : x(0), y(0), z(0)
    {
    }

    // basic +, -, / with vectors
    vec3f operator-() const
    {
        return vec3f(-x, -y, -z);
    }
    vec3f operator-(const vec3f &other) const
    {
        return vec3f{x - other.x, y - other.y, z - other.z};
    }
    vec3f operator+(const vec3f &other) const
    {
        return vec3f{x + other.x, y + other.y, z + other.z};
    }
    vec3f operator/(const vec3f &other) const
    {
        return vec3f{x / other.x, y / other.y, z / other.z};
    }
    vec3f operator-(const float &other) const
    {
        return vec3f{x - other, y - other, z - other};
    }
    vec3f operator+(const float &other) const
    {
        return vec3f{x + other, y + other, z + other};
    }
    vec3f operator/(const float &other) const
    {
        return vec3f{x / other, y / other, z / other};
    }
    vec3f operator*(const float &other) const
    {
        return vec3f{x * other, y * other, z * other};
    }
    //
    // dot product calc
    float operator*(const vec3f &other) const
    {
        return float{x * other.x + y * other.y + z * other.z};
    }
    vec3f normalize()
    {
        float mag = vec3f(x, y, z).vectomag();
        if (mag > 0)
            return vec3f(x / mag, y / mag, z / mag);

        return *this;
    }
    float vectomag()
    {
        return sqrtf(x * x + y * y + z * z);
    }
};

struct Color
{
    static constexpr vec3f red{1.0f, 0.0f, 0.0f};
    static constexpr vec3f green{0.0f, 1.0f, 0.0f};
    static constexpr vec3f blue{0.0f, 0.0f, 1.0f};
    static constexpr vec3f yellow{1.0f, 1.0f, 0.0f};
    static constexpr vec3f cyan{0.0f, 1.0f, 1.0f};
    static constexpr vec3f magenta{1.0f, 0.0f, 1.0f};
    static constexpr vec3f white{1.0f, 1.0f, 1.0f};
    static constexpr vec3f black{0.0f, 0.0f, 0.0f};
    static constexpr vec3f gray{0.5f, 0.5f, 0.5f};
    static constexpr vec3f orange{1.0f, 0.647f, 0.0f};
    static constexpr vec3f ivory{0.4f, 0.4f, 0.3f};
    static constexpr vec3f redRubber{0.3f, 0.1f, 0.1f};
};

struct Light
{
    vec3f pos{};
    float intensity{1.5f};
    Light(const vec3f &p) : pos(p)
    {
    }
};

struct Sphere
{
    vec3f center{};
    float radius{};
    vec3f color{};

    constexpr Sphere(const vec3f &c, const float &r, const vec3f &t) : center(c), radius(r), color(t)
    {
    }

    Sphere()
    {
    }

    bool ray_intersect(const vec3f &rayorigin, const vec3f &raydirection, float &firstIntersection) const
    {
        vec3f centerV = center - rayorigin;
        float centerProjectedontoRay = centerV * raydirection;
        float squareddistanceBetweenCenternRay =
            centerV.vectomag() * centerV.vectomag() - centerProjectedontoRay * centerProjectedontoRay;

        if (squareddistanceBetweenCenternRay > radius * radius)
            return false;

        float halfChordDist = sqrtf(radius * radius - squareddistanceBetweenCenternRay);
        firstIntersection = centerProjectedontoRay - halfChordDist;
        float secondIntersection = centerProjectedontoRay + halfChordDist;

        if (firstIntersection < 0)
            firstIntersection = secondIntersection;
        if (firstIntersection < 0)
            return false;
        return true;
    }
};

vec3f reflect(vec3f I, vec3f N)
{
    return I - N * 2.f * (I * N);
}

vec3f cast_ray(const vec3f &rayorigin, const vec3f &raydirection, const Sphere *spheres, const Light *lights)
{
    float sphereDisttoPoint = 0;
    float mag;

    float intens{}, specularIntensity{}, spec{};

    for (int i{}; i < sizearray; i++)
    {
        if (spheres[i].ray_intersect(rayorigin, raydirection, sphereDisttoPoint))
        {
            for (int j{}; j < lightsize; j++)
            {
                vec3f point = raydirection * sphereDisttoPoint;
                vec3f ldir = lights[j].pos - point;
                intens +=
                    lights[j].intensity * std::max(0.f, ldir.normalize() * (point - spheres[i].center).normalize());

                spec = -reflect(ldir, (point - spheres[i].center).normalize()) * spheres[i].center;
                specularIntensity += lights[j].intensity * (float)std::pow(std::max(0.f, spec), 75);

                specularIntensity = std::max(specularIntensity, 1.5f);
            }
            return spheres[i].color * intens;
        }
    }
    return Color::black;
}

void writin(vec3f d, std::ofstream &ofs)
{
    ofs << (char)(255 * d.x);
    ofs << (char)(255 * d.y);
    ofs << (char)(255 * d.z);
}

const void render(const Sphere *spheres, const Light *lights)
{

    /*const int width{2560};
    const int height{1440};*/
    const int width{1024};
    const int height{768};
    /*const int width{500};
    const int height{500};*/
    const float aspect{float(width) / float(height)};
    const float fov = 1.05f;
    ////////////////////////////////////////////////

    std::ofstream ofs;
    ofs.open("C:/Users/aa/Desktop/myray.ppm", std::ofstream::binary);
    ofs << "P6\n" << width << " " << height << "\n255\n";

    ////////////////////////////////////////////////
    for (int j{}; j < height; ++j)
    {
        for (int i{}; i < width; ++i)
        {
            float x = (2 * (i + 0.5) / (float)width - 1) * tan(fov / 2.0) * width / (float)height;
            float y = -(2 * (j + 0.5) / (float)height - 1) * tan(fov / 2.0);

            vec3f dir = vec3f(x, y, -1).normalize();
            writin(cast_ray(vec3f(0, 0, 0), dir, spheres, lights), ofs);
        }
    }
    ofs.close();
}

Sphere sortbyDist(Sphere *spheres)
{
    Sphere x{};
    for (int i{}; i < sizearray; i++)
    {
        for (int j{}; j < sizearray - 1 - i; j++)
        {
            if (spheres[j].center.z < spheres[j + 1].center.z)
            {
                x = spheres[j];
                spheres[j] = spheres[j + 1];
                spheres[j + 1] = x;
            }
        }
    }

    return x;
}

// red, green, blue, yellow, cyan, magenta, white, black, gray, orange
int main()
{
    /*
    Sphere spheres[]{
        {vec3f(3, 0, -30), 4.0f, Color::blue},
        {vec3f(-3, 0, -29), 4.0f, Color::red},
        {vec3f(0, -3, -28), 4.0f, Color::gray},
        {vec3f(0, 3, -32), 4.0f, Color::magenta},
    };*/

    Sphere spheres[]{

        {vec3f(-3, 0, -16), 2.0f, Color::ivory},
        {vec3f(-1.0, -1.5, -12), 2.0f, Color::redRubber},
        {vec3f(1.5, -0.5, -18), 3.0f, Color::redRubber},
        {vec3f(7, 5, -18), 4.0f, Color::ivory},
    };

    Light lights[]{
        {vec3f(-20, 20, 20)},
        //{vec3f(20, 20, 20)},
    };

    sortbyDist(spheres);
    render(spheres, lights);
    return 0;
}