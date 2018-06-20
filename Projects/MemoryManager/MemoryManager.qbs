import qbs 1.0
import qbs.FileInfo

DynamicLibrary {
	name: "MemoryManager"
	property string uri: "MemoryManager"

	Depends { name: "cpp" }
	Depends { name: "Qt"; submodules: ["core", "widgets", "quick", "qml"] }

	property string putOverBinSubdir: "qml/MemoryManager"
	property string prefix: ""
	property stringList addIncludes: []
	property stringList defines: []
	property stringList staticLibraries: []
	property stringList libraryPaths: []

	cpp.includePaths: [project.globalPath, project.globalIncludePath]
	//cpp.defines: project.buildWithEasyProfiler ? defines.concat(["BUILD_WITH_EASY_PROFILER"]) : defines
	cpp.cxxLanguageVersion: "c++11"
	//destinationDirectory: FileInfo.joinPaths(project.globalModulesPath,prefix,name)
	//cpp.debugInformation: project.generatePDB
	//cpp.staticLibraries: project.buildWithEasyProfiler ? staticLibraries.concat(["easy_profiler"]) : staticLibraries
	//cpp.libraryPaths: project.buildWithEasyProfiler ? libraryPaths.concat(FileInfo.joinPaths(project.globalProjectsPath,"3rdparty","easy_profiler","lib","win64")) : libraryPaths
	//cpp.optimization: project.generatePDB ? "none" : "fast"
	Group {
		fileTagsFilter: ["dynamiclibrary"]
		qbs.install: true
		qbs.installDir: FileInfo.relativePath(qbs.installRoot, FileInfo.joinPaths(project.globalBinPath, product.putOverBinSubdir))
	}

	Group {
		name: "qmldir"
		files: FileInfo.joinPaths(project.sourceDirectory,product.prefix,product.name,"qmldir")
		//qbs.installDir: FileInfo.joinPaths("qml",product.prefix,product.name)
		qbs.installDir: FileInfo.relativePath(qbs.installRoot, FileInfo.joinPaths(project.globalBinPath, product.putOverBinSubdir))
		qbs.install: true
	}

	Group {
		name: "src"
		files: [
			"*.cpp",
			"*.h",
			"../../Src/Memory/*.cpp",
			"../../Src/Memory/*.h",
		]
		excludeFiles: "../../Src/Memory/MemoryManager.*"
	}

}
