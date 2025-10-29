#
#-dontusemixedcaseclassnames
#-dontskipnonpubliclibraryclasses
#-dontwarn android.support.**
#-dontwarn com.squareup.**
#-dontwarn com.google.android.**
#-verbose
#
## -keepattributes *Annotation*
#-dontwarn lombok.**
#-dontwarn io.realm.**
#
#-dontwarn java.awt.**
#
## okhttp3
#-dontwarn okhttp3.**
#-dontwarn okio.**
#-dontwarn javax.annotation.**
#-dontwarn org.conscrypt.**
## A resource is loaded with a relative path so the package of this class must be preserved.
#-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
#
## Application classes that will be serialized/deserialized over Gson
#-keep class vnpt.it3.econtract.data.model.** { *; }
#-keep class vnpt.it3.econtract.data.** { *; }
#
## Java 8
#-dontwarn java.lang.invoke.*
#-dontwarn **$$Lambda$*
#
## Retrofit 2
#-dontnote retrofit2.Platform
#-dontnote retrofit2.Platform$IOS$MainThreadExecutor
#-dontwarn retrofit2.Platform$Java8
#-keepattributes Signature
#-keepattributes Exceptions
#-keepclassmembernames,allowobfuscation interface * {
#    @retrofit2.http.* <methods>;
#}
#-keepclasseswithmembers class * {
#    @retrofit2.http.* <methods>;
#}
#-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
#
#
## pdf lib
#-keep class com.shockwave.**
#
##To remove debug logs:
#-assumenosideeffects class android.util.Log {
#    public static *** d(...);
#    public static *** v(...);
#    public static *** w(...);
#    public static *** i(...);
#}
#
#-keep public enum vnpt.it3.econtract.data.**{
#    *;
#}
#
#-keepclassmembers class **.R$* {
#  public static <fields>;
#}
## Glide
#-keep public class * implements com.bumptech.glide.module.GlideModule
#-keep public class * extends com.bumptech.glide.module.AppGlideModule
#-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
#  **[] $VALUES;
#  public *;
#}
#
#-keep enum org.greenrobot.eventbus.ThreadMode { *; }
#-keep class com.vnptit.innovation.sample.model.** { *; }
#-keep class ai.icenter.face3d.native_lib.Face3DConfig { *; }
#-keep class ai.icenter.face3d.native_lib.CardConfig { *; }
#
#-keep class * extends android.support.v4.app.Fragment{}
#-keep class * extends androidx.fragment.app.Fragment{}
#-keepnames class * extends android.os.Parcelable
#-keepnames class * extends java.io.Serializable

# =======================================
# 🧩 Cấu hình cơ bản
# =======================================
##############################################
# 🔒 ProGuard Rules - VNPT SmartCA Integration
# Tối ưu hoá và giữ lại các class cần thiết
##############################################

-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontwarn android.support.**
-dontwarn com.squareup.**
-dontwarn com.google.android.**
-dontwarn lombok.**
-dontwarn io.realm.**
-dontwarn java.awt.**
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-verbose

##############################################
# ⚙️ Java 8 và Lambda Expressions
##############################################
-dontwarn java.lang.invoke.*
-dontwarn **$$Lambda$*

##############################################
# 🌐 Retrofit 2 / OkHttp / Gson
##############################################
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontnote retrofit2.Platform
-dontnote retrofit2.Platform$IOS$MainThreadExecutor
-dontwarn retrofit2.Platform$Java8
-keepattributes Signature
-keepattributes Exceptions
-keepclassmembernames,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

##############################################
# 🗃️ Gson Model Classes
##############################################
-keep class vnpt.it3.econtract.data.model.** { *; }
-keep class vnpt.it3.econtract.data.** { *; }

##############################################
# 🧠 EventBus / PDF / Logging
##############################################
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
-keep class com.shockwave.** { *; }

# Ẩn toàn bộ Log.* khi build release
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** w(...);
    public static *** i(...);
}

##############################################
# 📷 Glide (dùng trong SmartCA SDK)
##############################################
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

##############################################
# 🔐 Google Tink (dùng cho ký số)
##############################################
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**
-keep class com.google.errorprone.annotations.** { *; }
-dontwarn com.google.errorprone.annotations.**

##############################################
# 🧩 VNPT SmartCA SDK + IDG + Face3D
##############################################
-keep class com.vnpt.** { *; }
-keep class com.vnptit.** { *; }
-keep class ai.icenter.** { *; }
-keep class vn.mobileid.smartca.** { *; }

# Face3D SDK Native Config
-keep class ai.icenter.face3d.native_lib.Face3DConfig { *; }
-keep class ai.icenter.face3d.native_lib.CardConfig { *; }

# Giữ toàn bộ SDKEnum và các inner class (bao gồm ModeCheckLiveNessFace)
-keep class com.vnptit.idg.sdk.utils.SDKEnum { *; }
-keep class com.vnptit.idg.sdk.utils.SDKEnum$* { *; }
-dontwarn com.vnptit.idg.sdk.utils.SDKEnum$ModeCheckLiveNessFace

##############################################
# 🧱 Cấu trúc Fragment / Parcelable / Kotlin
##############################################
-keepclassmembers class **.R$* {
  public static <fields>;
}
-keep public enum vnpt.it3.econtract.data.** { *; }
-keep class * extends android.support.v4.app.Fragment {}
-keep class * extends androidx.fragment.app.Fragment {}
-keepnames class * extends android.os.Parcelable
-keepnames class * extends java.io.Serializable
-keep class androidx.** { *; }
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }

##############################################
# ✅ Kết thúc file
##############################################

