//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by jni4net. See http://jni4net.sourceforge.net/ 
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CshapJni {
    
    
    #region Component Designer generated code 
    public partial class MeteoDailyData_cs_ {
        
        public static global::java.lang.Class _class {
            get {
                return global::CshapJni.@__MeteoDailyData_cs.staticClass;
            }
        }
    }
    #endregion
    
    #region Component Designer generated code 
    [global::net.sf.jni4net.attributes.JavaProxyAttribute(typeof(global::CshapJni.MeteoDailyData_cs), typeof(global::CshapJni.MeteoDailyData_cs_))]
    [global::net.sf.jni4net.attributes.ClrWrapperAttribute(typeof(global::CshapJni.MeteoDailyData_cs), typeof(global::CshapJni.MeteoDailyData_cs_))]
    internal sealed partial class @__MeteoDailyData_cs : global::java.lang.Object {
        
        internal new static global::java.lang.Class staticClass;
        
        private @__MeteoDailyData_cs(global::net.sf.jni4net.jni.JNIEnv @__env) : 
                base(@__env) {
        }
        
        private static void InitJNI(global::net.sf.jni4net.jni.JNIEnv @__env, java.lang.Class @__class) {
            global::CshapJni.@__MeteoDailyData_cs.staticClass = @__class;
        }
        
        private static global::System.Collections.Generic.List<global::net.sf.jni4net.jni.JNINativeMethod> @__Init(global::net.sf.jni4net.jni.JNIEnv @__env, global::java.lang.Class @__class) {
            global::System.Type @__type = typeof(__MeteoDailyData_cs);
            global::System.Collections.Generic.List<global::net.sf.jni4net.jni.JNINativeMethod> methods = new global::System.Collections.Generic.List<global::net.sf.jni4net.jni.JNINativeMethod>();
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getYear", "getYear0", "()S"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setYear", "setYear1", "(S)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getMonth", "getMonth2", "()B"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setMonth", "setMonth3", "(B)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getDay", "getDay4", "()B"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setDay", "setDay5", "(B)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getRainfall", "getRainfall6", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setRainfall", "setRainfall7", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getEvapor", "getEvapor8", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setEvapor", "setEvapor9", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getTemperature", "getTemperature10", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setTemperature", "setTemperature11", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getHumidity", "getHumidity12", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setHumidity", "setHumidity13", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getSunhour", "getSunhour14", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setSunhour", "setSunhour15", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getWindspeed", "getWindspeed16", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setWindspeed", "setWindspeed17", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "getEToPenman", "getEToPenman18", "()F"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "setEToPenman", "setEToPenman19", "(F)V"));
            methods.Add(global::net.sf.jni4net.jni.JNINativeMethod.Create(@__type, "__ctorMeteoDailyData_cs0", "__ctorMeteoDailyData_cs0", "(Lnet/sf/jni4net/inj/IClrProxy;)V"));
            return methods;
        }
        
        private static short getYear0(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()S
            // ()S
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            short @__return = default(short);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((short)(@__real.getYear()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setYear1(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, short year) {
            // (S)V
            // (S)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setYear(year);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static byte getMonth2(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()B
            // ()B
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            byte @__return = default(byte);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((byte)(@__real.getMonth()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setMonth3(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, byte month) {
            // (B)V
            // (B)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setMonth(month);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static byte getDay4(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()B
            // ()B
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            byte @__return = default(byte);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((byte)(@__real.getDay()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setDay5(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, byte day) {
            // (B)V
            // (B)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setDay(day);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getRainfall6(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getRainfall()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setRainfall7(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float rainfall) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setRainfall(rainfall);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getEvapor8(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getEvapor()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setEvapor9(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float evapor) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setEvapor(evapor);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getTemperature10(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getTemperature()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setTemperature11(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float temperature) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setTemperature(temperature);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getHumidity12(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getHumidity()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setHumidity13(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float humidity) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setHumidity(humidity);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getSunhour14(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getSunhour()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setSunhour15(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float sunhour) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setSunhour(sunhour);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getWindspeed16(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getWindspeed()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setWindspeed17(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float windspeed) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setWindspeed(windspeed);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static float getEToPenman18(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()F
            // ()F
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            float @__return = default(float);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__return = ((float)(@__real.getEToPenman()));
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
            return @__return;
        }
        
        private static void setEToPenman19(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__obj, float eToPenman) {
            // (F)V
            // (F)V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = global::net.sf.jni4net.utils.Convertor.StrongJp2C<global::CshapJni.MeteoDailyData_cs>(@__env, @__obj);
            @__real.setEToPenman(eToPenman);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        private static void @__ctorMeteoDailyData_cs0(global::System.IntPtr @__envp, global::net.sf.jni4net.utils.JniLocalHandle @__class, global::net.sf.jni4net.utils.JniLocalHandle @__obj) {
            // ()V
            // ()V
            global::net.sf.jni4net.jni.JNIEnv @__env = global::net.sf.jni4net.jni.JNIEnv.Wrap(@__envp);
            try {
            global::CshapJni.MeteoDailyData_cs @__real = new global::CshapJni.MeteoDailyData_cs();
            global::net.sf.jni4net.utils.Convertor.InitProxy(@__env, @__obj, @__real);
            }catch (global::System.Exception __ex){@__env.ThrowExisting(__ex);}
        }
        
        new internal sealed class ContructionHelper : global::net.sf.jni4net.utils.IConstructionHelper {
            
            public global::net.sf.jni4net.jni.IJvmProxy CreateProxy(global::net.sf.jni4net.jni.JNIEnv @__env) {
                return new global::CshapJni.@__MeteoDailyData_cs(@__env);
            }
        }
    }
    #endregion
}