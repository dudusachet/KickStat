// Correção para o arquivo C:/kickstat2.0/android/build.gradle.kts

buildscript {
    repositories {
        // Repositórios necessários para o plugin, como google()
        google()
        mavenCentral()
    }
    dependencies {
        // ... outras dependências de classpath
        classpath("com.google.gms:google-services:4.4.0") // Sintaxe correta para Kotlin DSL
    }
}


allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}