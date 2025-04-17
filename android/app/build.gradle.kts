import com.android.build.gradle.internal.cxx.configure.gradleLocalProperties

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.b2b_jewerlry_catalog"
    compileSdk = 34 // Use flutter.compileSdkVersion if defined in root

    ndkVersion = "25.1.8937393" // Replace with flutter.ndkVersion if dynamic

    defaultConfig {
        applicationId = "com.example.b2b_jewerlry_catalog"
        minSdk = 21 // Replace with flutter.minSdkVersion if dynamic
        targetSdk = 34 // Replace with flutter.targetSdkVersion if dynamic
        versionCode = 1 // Replace with flutter.versionCode if dynamic
        versionName = "1.0.0" // Replace with flutter.versionName if dynamic
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Replace with your release signing config
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.10.0")
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
    implementation("com.google.firebase:firebase-storage-ktx")
}
