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
public class WreqPaddyOutput_cs extends system.Object {
    
    //<generated-proxy>
    private static system.Type staticType;
    
    protected WreqPaddyOutput_cs(net.sf.jni4net.inj.INJEnv __env, long __handle) {
            super(__env, __handle);
    }
    
    @net.sf.jni4net.attributes.ClrConstructor("()V")
    public WreqPaddyOutput_cs() {
            super(((net.sf.jni4net.inj.INJEnv)(null)), 0);
        cshapjni.WreqPaddyOutput_cs.__ctorWreqPaddyOutput_cs0(this);
    }
    
    @net.sf.jni4net.attributes.ClrMethod("()V")
    private native static void __ctorWreqPaddyOutput_cs0(net.sf.jni4net.inj.IClrProxy thiz);
    
    @net.sf.jni4net.attributes.ClrMethod("()S")
    public native short getYear();
    
    @net.sf.jni4net.attributes.ClrMethod("(S)V")
    public native void setYear(short year);
    
    @net.sf.jni4net.attributes.ClrMethod("()B")
    public native byte getMonth();
    
    @net.sf.jni4net.attributes.ClrMethod("(B)V")
    public native void setMonth(byte month);
    
    @net.sf.jni4net.attributes.ClrMethod("()B")
    public native byte getDay();
    
    @net.sf.jni4net.attributes.ClrMethod("(B)V")
    public native void setDay(byte day);
    
    @net.sf.jni4net.attributes.ClrMethod("()D")
    public native double getRainfall();
    
    @net.sf.jni4net.attributes.ClrMethod("(D)V")
    public native void setRainfall(double rainfall);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getETActualMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setETActualMm(double[] eTActualMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getEffRainMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setEffRainMm(double[] effRainMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getDepthMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setDepthMm(double[] depthMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getUseReqMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setUseReqMm(double[] useReqMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getNetReqMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setNetReqMm(double[] netReqMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getGrsReqMm();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setGrsReqMm(double[] grsReqMm);
    
    @net.sf.jni4net.attributes.ClrMethod("()[D")
    public native double[] getWreqCms();
    
    @net.sf.jni4net.attributes.ClrMethod("([D)V")
    public native void setWreqCms(double[] wreqCms);
    
    @net.sf.jni4net.attributes.ClrMethod("()LSystem/DateTime;")
    public native system.DateTime getDate();
    
    @net.sf.jni4net.attributes.ClrMethod("(LSystem/DateTime;)V")
    public native void setDate(system.DateTime date);
    
    public static system.Type typeof() {
        return cshapjni.WreqPaddyOutput_cs.staticType;
    }
    
    private static void InitJNI(net.sf.jni4net.inj.INJEnv env, system.Type staticType) {
        cshapjni.WreqPaddyOutput_cs.staticType = staticType;
    }
    //</generated-proxy>
}