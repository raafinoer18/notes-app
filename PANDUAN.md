# ============================================================
# FILE: android/app/build.gradle
# FUNGSI: Konfigurasi build Android
# PENTING: Untuk menghasilkan APK release
# ============================================================

# CATATAN: File ini menggantikan build.gradle di android/app/
# Salin isi ini ke android/app/build.gradle di project kamu

android {
    namespace "com.example.notes_app"
    compileSdk flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    defaultConfig {
        applicationId "com.example.notes_app"
        minSdkVersion 21          // minimal Android 5.0
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    # Konfigurasi untuk BUILD RELEASE (APK yang bisa diinstall)
    buildTypes {
        release {
            # Untuk UTS, pakai debug signing key (lebih mudah)
            # Di production app nyata, gunakan keystore sendiri
            signingConfig signingConfigs.debug
            
            # Minify = kompres kode (APK lebih kecil)
            minifyEnabled false
            shrinkResources false
        }
    }
}
