<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript">

	function isValidate(frm){
			
//////////이름 체크
		if(frm.name.value==''){
			console.log("이름공백이라서 펄스, frm.name.value");
			alert('이름을 입력하세요');
			frm.name.focus();
			return false;
		}
		if(frm.name.value.length<2){
			console.log("이름2자이상안넣어서 펄스, frm.name.value");
			alert("이름을 2자 이상 입력해주십시오.")
			frm.name.focus();
			return false;
		}

//////////아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입
		//아이디 빈값 체크.
		if(frm.id.value==''){
			alert('아이디를 입력하세요');
			frm.id.focus();
			return false;
		}
		//아이디 중복확인을 하지않았을때..
		if(idCheckButton==0){
			alert('아이디 중복확인을 반드시 확인해주세요.');
			frm.id.focus();
			return false;
		}
		
///////////영문/아이디 조합 정규식/////////////////////////
		// a-z 0-9 중에 4자리 부터 12자리만 허용 한다는 뜻///
		   var num = /[0-9]/g;
		   var length = /^[a-z0-9]{4,12}$/;
		   var eng = /[a-z]/g;
		   var space = /\s/;
		////end/////////////////////////////////
//////////아이디 유효성 검사//
		if(!length.test(form.id.value) || !num.test(form.id.value) || !eng.test(form.id.value) || space.test(form.id.value)==true){
		    alert("(최종확인버튼!!)  아이디는 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 입력하세요.");
		    form.id.focus();      
		    return false;
		}
		//비밀번호 빈값인지 검사//
		if(frm.pass1.value=='' || frm.pass2.value==''){
			alert('비밀번호를 입력하세요.(빈값입니다.)');
			frm.id.focus();
			return false;
		}
		//비밀번호 유효성 검사//
		if(!length.test(form.pass1.value) || !num.test(form.pass1.value) || !eng.test(form.pass1.value) || space.test(form.pass1.value)==true){
		    alert("비밀번호는 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 입력하세요.");
		    form.id.focus();      
		    return false;
		}
        //입력한 패스워드가 일치하지 않으면 둘다 지우고 처음부터 다시 입력하게 한다. 
        if(frm.pass1.value != frm.pass2.value){
            alert("입력한 패스워드가 일치하지 않습니다.");
            frm.pass1.value="";
            frm.pass2.value="";
            frm.pass1.focus();
            return false;
        }//비번검증끝.
        
	}
	
 
///아이디 조합 정규식/////////////////////////
///a-z 0-9 중에 4자리 부터 12자리만 허용 한다는 뜻///
   var num = /[0-9]/g;
   var length = /^[a-z0-9]{4,12}$/;
   var eng = /[a-z]/g;
   var space = /\s/;
////end/////////////////////////////////

//////////아이디 검증시작//////////////////////////////////////////////
//아이디 중복확인 이미지를 클릭하면!!!!
	var idCheckButton = 0;
	function id_check_person(){
		
		//아이디에 입력한 값을 id의 value값인 DOM을 통해 가져온다.
		var id = document.getElementById("id").value;

		//아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입.
		if(!length.test(id) || !num.test(id) || !eng.test(id) || space.test(id)==true){
		    alert("(중복체크버튼!!!) 아이디는 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 입력하세요.");  
		    return false;
		}
		//중복체크를 누를때 입력된 아이디가 없다면..
		if(id==''){
			//경고창을 띄우고...
			alert('아이디를 입력하세요');   
		}
		else {
            //중복확인창을 띄울때 기존 입력내용을 수정할수 없도록 
			//readonly속성을 걸어준다.
			idCheckButton = 1;

			/*
			open() : 광고나 공지사항을 게시할 팝업창을 열고싶을때 주로 사용하는 함수.
				형식] window.open("요청명?서블릿에보낼값"+값, 창의이름, 창의속성(모양, 크기, 위치 등));
				-창의이름을 지정하지 않으면 동일한 창이 여러개 띄워질수도 있다.
				-창의이름이 동일하면 여러개의 창이 하나의 창에 띄워질수도 있다.
			*/
			//입력된 아이디를 파라미터로 전달하면서 팝업창을 열어준다.
			window.open("../main/IdCheck?id="+id, "chkForm", "width=500, height=150");
		}
	} 
/////////////아이디 검증 end ////////////////////////////////////

////////주소입력은 DAUM우편번호 API 사용/////////////////////////////////
	function zipcodeFind(){     
	    new daum.Postcode({
	        oncomplete: function(data) {
	            //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력.
	            console.log(data.zonecode);
	            console.log(data.address);
	            console.log(data.sido);
	            console.log(data.sigungu);
	            //가입폼에 적용하기 이런방법도있음~ 참고하세요
// 				document.getElementById('zip1').value = data.postcode1;
// 				document.getElementById('zip1').value = data.postcode2;
// 				document.getElementById('addr1').value = data.address;
// 				document.getElementById('addr2').value = data.postcode2;
				   
				   
	            //폼값의 name으로 지정되있는 registFrm 가져온다. - document.registFrm
	            var f = document.registFrm;
	            f.zip1.value = data.zonecode;
	            f.addr1.value = data.address;
	
	            //상세주소입력하기위해 다음 텍스트로 스크롤이 자동으로
	            //넘어가기위해focus()를 준다.
	            f.addr2.focus();
	        }
	    }).open();
	} 
