<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Couchbase</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

</head>
<script>

	function setCompaction() {

		var check = inputCheck();
		if (check == false) {
			alert('모든 항목을 입력해주세요.');
			return;
		}

		var data = jQuery("#autoCompactionForm").serializeArray();

		$.ajax({
		    contentType : "application/x-www-form-urlencoded; charset=utf-8",
			type : "post",
			url : "setCompactions",
			data : data,
			error : function(xhr, status, error) {
				alert(data);
			},
			success : function(data) {
				alert(data);
			}
		});
	}

	function inputCheck() {
		let inputText = $("#autoCompactionForm input");

		for (var i = 0; i < inputText.length; i++) {

			if (inputText[i].value == "" || inputText[i].value == null) {
				if(inputText[i].disabled){
					continue;
				}
				return false;
			}
		}
		return true;
	}
	
	function compactionTimeCheck(){
		
		if(document.getElementById("timeIntervalCheck").checked==false)
			$("input#timeGroup").attr("disabled", true);
		else
			$("input#timeGroup").removeAttr("disabled");
	}


</script>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- header.jsp -->
	<c:import url="/WEB-INF/view/header.jsp">
	</c:import>
<form id="autoCompactionForm" name="autoCompactionForm" style=display:flex;>
	<div class="container">
		
			<div class="container-div" style=margin-left:20%;>
				<h1>자동 압축</h1><br><br>
				<div>
					<h4 style="margin-top: -15px;">- 데이터베이스 조각화 </h4>
					<div>
						<input type="checkbox" name="fragmentationCheckDatabasePer" value="true" style=margin-top:10px;  />
						<input type="text" name="fragmentationPercentDatabase" class=doc style=width:100px;/>%
					</div>
					<div>
						<input type="checkbox" name="fragmentationCheckDatabaseMB" value="true" style=margin-top:10px;/>
						<input type="text" name="fragmentationMBDatabase" class=doc style=width:100px;/>MB
					</div>
					
					<h4 style="margin-top: -15px;">- 뷰 조각화 </h4>
					<div>
						<input type="checkbox" name="fragmentationCheckViewPer" value="true" style=margin-top:10px; />
						<input type="text" name="fragmentationPercentView"  class=doc style=width:100px;/>%
					</div>
					<div>
						<input type="checkbox" name="fragmentationCheckViewMB" value="true" style=margin-top:10px; />
						<input type="text" name="fragmentationMBView"  class=doc style=width:100px;/>MB
					</div>
				</div>
			</div>
		
			<div class="container-div" style=margin-left:-10%;>
					<h4 style="margin-top: 50px;">- 압축 실행시간 간격 </h4>
					<div>
						<input type="checkbox" name="timeIntervalCheck" id=timeIntervalCheck value="true" style=margin-top:10px; onchange=compactionTimeCheck() />
						<input type='hidden' name="timeIntervalCheck" value='false'>
						압축 실행 간격 설정
					</div>
					<div>
						# Start Time
						<input type="text" name="compactionFromHour" class=doc style=width:100px; placeholder=HH id=timeGroup disabled />:
						<input type="text" name="compactionFromMinute" class=doc style=width:100px; placeholder=MM  id=timeGroup disabled />
					</div>
					<div>
						# End Time
						<input type="text" name="compactionToHour" class=doc style=width:100px; placeholder=HH id=timeGroup disabled />:
						<input type="text" name="compactionToMinute" class=doc style=width:100px; placeholder=MM id=timeGroup disabled />
					</div>
					<div>
						<input type="checkbox" name="abortCompaction" id=timeGroup value="true" disabled />
						<input type='hidden' name="abortCompaction" value='false'>
						지정된 시간 초과 시 압축 중단
					</div>
					<div>
						<input type="checkbox" name="compactParallel" value="true"  />
						<input type='hidden' name="compactParallel" value='false'>
						버킷과 뷰, 인덱스를 병렬로 압축
					</div>
					<div>
						<h4>- 메타데이터의 삭제 빈도  [0.04(1시간)~60(60일)]</h4>
						<input type="text" name="purgeInterval" class=doc style=width:100px; placeholder=3 />days
						
					</div>
					
					<div align="right">
					<button type="button" class="n1qlexcute" onclick="setCompaction();">실행</button>
				</div>
			</div>
	</div>
</form>

</body>
</html>