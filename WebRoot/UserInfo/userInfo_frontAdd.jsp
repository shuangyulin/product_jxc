<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>会员信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>UserInfo/frontlist">会员信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#userInfoAdd" aria-controls="userInfoAdd" role="tab" data-toggle="tab">添加会员信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="userInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="userInfoAdd"> 
				      	<form class="form-horizontal" name="userInfoAddForm" id="userInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="userInfo_user_name" class="col-md-2 text-right">用户名:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="userInfo_user_name" name="userInfo.user_name" class="form-control" placeholder="请输入用户名">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="userInfo_password" class="col-md-2 text-right">登录密码:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="userInfo_password" name="userInfo.password" class="form-control" placeholder="请输入登录密码">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userInfo_name" class="col-md-2 text-right">会员全称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="userInfo_name" name="userInfo.name" class="form-control" placeholder="请输入会员全称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userInfo_legalMan" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="userInfo_legalMan" name="userInfo.legalMan" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userInfo_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="userInfo_telephone" name="userInfo.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="userInfo_address" class="col-md-2 text-right">地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="userInfo_address" name="userInfo.address" class="form-control" placeholder="请输入地址">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxUserInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#userInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加会员信息信息
	function ajaxUserInfoAdd() { 
		//提交之前先验证表单
		$("#userInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#userInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserInfo/add",
			dataType : "json" , 
			data: new FormData($("#userInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#userInfoAddForm").find("input").val("");
					$("#userInfoAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证会员信息添加表单字段
	$('#userInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"userInfo.user_name": {
				validators: {
					notEmpty: {
						message: "用户名不能为空",
					}
				}
			},
			"userInfo.name": {
				validators: {
					notEmpty: {
						message: "会员全称不能为空",
					}
				}
			},
			"userInfo.legalMan": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
