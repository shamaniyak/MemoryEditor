import qbs.base 1.0
import qbs.FileInfo

Project {
    minimumQbsVersion: "1.7.1"

    property string globalPath: FileInfo.path(sourceDirectory + "/../")
    property string globalBinPath: globalPath + "/bin"
    property string globalModulesPath: globalBinPath + "/qml"
    property string globalIncludePath: globalPath + "/Src"

    references: [
        "memorymanager/memorymanager.qbs",
        "app/app.qbs"
    ]
}
