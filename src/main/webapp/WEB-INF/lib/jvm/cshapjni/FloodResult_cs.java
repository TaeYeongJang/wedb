// ------------------------------------------------------------------------------
//  <autogenerated>
//      This code was generated by jni4net. See http://jni4net.sourceforge.net/ 
// 
//      Changes to this file may cause incorrect behavior and will be lost if 
//      the code is regenerated.
//  </autogenerated>
// ------------------------------------------------------------------------------

package cshapjni;

@net.sf.jni4net.attributes.ClrType
public class FloodResult_cs extends system.Object {
    
    //<generated-proxy>
    private static system.Type staticType;
    
    protected FloodResult_cs(net.sf.jni4net.inj.INJEnv __env, long __handle) {
            super(__env, __handle);
    }
    
    @net.sf.jni4net.attributes.ClrConstructor("()V")
    public FloodResult_cs() {
            super(((net.sf.jni4net.inj.INJEnv)(null)), 0);
        cshapjni.FloodResult_cs.__ctorFloodResult_cs0(this);
    }
    
    @net.sf.jni4net.attributes.ClrMethod("()V")
    private native static void __ctorFloodResult_cs0(net.sf.jni4net.inj.IClrProxy thiz);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_cur_time();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_cur_time(double cur_time);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_rain();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_rain(double rain);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_res_inflow();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_res_inflow(double res_inflow);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_res_level();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_res_level(double res_level);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_res_outflow();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_res_outflow(double res_outflow);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_res_volume();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_res_volume(double res_volume);
    
    public static system.Type typeof() {
        return cshapjni.FloodResult_cs.staticType;
    }
    
    private static void InitJNI(net.sf.jni4net.inj.INJEnv env, system.Type staticType) {
        cshapjni.FloodResult_cs.staticType = staticType;
    }
    //</generated-proxy>
}
