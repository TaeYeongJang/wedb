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
public class FloodReservoirSpillWeir_cs extends system.Object {
    
    //<generated-proxy>
    private static system.Type staticType;
    
    protected FloodReservoirSpillWeir_cs(net.sf.jni4net.inj.INJEnv __env, long __handle) {
            super(__env, __handle);
    }
    
    @net.sf.jni4net.attributes.ClrConstructor("()V")
    public FloodReservoirSpillWeir_cs() {
            super(((net.sf.jni4net.inj.INJEnv)(null)), 0);
        cshapjni.FloodReservoirSpillWeir_cs.__ctorFloodReservoirSpillWeir_cs0(this);
    }
    
    @net.sf.jni4net.attributes.ClrMethod("()V")
    private native static void __ctorFloodReservoirSpillWeir_cs0(net.sf.jni4net.inj.IClrProxy thiz);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_ap_height();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_ap_height(double ap_height);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_hd();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_hd(double hd);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_height();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_height(double height);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_length();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_length(double length);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_sill_level();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_sill_level(double sill_level);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double get_slope();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void set_slope(double slope);
    
    public static system.Type typeof() {
        return cshapjni.FloodReservoirSpillWeir_cs.staticType;
    }
    
    private static void InitJNI(net.sf.jni4net.inj.INJEnv env, system.Type staticType) {
        cshapjni.FloodReservoirSpillWeir_cs.staticType = staticType;
    }
    //</generated-proxy>
}
