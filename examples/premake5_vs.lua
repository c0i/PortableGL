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

workspace "Polished_Examples"
    configurations { "Debug", "Release" }
    includedirs { "../", "../glcommon" }
    location ('build')

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

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"    
end

apps = {
    {'ex1','ex1.cpp'},
    {'ex2','ex2.cpp'},
    {'ex3',{'ex3.cpp','../glcommon/rsw_math.cpp'}},
    {'c_ex1','ex1.c'},
    {'c_ex2','ex2.c'},
    {'c_ex3','ex3.c'},

}
for _,app in ipairs(apps) do
    local name,file = app[1],app[2]
    project (name)
        kind "ConsoleApp"
        language "C"
        targetdir "bin/%{cfg.buildcfg}"

        files { file }

        set_sdl_common()
end