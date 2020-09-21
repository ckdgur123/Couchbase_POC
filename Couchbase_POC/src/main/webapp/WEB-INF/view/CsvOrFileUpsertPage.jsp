<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Couchbase</title>
<link rel="stylesheet" type="text/css" href="static/css/index.css">
</head>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
function uploadFile() {
	
	var check = inputCheck();
	if(check == false){
		alert('모든 항목을 입력해주세요.');
		return;
	}

	var data = new FormData(document.getElementById('fileUpload'));
	$.ajax({
		type : "post",
		url : "fileUpload",
		enctype : "multipart/form-data",
		data : data,
		processData : false,
		contentType : false,
		error : function(xhr, status, error) {
			$('#uploadResult').val("업로드 처리 오류");
		},

		success : function(data) {
			var obj = eval(data);
			if (obj.suc == "OK") {
				if (obj.mapFlag == "1") {
					$('#uploadResult').val(obj.idThreadCheck);
				} else if (obj.mapFlag == "2") {
					$('#uploadResult').val(obj.ExtentionsCheck);
				} else if (obj.mapFlag == "3") {
					$('#uploadResult').val(obj.csvInsert);
				} else if (obj.mapFlag == "4") {
					$('#uploadResult').val(obj.jsonInsert);
				}
			} else {
				$('#uploadResult').val(obj.fileCheck);
			}

		}

	});
}

function inputCheck(){
	let inputText = $("#fileUpload input[type=text]");
	
	for(var i=0;i<inputText.length; i++){
		
		if(inputText[i].value == "" || inputText[i].value == null){
			
			return false;
		}
	}		
	return true;
}
</script>
<body>
	<div id="header">
		<a> <img src="static/image/cb_logo_bug_white_2.svg"
			alt="Couchbase Server" class="logobug">
		</a>
	</div>
	<div id=header-tab>
		<div class="menu">
			<a href="settings"> 서버 연결 및 환경 설정 </a>
		</div>
		<div class="menu">
			<a href="randomDataPage"> 랜덤 데이터 설정 </a>
		</div>
		<div class="menu">
			<a href="createBucketPage"> 버킷 생성 </a>
		</div>
		<div class="menu">
			<a href="documentManagePage"> 문서 작업 </a>
		</div>
		<div class="menu">
			<a href="CsvOrFileUpsertPage"> Csv 및 Json 파일 Upsert </a>
		</div>
	</div>



	<div class=container>
		<div class=container-div>
			<h1 style="margin-top:-25px;margin-bottom: 50px;"> Csv 및 Json 파일 Upsert </h1>
				<form id="fileUpload" name="fileUpload" enctype="multipart/form-data">
					
					<div>
						문서 아이디 :
						<input type="text" id="docId" name="docId" required="required" /> 
					</div>
					<div>
						쓰레드 개수 :
						<input type="text" name="threadCount"  required="required"
								onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
					</div>
					<div>
						파일 경로 : <input id="fileName" name="fileName" type=file
									accept=".csv, .json" required="required" >
					</div>
				</form>
			<div>
			</div>
			
			<div align="right">
				<button type="submit" class="n1qlexcute" onclick="uploadFile();">실행</button>
			</div>
			
		</div>
		
		<div class=container-div style="margin-left:200px;">
			<h1 style="margin-top:-25px;margin-bottom: 50px;"> 작업 결과 </h1>
			<textarea id="uploadResult" name="uploadResult" readonly
					placeholder="작업을 실행해주세요." style="width:500px; height:500px;">
			</textarea>
		</div>
	</div>

</body>
</html>