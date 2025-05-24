# HERE SDK - protect the styleable resources
-keep class com.here.sdk.R$styleable { *; }

# HERE SDK - keep all internal classes and resources
-keep class com.here.sdk.** { *; }

# HERE SDK - keep HERE internal classes for dynamic loading
-keep class com.here.sdk.mapview.** { *; }

# General rules to avoid stripping required resources
-keepclassmembers class * {
    public <init>(...);
}
