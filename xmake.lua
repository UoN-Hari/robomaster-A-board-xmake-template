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
    set_languages("c11", "c++20")
    add_defines(
        "USE_HAL_DRIVER",
        "STM32F427xx",
        "ARM_MATH_CM4",
        "ARM_MATH_MATRIX_CHECK",
        "ARM_MATH_ROUNDING",
        "DEBUG"
    )
    add_cxflags(
        "-mcpu=cortex-m4",
        "-mthumb -mthumb-interwork",
        "-ffunction-sections -fdata-sections -fno-common -fmessage-length=0",

        -- Build with hardware float
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",

        -- Build with software float
        -- "-mfloat-abi=soft",

        "-Wall -fdata-sections -ffunction-sections",
        "-g -gdwarf-2",{force = true}
    )
    add_asflags(
        "-mcpu=cortex-m4",
        "-mthumb -mthumb-interwork",
        "-ffunction-sections -fdata-sections -fno-common -fmessage-length=0",

        -- Build with hardware float
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",

        -- Build with software float
        -- "-mfloat-abi=soft",

        "-Wall",
        "-g -gdwarf-2",{force = true}
    )
    add_ldflags(
        "-L./",
        "-TSTM32F427IGHX_FLASH.ld",
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mthumb-interwork",

        -- Build with hardware float
        "-mfloat-abi=hard -mfpu=fpv4-sp-d16",

        "-Wl,-gc-sections,--print-memory-usage,-Map=build/target.map",
        "-lc -lm -lnosys -lrdimon -u _printf_float",{force = true}
    )
    add_files(
        "./Core/Src/*.c",
        "./Core/Src/*.cc",
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
    set_targetdir("build")
    set_filename("target.elf")
target_end()

