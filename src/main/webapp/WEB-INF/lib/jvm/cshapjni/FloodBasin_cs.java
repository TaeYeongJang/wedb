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
public class FloodBasin_cs extends system.Object {
    
    //<generated-proxy>
    private static system.Type staticType;
    
    protected FloodBasin_cs(net.sf.jni4net.inj.INJEnv __env, long __handle) {
            super(__env, __handle);
    }
    
    @net.sf.jni4net.attributes.ClrConstructor("()V")
    public FloodBasin_cs() {
            super(((net.sf.jni4net.inj.INJEnv)(null)), 0);
        cshapjni.FloodBasin_cs.__ctorFloodBasin_cs0(this);
    }
    
    @net.sf.jni4net.attributes.ClrMethod("()V")
    private native static void __ctorFloodBasin_cs0(net.sf.jni4net.inj.IClrProxy thiz);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_area();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_area(double area);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_cn();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_cn(double cn);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_k();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_k(double k);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_tc();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_tc(double tc);
    
    public static system.Type typeof() {
        return cshapjni.FloodBasin_cs.staticType;
    }
    
    private static void InitJNI(net.sf.jni4net.inj.INJEnv env, system.Type staticType) {
        cshapjni.FloodBasin_cs.staticType = staticType;
    }
    //</generated-proxy>
}
