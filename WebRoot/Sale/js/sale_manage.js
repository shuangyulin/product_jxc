var sale_manage_tool = null; 
$(function () { 
	initSaleManageTool(); //建立Sale管理对象
	sale_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#sale_manage").datagrid({
		url : 'Sale/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "saleId",
		sortOrder : "desc",
		toolbar : "#sale_manage_tool",
		columns : [[
			{
				field : "saleId",
				title : "销售id",
				width : 70,
			},
			{
				field : "productObj",
				title : "销售商品",
				width : 140,
			},
			{
				field : "userObj",
				title : "销售客户",
				width : 140,
			},
			{
				field : "price",
				title : "销售单价",
				width : 70,
			},
			{
				field : "count",
				title : "销售数量",
				width : 70,
			},
			{
				field : "saleDate",
				title : "销售日期",
				width : 140,
			},
			{
				field : "employeeObj",
				title : "销售员工",
				width : 140,
			},
		]],
	});

	$("#saleEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#saleEditForm").form("validate")) {
					//验证表单 
					if(!$("#saleEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#saleEditForm").form({
						    url:"Sale/" + $("#sale_saleId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#saleEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#saleEditDiv").dialog("close");
			                        sale_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#saleEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#saleEditDiv").dialog("close");
				$("#saleEditForm").form("reset"); 
			},
		}],
	});
});

function initSaleManageTool() {
	sale_manage_tool = {
		init: function() {
			$.ajax({
				url : "Product/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#productObj_productNo_query").combobox({ 
					    valueField:"productNo",
					    textField:"productName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{productNo:"",productName:"不限制"});
					$("#productObj_productNo_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Employee/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#employeeObj_employeeNo_query").combobox({ 
					    valueField:"employeeNo",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{employeeNo:"",name:"不限制"});
					$("#employeeObj_employeeNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#sale_manage").datagrid("reload");
		},
		redo : function () {
			$("#sale_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#sale_manage").datagrid("options").queryParams;
			queryParams["productObj.productNo"] = $("#productObj_productNo_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["saleDate"] = $("#saleDate").datebox("getValue"); 
			queryParams["employeeObj.employeeNo"] = $("#employeeObj_employeeNo_query").combobox("getValue");
			$("#sale_manage").datagrid("options").queryParams=queryParams; 
			$("#sale_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#saleQueryForm").form({
			    url:"Sale/OutToExcel",
			});
			//提交表单
			$("#saleQueryForm").submit();
		},
		remove : function () {
			var rows = $("#sale_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var saleIds = [];
						for (var i = 0; i < rows.length; i ++) {
							saleIds.push(rows[i].saleId);
						}
						$.ajax({
							type : "POST",
							url : "Sale/deletes",
							data : {
								saleIds : saleIds.join(","),
							},
							beforeSend : function () {
								$("#sale_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#sale_manage").datagrid("loaded");
									$("#sale_manage").datagrid("load");
									$("#sale_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#sale_manage").datagrid("loaded");
									$("#sale_manage").datagrid("load");
									$("#sale_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#sale_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Sale/" + rows[0].saleId +  "/update",
					type : "get",
					data : {
						//saleId : rows[0].saleId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (sale, response, status) {
						$.messager.progress("close");
						if (sale) { 
							$("#saleEditDiv").dialog("open");
							$("#sale_saleId_edit").val(sale.saleId);
							$("#sale_saleId_edit").validatebox({
								required : true,
								missingMessage : "请输入销售id",
								editable: false
							});
							$("#sale_productObj_productNo_edit").combobox({
								url:"Product/listAll",
							    valueField:"productNo",
							    textField:"productName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#sale_productObj_productNo_edit").combobox("select", sale.productObjPri);
									//var data = $("#sale_productObj_productNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#sale_productObj_productNo_edit").combobox("select", data[0].productNo);
						            //}
								}
							});
							$("#sale_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#sale_userObj_user_name_edit").combobox("select", sale.userObjPri);
									//var data = $("#sale_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#sale_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#sale_price_edit").val(sale.price);
							$("#sale_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入销售单价",
								invalidMessage : "销售单价输入不对",
							});
							$("#sale_count_edit").val(sale.count);
							$("#sale_count_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入销售数量",
								invalidMessage : "销售数量输入不对",
							});
							$("#sale_saleDate_edit").datebox({
								value: sale.saleDate,
							    required: true,
							    showSeconds: true,
							});
							$("#sale_employeeObj_employeeNo_edit").combobox({
								url:"Employee/listAll",
							    valueField:"employeeNo",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#sale_employeeObj_employeeNo_edit").combobox("select", sale.employeeObjPri);
									//var data = $("#sale_employeeObj_employeeNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#sale_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						            //}
								}
							});
							$("#sale_memo_edit").val(sale.memo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
