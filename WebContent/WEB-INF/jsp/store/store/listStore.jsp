<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/store/listStore.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"STORE_ID",
           	sortorder:"asc",
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "storeId",hidden : true,key : true,label:"店铺ID",index : "STORE_ID"},				
				{name : "storeName",label:"店铺名称",index : "STORE_NAME"},				
				{name : "brandName",label:"所属品牌",index : "BRAND_ID"},				
				{name : "storeAddress",label:"店铺地址",index : "STORE_ADDRESS"},				
				{name : "workTimeBegin",label:"营业时间起",index : "WORK_TIME_BEGIN",
					/* formatter:'date',
					formatoptions:{srcformat: 'Y-m-d H:i:s', newformat: 'H:i:s'}, */
				},				
				{name : "workTimeEnd",label:"营业时间起",index : "WORK_TIME_END"},				
				{name : "storeOwnerName",label:"店长姓名",index : "STORE_OWNER_NAME"},				
				{name : "storeOwnerTel",label:"店长电话",index : "STORE_OWNER_TEL"},				
				{name : "proInvoiceFlag",label:"是否可以提供发票",index : "PRO_INVOICE_FLAG"
					,formatter:GridColModelForMatter.yesno},				
				{name : "remark",label:"备注",index : "REMARK"},				
				{name : "operateDate",label:"运营开始时间",index : "OPERATE_DATE"},				
				{name : "settlementMethod",label:"结算方式",index : "SETTLEMENT_METHOD"
					,formatter:GridColModelForMatter.settlementMethod},				
				{name : "storeTel",label:"店铺联系电话",index : "STORE_TEL"},				
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
	new biz.datepicker({
  			id : "#startDate",
  			maxDate:'#F{$dp.$D(\'endDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
  	    
  	    new biz.datepicker({
  			id : "#endDate",
  			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
    });

 

    //新增的弹出框
	var add_iframe_dialog;
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
		var url="<m:url value='/store/toAddStore.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.9,
			height: $(window).height()*0.8,
			title: "店铺增加"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
  	
    function edit(){
		var key = ICSS.utils.getSelectRowData("storeId");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/store/toEditStore.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.8,
			height: $(window).height()*0.8,
			title: "店铺编辑"
		});
  		edit_iframe_dialog.open();
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
    }
    
    function show(){
    	var key = ICSS.utils.getSelectRowData("storeId");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/store/toShowStore.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.8,
			height: $(window).height()*0.8,
				title: "店铺详情"
		});
  		show_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	show_iframe_dialog.close();
    }
    /**
    * 获取查询条件值
    */
    function getQueryCondition(){
       var obj = {};
		jQuery.each($("#queryForm").serializeArray(),function(i,o){
        	if(o.value){
        		obj[o.name] = o.value;
        	}
        });
		return obj;
    }
    //查询Grid数据
    function doSearch(isStayCurrentPage){
    	if(!isStayCurrentPage)gridObj.setGridParam({"page":"1"});
    	gridObj.trigger('reloadGrid');
    }
    //重置查询表单
    function resetForm(formId){
		document.getElementById(formId).reset();
	}
    
    //删除
    function batchDelete(){
    	var ids = ICSS.utils.getSelectRowData("storeId");
    	if(ids==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}else{
    		new biz.alert({type:"confirm",message:I18N.msg_del_confirm,title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: "<m:url value='/store/deleteStore.do'/>?key="+ids,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearch();
    						showInfo("删除成功",3000);
        				}
        			});
    			}
    		}}) ;   
    	}
    }
 	// 打开产品资源界面
    function linkStoreProduct(){
   		var key = ICSS.utils.getSelectRowData("storeId");
   		if (key.indexOf(",") > -1 || key == "") {
   			showMessage("请选择一条数据");
   			return;
   		}
   		var url = baseUrl + '/store/toListStoreProduct.do?key=' + key;
   		productList_iframe_dialog = new biz.dialog(
   				{
   					id : $('<div id="sublist_window_iframe"></div>')
   							.html(
   									'<iframe id="iframeSublist" name="iframeSublist" src="'
   											+ url
   											+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
   					modal : true,
   					width : $(window).width()*0.8,
   					height : $(window).height()*0.8,
   					title : "店铺产品管理"
   				});
   		productList_iframe_dialog.open();
    }
    </script>
</head>
<body style="height:100%;">

	<div class="main  choice_box">
		<form id="queryForm"><!-- 查询区 表单 -->
			 <div class="search border-bottom">
				<ul>
				<li>
					<span>关键字:</span>
					<input type="text" name="storeName" id="storeName" class="search_choose" placeholder="店铺名称">
					</li>
				<li><input type="text" name="storeOwnerName" id="storeOwnerName" class="search_choose" placeholder="店长姓名">
				</li>
				<li>	<input type="text" name="storeAddress" id="storeAddress" class="search_choose" placeholder="店铺地址">
				</li>
				<li>
					<input type="reset" class="reset_btn" onclick="resetForm('queryForm')" value="重置">
					<input type="button" class="search_btn mr22 " onclick="doSearch();" value="查询"></li>
				</ul>
		   </div>
	    </form>
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能按钮 div-->
					<ul>
						<li><a title="<m:message code="button.add"/>" href="javascript:;" onclick="add();"> <i class="icon_bg icon_add"> </i> <span><m:message
							code="button.add" /></span>
						</a></li>
						<li><a title="<m:message code="button.edit"/>" href="javascript:;" onclick="edit();"><i class="icon_bg icon_edit"></i> <span><m:message
							code="button.edit" /></span> </a></li>
						<li><a title="<m:message code="button.delete"/>" href="javascript:;" onclick="batchDelete();"> <i class="icon_bg icon_del"></i> <span><m:message
							code="button.delete" /></span>
						</a></li>
						<li><a title="店铺产品关联" href="javascript:;" onclick="linkStoreProduct();"> <i class="back_icon resources_icon"></i> 
							<span>店铺产品关联</span>
						</a></li>
						<li><a title="<m:message code="button.view"/>" href="javascript:" onclick="show();">
							<i class="icon_bg icon_ckxq"></i> <span><m:message code="button.view" /></span>
						</a></li>
					</ul>
				</div>
	
				<!--功能按钮end-->
				<div class="listtable_box">
					<!--此处放表格-->
				<table  id="remote_rowed" ></table>
				<div  id="remote_prowed"></div>		
				</div>
		</div>
	</div>
</body>
</html>
