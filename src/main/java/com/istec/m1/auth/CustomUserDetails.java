package com.istec.m1.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.istec.m1.utils.CommonMap;
 
public class CustomUserDetails implements UserDetails {
 
    private static final long serialVersionUID = -4450269958885980297L;
    
    private String user_id;                /* 사용자아이디             */
    private int    user_level;             /* 사용자레벨               */
    private int    user_role;              /* 사용자역할               */
    private String char_user_role;           /* 사용자역할(문자)         */
    private String user_name;              /* 사용자이름               */
    private String user_password;              /* 사용자비밀번호           */
    private String user_email;             /* 사용자전자메일           */ 
    private String num_office;       /* 사용자사무실전화번호     */
    private String num_cellular;     /* 휴대전화번호             */ 
    private String user_ekr_yn;             /* 사용자농어촌공사여부     */ 
    private String user_sms_yn;             /* 사용자SMS수신여부        */
    private String user_com_yn;             /* 사용자공용여부           */ 
    private int    buseo_level;        /* 사용자부서레벨(1:본사 , 2:본부 , 3: 지사 , 4: 지소)*/
    private String level_buseo_code;         /* 사용자부서코드(검색용)   */
    private String orgin_buseo_code;       /* 사용자부서코드(부서코드원문)*/
    private String bf_login;					/*최종 접속 시간*/
    private String job_status;					/*최종 접속 시간*/
    private String adm_code;					/*지지체용(주소코드)*/
    
    
    private CommonMap userinfo;
    
    public CustomUserDetails(String user_name, String user_password){
        this.user_name     = user_name;
        this.user_password = user_password;
    }
      
    public CustomUserDetails(CommonMap userinfo){
    	this.userinfo         = userinfo;
    	this.user_id          = (String)userinfo.get("user_id");
    	this.user_level       = Integer.parseInt(""+userinfo.get("user_level")); 
    	this.user_role        = Integer.parseInt(""+userinfo.get("user_role"));
    	this.char_user_role   = (String)userinfo.get("char_user_role");
    	this.user_name        = (String)userinfo.get("user_name"); 
    	this.user_email       = (String)userinfo.get("user_email");
    	this.num_office       = (String)userinfo.get("num_office");
    	this.num_cellular		= (String)userinfo.get("num_cellular"); 
    	this.user_ekr_yn		= (String)userinfo.get("user_ekr_yn");
    	this.user_sms_yn		= (String)userinfo.get("user_sms_yn");
    	this.user_com_yn		= (String)userinfo.get("user_com_yn"); 
    	this.buseo_level		= Integer.parseInt(""+userinfo.get("buseo_level")); 
    	this.level_buseo_code	= (String)userinfo.get("level_buseo_code"); 
    	this.orgin_buseo_code	= (String)userinfo.get("orgin_buseo_code"); 
    	this.bf_login			= (String)userinfo.get("bf_login");
    	this.job_status			= (String)userinfo.get("job_status");
    	this.adm_code			= (String)userinfo.get("adm_code");
    	
    	if(userinfo.get("user_password") != null){
    		this.user_password    = (String)userinfo.get("user_password"); 
    	} 
    }
     
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();  
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        
        int roll = Integer.parseInt((String)this.userinfo.get("user_role"));
        if(roll == 0){
        	authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN")); 
        } 
        
        return authorities;
    }

    public int getUserRoll() {
    	int userRoll = 0;
    	if(userinfo != null)
    		userRoll = Integer.parseInt((String)this.userinfo.get("char_user_role"));
        return userRoll;
    }
     
	public String getUser_id() { return user_id; } 
	public int getUser_level() { return user_level; } 
	public int getUser_role() { return user_role; } 
	public String getChar_user_role() { return char_user_role; } 
	public String getUser_name() { return user_name; } 
	public String getUser_password() { return user_password; } 
	public String getUser_email() { return user_email; } 
	public String getNum_office() { return num_office; } 
	public String getNum_cellular() { return num_cellular; } 
	public String getUser_ekr_yn() { return user_ekr_yn; } 
	public String getUser_sms_yn() { return user_sms_yn; } 
	public String getUser_com_yn() { return user_com_yn; } 
	public int getBuseo_level() { return buseo_level; } 
	public String getLevel_buseo_code() { return level_buseo_code; } 
	public String getOrgin_buseo_code() { return orgin_buseo_code; }
	public String getBf_login() { return bf_login; }
	public String getJob_status() { return job_status; }
	public String getAdm_code() { return adm_code; }
	
	
	@Override
	public String getPassword() { return user_password; } 
	
	@Override
	public String getUsername() { return user_name; } 
	
	public CommonMap getUserinfo() {
		return userinfo;
	}
	@Override
    public boolean isAccountNonExpired() {
        return true;
    }
  
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
  
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
  
    @Override
    public boolean isEnabled() { 
        return true;
    } 
        
}
