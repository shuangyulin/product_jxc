var supplier_manage_tool = null; 
$(function () { 
	initSupplierManageTool(); //建立Supplier管理对象
	supplier_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#supplier_manage").datagrid({
		url : 'Supplier/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "supplierId",
		sortOrder : "desc",
		toolbar : "#supplier_manage_tool",
		columns : [[
			{
				field : "supplierId",
				title : "供应商id",
				width : 70,
			},
			{
				field : "supplierName",
				title : "供应商名称",
				width : 140,
			},
			{
				field : "personName",
				title : "联系人",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "address",
				title : "地址",
				width : 140,
			},
		]],
	});

	$("#supplierEditDiv").dialog({
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
				if ($("#supplierEditForm").form("validate")) {
					//验证表单 
					if(!$("#supplierEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#supplierEditForm").form({
						    url:"Supplier/" + $("#supplier_supplierId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#supplierEditForm").form("validate"))  {
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
			                        $("#supplierEditDiv").dialog("close");
			                        supplier_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#supplierEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#supplierEditDiv").dialog("close");
				$("#supplierEditForm").form("reset"); 
			},
		}],
	});
});

function initSupplierManageTool() {
	supplier_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#supplier_manage").datagrid("reload");
		},
		redo : function () {
			$("#supplier_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#supplier_manage").datagrid("options").queryParams;
			queryParams["supplierName"] = $("#supplierName").val();
			queryParams["personName"] = $("#personName").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#supplier_manage").datagrid("options").queryParams=queryParams; 
			$("#supplier_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#supplierQueryForm").form({
			    url:"Supplier/OutToExcel",
			});
			//提交表单
			$("#supplierQueryForm").submit();
		},
		remove : function () {
			var rows = $("#supplier_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var supplierIds = [];
						for (var i = 0; i < rows.length; i ++) {
							supplierIds.push(rows[i].supplierId);
						}
						$.ajax({
							type : "POST",
							url : "Supplier/deletes",
							data : {
								supplierIds : supplierIds.join(","),
							},
							beforeSend : function () {
								$("#supplier_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#supplier_manage").datagrid("loaded");
									$("#supplier_manage").datagrid("load");
									$("#supplier_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#supplier_manage").datagrid("loaded");
									$("#supplier_manage").datagrid("load");
									$("#supplier_manage").datagrid("unselectAll");
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
			var rows = $("#supplier_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Supplier/" + rows[0].supplierId +  "/update",
					type : "get",
					data : {
						//supplierId : rows[0].supplierId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (supplier, response, status) {
						$.messager.progress("close");
						if (supplier) { 
							$("#supplierEditDiv").dialog("open");
							$("#supplier_supplierId_edit").val(supplier.supplierId);
							$("#supplier_supplierId_edit").validatebox({
								required : true,
								missingMessage : "请输入供应商id",
								editable: false
							});
							$("#supplier_supplierName_edit").val(supplier.supplierName);
							$("#supplier_supplierName_edit").validatebox({
								required : true,
								missingMessage : "请输入供应商名称",
							});
							$("#supplier_personName_edit").val(supplier.personName);
							$("#supplier_personName_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#supplier_telephone_edit").val(supplier.telephone);
							$("#supplier_address_edit").val(supplier.address);
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
