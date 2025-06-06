# Existing rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

-keepattributes *Annotation*
-keep @interface androidx.annotation.Keep
-keep class * {
    @androidx.annotation.Keep *;
}

-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers

# ✅ Flutter Deferred Components / Play Core
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.**
