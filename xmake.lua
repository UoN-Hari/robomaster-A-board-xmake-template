set_project("robomaster-A-board-xmake-template")
set_version("1.0.0")

add_rules("mode.debug", "mode.release")

toolchain("arm-none-eabi")
    set_kind("standalone")
    set_sdkdir("C:/arm-none-eabi-gcc/10 2021.10/")
toolchain_end()

target("robomaster-A-board-xmake-template")
    set_kind("binary")
    set_toolchains("arm-none-eabi")
    add_files(
        "./Core/Src/*.c",
        "./Core/Startup/startup_stm32f427ighx.s",
        "./Drivers/STM32F4xx_HAL_Driver/Src/*.c"
    )
    add_includedirs(
        "./Core/Inc",
        "./Drivers/CMSIS/Include",
        "./Drivers/CMSIS/Device/ST/STM32F4xx/Include",
        "./Drivers/STM32F4xx_HAL_Driver/Inc",
        "./Drivers/STM32F4xx_HAL_Driver/Inc/Legacy"
    )
    add_defines(
        "USE_HAL_DRIVER",
        "STM32F427xx"
    )
    add_cflags(
        "-Og",
        "-mcpu=cortex-m4",
        "-mthumb",
        "-Wall -fdata-sections -ffunction-sections",
        "-g -gdwarf-2",{force = true}
    )
    add_asflags(
        "-Og",
        "-mcpu=cortex-m4",
        "-mthumb",
        "-x assembler-with-cpp",
        "-Wall -fdata-sections -ffunction-sections",
        "-g -gdwarf-2",{force = true}
    )
    add_ldflags(
        "-Og",
        "-mcpu=cortex-m4",
        "-L./",
        "-TSTM32F427IGHX_FLASH.ld",
        "-Wl,--gc-sections",
        "-lc -lm -lnosys -lrdimon -u _printf_float",{force = true}
    )
    set_targetdir("build")
    set_filename("target.elf")


