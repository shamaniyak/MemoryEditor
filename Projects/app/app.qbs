import qbs
import qbs.FileInfo

CppApplication {
	Depends { name: "Qt"; submodules: ["core", "quick", "qml"] }
    Depends { name: "MemoryManager" }
    Depends { name: "Qt.testlib" }

	// Additional import path used to resolve QML modules in Qt Creator's code model
	property pathList qmlImportPaths: [project.globalModulesPath, "../../bin/qml/"]

	cpp.cxxLanguageVersion: "c++11"

	//destinationDirectory: project.globalBinPath

	cpp.includePaths: [project.globalIncludePath]

	cpp.defines: [
		// The following define makes your compiler emit warnings if you use
		// any feature of Qt which as been marked deprecated (the exact warnings
		// depend on your compiler). Please consult the documentation of the
		// deprecated API in order to know how to port your code away from it.
		"QT_DEPRECATED_WARNINGS",

        "RAN_AS_TEST",

		// You can also make your code fail to compile if you use deprecated APIs.
		// In order to do so, uncomment the following line.
		// You can also select to disable deprecated APIs only up to a certain version of Qt.
		//"QT_DISABLE_DEPRECATED_BEFORE=0x060000" // disables all the APIs deprecated before Qt 6.0.0
	]

	files: [
        "main.cpp",
        "myapp.cpp",
        "myapp.h",
        "qml.qrc",
    ]

    Group {
        name: "Test files"
        condition: cpp.defines.contains("RAN_AS_TEST")
        files: [
            "testmemory.cpp",
            "testmemory.h",
        ]
    }

	Group {     // Properties for the produced executable
		fileTagsFilter: "application"
		qbs.install: true
		qbs.installDir: "/bin"
	}
}
