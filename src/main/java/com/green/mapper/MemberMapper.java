package com.green.mapper;

import com.green.vo.MemberVO;

public interface MemberMapper {
	public int login(MemberVO vo); //로그인 하기
	public int kakaologin(MemberVO vo);//카카오 로그인
	public void signup(MemberVO vo); //회원 가입
	public int idChk(MemberVO vo); // 아이디 중복체크
	public int phnChk(MemberVO vo);// 휴대폰 중복체크
	public int kakaoChk(MemberVO vo);//카카오 회원체크
	public MemberVO info(MemberVO vo); //유저 정보
	public MemberVO kakaoinfo(MemberVO vo);
	public MemberVO getMember(long user_num);
	
	public MemberVO findId(MemberVO vo); //아이디 찾기
	public MemberVO findPwd(MemberVO vo); //비밀번호 찾기
	public void updatePwd(MemberVO vo); // 비밀번호 변경
	
	public MemberVO findFrd(MemberVO vo); //친구 찾기
}
