# Remove logs
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

-keep class com.dexterous.** { *; }

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.preference.Preference

-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes SourceFile
-keepattributes LineNumberTable
-keepattributes EnclosingMethod

-keep public class * extends java.lang.Exception
-keep class * implements android.os.Parcelable {
    *;
}
-keepnames class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

-keepattributes *Annotation*,EnclosingMethod,Signature

-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

-dontwarn javax.annotation.**
-dontwarn javax.tools.**
-dontwarn javax.lang.**
-dontwarn java.awt.**
-dontwarn java.beans.**
-dontwarn java.lang.invoke.**
-dontwarn sun.misc.**
-dontwarn com.squareup.javapoet.**
-dontwarn rx.internal.util.unsafe.**

-keepclasseswithmembernames class * {
    native <methods>;
}
-keepclassmembers class **.R$* {
    public static <fields>;
}
-keepclasseswithmembernames class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembernames class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-dontwarn java.lang.invoke.*