////////////////이메일 셀렉옵션 체인지시 설정함수./////////////////////////
function email(str) {
	if(str != "직접입력") {
		document.getElementById("email_2").value = str;
		document.getElementById("email_2").readOnly = true;
	} else {
		document.getElementById("email_2").value = "직접입력";
		document.getElementById("email_2").readOnly = false;
		document.getElementById("email_2").focus();
	}	
}

///////이메일 수신동의 체크여부 확인////////////////////////
/* checkbox와 radio는 기본적으로 value속성값을 가지고 있으므로
입력값에 대한 검증이 아니라 선택여부에 대한 검증이 이뤄져야한다.
1. 회원가입 폼에서 동의에 따라 T, F를 반환하는 함수를 만들고연
2. 디비에 동의 컬럼을 T나 F로 수정할 수 있게 만든다음
3. 합치세연
*/
function emailChk(obj) {
	var checked = obj.checked;
	if(checked){
		obj.value = "T";
	} else {
		obj.value ="F";
	}
	console.log("체크박스값이잘들어왔니? => ", obj.value);
}
/*
if(frm.open_email.checked==true){
	//체크된 항목이 있으면.
	frm.open_email.value="T";
}else {
	frm.open_email.value="F";
	/*
	1. 회원가입 폼에서 동의에 따라 T, F를 반환하는 함수를 만들고연
	2. 디비에 동의 컬럼을 T나 F로 수정할 수 있게 만든다음
	3. 합치세연
}
*/
////////////////////이메일수신동의체크검증끝/////////
</script>
 <body>
	<center>
		<div id="wrap">
		<!-- return이 빠지면 submit하면서 그냥 check()를 실행하는 것 뿐이고, -->
		<!--  return이 있어야 callback받아서 check의 결과값을 submit에 리턴해주게 됩니다. -->
		
			<%@ include file="../include/top.jsp" %>
	
			<img src="../images/member/sub_image.jpg" id="main_visual" />
	
			<div class="contents_box">
				<div class="left_contents">
					<%@ include file = "../include/member_leftmenu.jsp" %>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
						<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
					</div>
					<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
					<form action="../main/Join" name="registFrm" id="joinForm" method="post" onsubmit="return isValidate(this);">
					<table cellpadding="0" cellspacing="0" border="0" class="join_box">
						<colgroup>
							<col width="80px;" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" id="name" value="" class="join_input" /></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit002.gif" /></th>
							<td><input type="text" name="id" id="id" class="join_input" size="12" />&nbsp;<button type="button" style="border: none;" onclick="id_check_person()" name="idcheck" ><img src="../images/btn_idcheck.gif" alt="중복확인" style="cursor:hand;" /></button> &nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit003.gif" /></th>
							<td><input type="password" name="pass1" id="pass1" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit04.gif" /></th>
							<td><input type="password" name="pass2" id="pass2" value="" class="join_input" /></td>
						</tr>
						
	
						<tr>
							<th><img src="../images/join_tit06.gif" /></th>
							<td>
								<input type="text" name="tel1" id="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
								<input type="text" name="tel2" id="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
								<input type="text" name="tel3" id="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
							</td>
						</tr>
						<tr>
							<th><img src="../images/join_tit07.gif" /></th>
							<td>
								<input type="text" name="mobile1" id="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
								<input type="text" name="mobile2" id="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
								<input type="text" name="mobile3" id="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit08.gif" /></th>
							<td>
	 
		<input type="text" name="email_1" id="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
		<input type="text" name="email_2" id="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly/>
		<select name="select_email" id="select_email" onchange="email(this.value);">
			<option selected="" value="no">선택해주세요</option>
			<option value="직접입력" >직접입력</option>
			<option value="dreamwiz.com" >dreamwiz.com</option>
			<option value="empal.com" >empal.com</option>
			<option value="empas.com" >empas.com</option>
			<option value="freechal.com" >freechal.com</option>
			<option value="hanafos.com" >hanafos.com</option>
			<option value="hanmail.net" >hanmail.net</option>
			<option value="hotmail.com" >hotmail.com</option>
			<option value="intizen.com" >intizen.com</option>
			<option value="korea.com" >korea.com</option>
			<option value="kornet.net" >kornet.net</option>
			<option value="msn.co.kr" >msn.co.kr</option>
			<option value="nate.com" >nate.com</option>
			<option value="naver.com" >naver.com</option>
			<option value="netian.com" >netian.com</option>
			<option value="orgio.co.kr" >orgio.co.kr</option>
			<option value="paran.com" >paran.com</option>
			<option value="sayclub.com" >sayclub.com</option>
			<option value="yahoo.co.kr" >yahoo.co.kr</option>
			<option value="yahoo.com" >yahoo.com</option>
		</select>
		 
							<input type="checkbox" name="open_email" id="open_email" value="1" onchange="emailChk(this);">
							<span>이메일 수신동의</span></td>
						</tr>
						<tr>
							<th><img src="../images/join_tit09.gif" /></th>
							<td>
							<input type="text" name="zip1" id="zip1" value=""  class="join_input" style="width:50px;" />
							<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind()" onkeypress="" >[우편번호검색]</a>
							<br/>
							
							<input type="text" name="addr1" id="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
							<input type="text" name="addr2" id="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
							
							</td>
						</tr>
					</table>
	
					<p style="text-align:center; margin-bottom:20px"><a href="join02.jsp"> <button type="submit" style="border: none;" ><img src="../images/btn01.gif" /></button> </a>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
					</form>
				</div>
			</div>
			<%@ include file="../include/quick.jsp" %>
		</div>
		
		<%@ include file="../include/footer.jsp" %>
		</center>
 </body>
</html>
