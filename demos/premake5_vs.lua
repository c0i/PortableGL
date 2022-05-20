-- premake5.lua
--[[

> generate visual studio project
https://premake.github.io/download/

> install 3rd libs
https://vcpkg.io/en/index.html

# install vcpkg
git clone https://github.com/Microsoft/vcpkg.git
.\vcpkg\bootstrap-vcpkg.bat
vcpkg integrate install
vcpkg install sdl2

# generate vs project
premake5 vs2022 --file=premake5_vs.lua
]]



local VCPKG_ROOT = os.getenv('VCPKG_ROOT')..'/'


function set_sdl_common()
    filter "system:windows"
        local vcpkg_path = ''
        if VCPKG_ROOT then
            vcpkg_path = VCPKG_ROOT .. 'installed/x86-windows/'
        else
            vcpkg_path = ''
        end

        includedirs { vcpkg_path..'include' }
        libdirs ( vcpkg_path..'lib ')
        links  { "SDL2" }

end

-- A solution contains projects, and defines the available configurations
solution "Demos"
    configurations { "Debug", "Release" }
    location ('build')
    includedirs { "../", "../glcommon", "/usr/local/include" }

    -- stuff up here common to all projects
    kind "ConsoleApp"
    --location "build"
    --targetdir "build"
    targetdir "bin/%{cfg.buildcfg}"

    -- configuration "linux"
    --     links { "SDL2", "m" }
    
    configuration "windows"
        --linkdir "/mingw64/lib"
        --buildoptions "-mwindows"
        -- links { "mingw32", "SDL2main", "SDL2" }
        set_sdl_common()

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

    -- configuration { "gmake", "Release" }
    -- buildoptions { "-O3" }

    -- -- A project defines one build target
    -- project "swrenderer"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./main.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/rsw_glframe.cpp",
    --         "../glcommon/rsw_primitives.cpp",
    --         "../glcommon/gltools.cpp",
    --         "../glcommon/controls.cpp",
    --         "../glcommon/c_utils.cpp"
    --     }

    -- project "sphereworld"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./sphereworld.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/rsw_glframe.cpp",
    --         "../glcommon/rsw_primitives.cpp",
    --         "../glcommon/gltools.cpp",
    --         "../glcommon/rsw_halfedge.cpp",
    --         "../glcommon/controls.cpp",
    --         "../glcommon/c_utils.cpp"
    --     }

    -- project "sphereworld_color"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./sphereworld_color.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/rsw_glframe.cpp",
    --         "../glcommon/rsw_primitives.cpp",
    --         "../glcommon/gltools.cpp",
    --         "../glcommon/rsw_halfedge.cpp",
    --         "../glcommon/controls.cpp",
    --         "../glcommon/c_utils.cpp"
    --     }

    -- project "cubemap"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./cubemap.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/rsw_primitives.cpp",
    --         "../glcommon/gltools.cpp",
    --         "../glcommon/rsw_glframe.cpp",
    --         "../glcommon/stb_image.h"
    --     }

    -- project "grass"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./grass.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/rsw_glframe.cpp"
    --     }

   

    -- project "pointsprites"
    --     language "C"
    --     configuration { "gmake" }
    --         buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }
    --     files {
    --         "./pointsprites.c",
    --         "../glcommon/gltools.c",
    --         "../glcommon/gltools.h"
    --     }

    -- project "shadertoy"
    --     language "C++"
    --     configuration { "gmake" }
    --         buildoptions { "-fno-rtti", "-fno-exceptions", "-fno-strict-aliasing", "-Wunused-variable", "-Wreturn-type", "-fopenmp" }
    --         links { "SDL2", "m", "gomp" }
    --     files {
    --         "./shadertoy.cpp",
    --         "../glcommon/rsw_math.cpp",
    --         "../glcommon/gltools.cpp",
    --         "../glcommon/stb_image.h"
    --     }


    -- project "assimp_convertassimp_convert"
    --     language "C"
    --     files {
    --         "./assimp_convert.c",
    --     }

    --     links { "assimp", "m"}

    --     configuration { "gmake" }
    --     buildoptions { "-std=c99", "-pedantic-errors", "-Wunused-variable", "-Wreturn-type" }

    --     configuration { "gmake", "Release" }
    --     buildoptions { "-O3" }


apps = {
    {'gears','gears.c'},
    {'modelviewer',{'modelviewer.c', '../glcommon/chalfedge.c', '../glcommon/cprimitives.c'} },
    {'texturing',{'raytracing_1weekend.cpp', '../glcommon/rsw_math.cpp', '../glcommon/gltools.c', "../glcommon/stb_image.h"} },
    {'shadertoy',{'shadertoy.cpp', '../glcommon/rsw_math.cpp', '../glcommon/gltools.c', "../glcommon/stb_image.h"} },
    -- {'assimp_convert',{'assimp_convert.c'} },
}
for _,app in ipairs(apps) do
    local name,file = app[1],app[2]
    project (name)
        kind "ConsoleApp"
        language "C"
        targetdir "bin/%{cfg.buildcfg}"

        files { file }

        -- set_sdl_common()
end
