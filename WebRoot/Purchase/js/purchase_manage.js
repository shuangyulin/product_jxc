var purchase_manage_tool = null; 
$(function () { 
	initPurchaseManageTool(); //建立Purchase管理对象
	purchase_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#purchase_manage").datagrid({
		url : 'Purchase/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "purchaseId",
		sortOrder : "desc",
		toolbar : "#purchase_manage_tool",
		columns : [[
			{
				field : "purchaseId",
				title : "进货id",
				width : 70,
			},
			{
				field : "productObj",
				title : "进货商品",
				width : 140,
			},
			{
				field : "supplierObj",
				title : "供应商",
				width : 140,
			},
			{
				field : "price",
				title : "进货单价",
				width : 70,
			},
			{
				field : "count",
				title : "进货数量",
				width : 70,
			},
			{
				field : "purchaseDate",
				title : "进货日期",
				width : 140,
			},
			{
				field : "employeeObj",
				title : "进货员工",
				width : 140,
			},
		]],
	});

	$("#purchaseEditDiv").dialog({
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
				if ($("#purchaseEditForm").form("validate")) {
					//验证表单 
					if(!$("#purchaseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#purchaseEditForm").form({
						    url:"Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#purchaseEditForm").form("validate"))  {
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
			                        $("#purchaseEditDiv").dialog("close");
			                        purchase_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#purchaseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#purchaseEditDiv").dialog("close");
				$("#purchaseEditForm").form("reset"); 
			},
		}],
	});
});

function initPurchaseManageTool() {
	purchase_manage_tool = {
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
				url : "Supplier/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#supplierObj_supplierId_query").combobox({ 
					    valueField:"supplierId",
					    textField:"supplierName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{supplierId:0,supplierName:"不限制"});
					$("#supplierObj_supplierId_query").combobox("loadData",data); 
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
			$("#purchase_manage").datagrid("reload");
		},
		redo : function () {
			$("#purchase_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#purchase_manage").datagrid("options").queryParams;
			queryParams["productObj.productNo"] = $("#productObj_productNo_query").combobox("getValue");
			queryParams["supplierObj.supplierId"] = $("#supplierObj_supplierId_query").combobox("getValue");
			queryParams["purchaseDate"] = $("#purchaseDate").datebox("getValue"); 
			queryParams["employeeObj.employeeNo"] = $("#employeeObj_employeeNo_query").combobox("getValue");
			$("#purchase_manage").datagrid("options").queryParams=queryParams; 
			$("#purchase_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#purchaseQueryForm").form({
			    url:"Purchase/OutToExcel",
			});
			//提交表单
			$("#purchaseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#purchase_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var purchaseIds = [];
						for (var i = 0; i < rows.length; i ++) {
							purchaseIds.push(rows[i].purchaseId);
						}
						$.ajax({
							type : "POST",
							url : "Purchase/deletes",
							data : {
								purchaseIds : purchaseIds.join(","),
							},
							beforeSend : function () {
								$("#purchase_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#purchase_manage").datagrid("loaded");
									$("#purchase_manage").datagrid("load");
									$("#purchase_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#purchase_manage").datagrid("loaded");
									$("#purchase_manage").datagrid("load");
									$("#purchase_manage").datagrid("unselectAll");
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
			var rows = $("#purchase_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Purchase/" + rows[0].purchaseId +  "/update",
					type : "get",
					data : {
						//purchaseId : rows[0].purchaseId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (purchase, response, status) {
						$.messager.progress("close");
						if (purchase) { 
							$("#purchaseEditDiv").dialog("open");
							$("#purchase_purchaseId_edit").val(purchase.purchaseId);
							$("#purchase_purchaseId_edit").validatebox({
								required : true,
								missingMessage : "请输入进货id",
								editable: false
							});
							$("#purchase_productObj_productNo_edit").combobox({
								url:"Product/listAll",
							    valueField:"productNo",
							    textField:"productName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#purchase_productObj_productNo_edit").combobox("select", purchase.productObjPri);
									//var data = $("#purchase_productObj_productNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#purchase_productObj_productNo_edit").combobox("select", data[0].productNo);
						            //}
								}
							});
							$("#purchase_supplierObj_supplierId_edit").combobox({
								url:"Supplier/listAll",
							    valueField:"supplierId",
							    textField:"supplierName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#purchase_supplierObj_supplierId_edit").combobox("select", purchase.supplierObjPri);
									//var data = $("#purchase_supplierObj_supplierId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#purchase_supplierObj_supplierId_edit").combobox("select", data[0].supplierId);
						            //}
								}
							});
							$("#purchase_price_edit").val(purchase.price);
							$("#purchase_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入进货单价",
								invalidMessage : "进货单价输入不对",
							});
							$("#purchase_count_edit").val(purchase.count);
							$("#purchase_count_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入进货数量",
								invalidMessage : "进货数量输入不对",
							});
							$("#purchase_purchaseDate_edit").datebox({
								value: purchase.purchaseDate,
							    required: true,
							    showSeconds: true,
							});
							$("#purchase_employeeObj_employeeNo_edit").combobox({
								url:"Employee/listAll",
							    valueField:"employeeNo",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#purchase_employeeObj_employeeNo_edit").combobox("select", purchase.employeeObjPri);
									//var data = $("#purchase_employeeObj_employeeNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#purchase_employeeObj_employeeNo_edit").combobox("select", data[0].employeeNo);
						            //}
								}
							});
							$("#purchase_memo_edit").val(purchase.memo);
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
