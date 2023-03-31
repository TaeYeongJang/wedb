
package com.istec.m1.service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.istec.m1.utils.CommonMap;

@Service 
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = RuntimeException.class)
public class MailService {

	private static final Logger logger = LoggerFactory.getLogger(MailService.class);

	private int size;
	 
	/** 
	 * <pre> com.istec.m1.service</pre>   
	 * @Date   : 2022. 04. 19.
	 * @author : 유혜수
	 * @메소드설명 : 회원가입/이메일등록/비밀번호재설정 인증번호 이메일 전송
	 * @return :  
	 * @throws : IOException 
	 */
	public List<CommonMap> sendMail(CommonMap hashMap) {
		
	    String host = "mail.ekr.or.kr";
	    int port = 25;
	    final String username = "rims@ekr.or.kr"; 
	    final String password = "rims@Admin!";
	    
	    //6자리 난수 인증번호 생성
        String authKey = getKey(6);
        String shaAuthKey = getSHA512(authKey);
        
        String gbn = hashMap.getString("gbn");
        String sub = "";
        if("signup".equals(gbn)) 
        	sub = "회원가입";
        else if("registemail".equals(gbn))
        	sub = "이메일 등록";
        else
        	sub = "비밀번호 재설정";
       
	    String recipient = hashMap.getString("email");
	    String subject = "[RAWRIS 농촌용수종합정보시스템] " + sub + " 이메일 인증";
        String contents = "<h3>[RAWRIS 농촌용수종합정보시스템 이메일 인증]</h3><br><p>"+ sub +"을(를) 위한 인증번호 입니다.</p><br><p>아래의 6자리 숫자를 인증번호 확인란에 입력해주세요.</p><br><h2>"+ authKey +"</h2>";
	    
	    // SMTP 서버 설정 정보 세팅
	    Properties props = System.getProperties(); 
	    props.put("mail.smtp.host", host);  
	    props.put("mail.smtp.port", port);  
	    props.put("mail.smtp.auth", "false");  
	    props.put("mail.smtp.starttls.enable", "true"); 
	    
	    //Session 생성 & 발신자 smtp 서버 로그인 인증 
	    Session session = Session.getInstance(props,  new javax.mail.Authenticator() { 
	    	protected javax.mail.PasswordAuthentication getPasswordAuthentication() {  
	    		return new javax.mail.PasswordAuthentication(username, password);  
	    	}  
	    });  
	    
	    session.setDebug(true); // 디버그 모드 

	    List<CommonMap> rstList = new ArrayList<CommonMap>();
	    
	    try {
		    //MimeMessage 생성 & 메일 세팅
		    Message mimeMessage = new MimeMessage(session); 
		    mimeMessage.setFrom(new InternetAddress(username)); // 발신자
		    mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); // 수신자
		    mimeMessage.setSubject(subject); // 제목  
		    mimeMessage.setContent(contents,"text/html; charset=UTF-8");
		    
		    Transport.send(mimeMessage); // 전송
	        
		    CommonMap rst = new CommonMap();
		    rst.put("gbn", gbn);
    		rst.put("email", recipient);
    		//rst.put("authnum_org", authKey);
    		rst.put("authnum", shaAuthKey);
    		
    		rstList.add(rst);
	    	
	    } catch(MessagingException e) {
	    	e.printStackTrace();
	    }
		
	    return rstList;
	}
	
	//인증키 생성
    private String getKey(int size) {
        this.size = size;
        return getAuthCode();
    }

    //인증코드 난수 발생
    private String getAuthCode() {
        Random random = new Random();
        StringBuffer buffer = new StringBuffer();
        int num = 0;

        while(buffer.length() < size) {
            num = random.nextInt(10);
            buffer.append(num);
        }

        return buffer.toString();
    }
    
    // 인증번호 암호화
    private String getSHA512(String input){
		String toReturn = null;
		
		try {
		    MessageDigest digest = MessageDigest.getInstance("SHA-512");
		    digest.reset();
		    digest.update(input.getBytes("utf8"));
		    toReturn = String.format("%0128x", new BigInteger(1, digest.digest()));
		} catch (Exception e) {
		    e.printStackTrace();
		}
		
		return toReturn;
     }
	
}
