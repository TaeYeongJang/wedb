@echo off
if not exist target mkdir target
if not exist target\classes mkdir target\classes


echo compile classes
javac -nowarn -d target\classes -sourcepath jvm -cp "d:\kjn\eclipse\workspace\spring_restful_2nd\src\main\webapp\web-inf\lib\jni4net\lib\jni4net.j-0.8.8.0.jar"; "jvm\cshapjni\ReservoirWaterRateForecastInput_cs.java" "jvm\cshapjni\FloodReservoirSpillGate_cs.java" "jvm\cshapjni\ReservoirWaterRateForecastOutput_cs.java" "jvm\cshapjni\MeteoDailyData_cs.java" "jvm\cshapjni\FloodReservoirWeir_cs.java" "jvm\cshapjni\BasinInfowOutput_cs.java" "jvm\cshapjni\BasinInfowInput_cs.java" "jvm\cshapjni\FloodResult_cs.java" "jvm\cshapjni\FloodReservoir_cs.java" "jvm\cshapjni\FloodReservoirSpillWeir_cs.java" "jvm\cshapjni\WreqPaddyOutput_cs.java" "jvm\cshapjni\FloodBasin_cs.java" "jvm\cshapjni\WreqPaddyInput_cs.java" "jvm\cshapjni\Cshap_Jni.java" "jvm\cshapjni\StationInput_cs.java" 
IF %ERRORLEVEL% NEQ 0 goto end


echo CshapJni.j4n.jar 
jar cvf CshapJni.j4n.jar  -C target\classes "cshapjni\ReservoirWaterRateForecastInput_cs.class"  -C target\classes "cshapjni\FloodReservoirSpillGate_cs.class"  -C target\classes "cshapjni\ReservoirWaterRateForecastOutput_cs.class"  -C target\classes "cshapjni\MeteoDailyData_cs.class"  -C target\classes "cshapjni\FloodReservoirWeir_cs.class"  -C target\classes "cshapjni\BasinInfowOutput_cs.class"  -C target\classes "cshapjni\BasinInfowInput_cs.class"  -C target\classes "cshapjni\FloodResult_cs.class"  -C target\classes "cshapjni\FloodReservoir_cs.class"  -C target\classes "cshapjni\FloodReservoirSpillWeir_cs.class"  -C target\classes "cshapjni\WreqPaddyOutput_cs.class"  -C target\classes "cshapjni\FloodBasin_cs.class"  -C target\classes "cshapjni\WreqPaddyInput_cs.class"  -C target\classes "cshapjni\Cshap_Jni.class"  -C target\classes "cshapjni\StationInput_cs.class"  > nul 
IF %ERRORLEVEL% NEQ 0 goto end


echo CshapJni.j4n.dll 
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc /nologo /warn:0 /t:library /out:CshapJni.j4n.dll /recurse:clr\*.cs  /reference:"D:\kjn\eclipse\workspace\Spring_RestFul_2nd\src\main\webapp\WEB-INF\lib\CshapJni.dll" /reference:"D:\kjn\eclipse\workspace\Spring_RestFul_2nd\src\main\webapp\WEB-INF\lib\jni4net\lib\jni4net.n-0.8.8.0.dll"
IF %ERRORLEVEL% NEQ 0 goto end


:end
