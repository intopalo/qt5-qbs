import qbs

// Base type for QtModule and QtPlugin
DynamicLibrary { // ### food for thought: delay linking for another step, making headers the only dependency
    readonly property path includeDirectory: project.buildDirectory + "/include"

    Depends { name: "cpp" }
    Depends { name: "QtHost"; submodules: ["config", "includes", "moc", "rcc"] }

    cpp.defines: [
        "QT_BUILDING_QT",
        "_USE_MATH_DEFINES",
        "QT_ASCII_CAST_WARNINGS",
        "QT_MOC_COMPAT",
        "QT_DEPRECATED_WARNINGS",
        "QT_DISABLE_DEPRECATED_BEFORE=0x040800",
    ]

    QtHost.moc.includePaths: base.concat(QtHost.includes.modulesIncludes)

    Properties {
        condition: qbs.targetOS.contains("windows") && qbs.toolchain.contains("msvc")
        cpp.defines: [
            "_SCL_SECURE_NO_WARNINGS",
        ]
    }
}
