<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
//离开页面的恢复导航栏方法
function checkLeave(){
	var _iframe = window.parent;
	_iframe.$(".inlineBlock").each(function(){this.className='hidden'})
}
	$(function(){
		//进入页面的展开导航栏搜索方法
		var _iframe = window.parent;
		_iframe.$(".hidden").each(function(){this.className='inlineBlock'})
		
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/staticAnalysis/bidAnalysis.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"id",
           	sortorder:"asc",
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
   		  	colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},				
				{name : "storeName",label:"商户名称",index : "storeName"},				
				{name : "storeArea",label:"商圈",index : "storeArea"},				
				{name : "bidTime",label:"竞价时段",index : "bidTime"},				
				/* {name : "searchTime",label:"查询时间",index : "searchTime"}, */				
				{name : "bidCycle",label:"竞价周期",index : "bidCycle"},				
				{name : "bidTotalAmountInWeek",label:"一周内竞价总金额",index : "bidTotalAmountInWeek"},				
				{name : "averageClickCost",label:"平均单次点击费用",index : "averageClickCost"},				
				{name : "bidActivityIntensity",label:"竞价期间活动力度",index : "bidActivityIntensity"},				
				{name : "exposureIncrementPercent",label:"竞价期间同比周期曝光量增幅",index : "exposureIncrementPercent"},				
				{name : "enterRateIncrementPercent",label:"竞价期间同比周期进店率增幅",index : "enterRateIncrementPercent"},				
				{name : "tradeAmountIncrementPercent",label:"竞价期间同期交易额增幅",index : "tradeAmountIncrementPercent"},				
				{name : "rankBeforeBid",label:"竞价前店铺排名",index : "rankBeforeBid"},				
				{name : "rankAfterBid",label:"竞价后店铺排名",index : "rankAfterBid"},				
				{name : "contributionInBid",label:"竞价排名贡献值",index : "contributionInBid"}				
    	    ],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
    });

 
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
    
  //导入excel数据
	function importData(){
		 if($('input[type="file"]').val()!=""){
			var extend=$('input[type="file"]').val().substr($('input[type="file"]').val().lastIndexOf(".")+1);
			if("xls|xlsx".indexOf(extend)==-1){//在字符串中xls|xlsx寻找后缀xls或者xlsx，有的话返回下标，没有就返回-1
				 showInfo("选择的文件必须是EXCEL文件,请确认！",3000);
	         }else{
	        	ajaxFileUpload();
	        	showInfo("数据导入成功",2000);
	        	gridObj.trigger('reloadGrid');
	         }
		 }else{
			showInfo("请选择EXCEL文件！",3000);
	    }
	}
    
 	function ajaxFileUpload(){
 		var options = {
			url : "<m:url value='/staticAnalysis/bidimport.do'/>",
			type : "post",
			dataType:"text",
			success : function(d) {gridObj.trigger('reloadGrid');},
			error : function(d) {gridObj.trigger('reloadGrid');},
		};
		// 将options传给ajaxForm
		$('#form').ajaxSubmit(options);
 	}
 	
    </script>
</head>
<body onbeforeunload="checkLeave()">
	<div class="main  choice_box">
		<div class="listplace">
				<!--功能按钮begin-->
				<div class="list_btn_bg fl"><!--功能按钮 div-->
					<ul>
 					<c:if test="${add}">
						<li><a title="<m:message code="button.add"/>" href="javascript:;"
							onclick="add();"> <i class="icon_bg icon_add"> </i> <span><m:message
										code="button.add" /></span>
						</a></li>
					</c:if>
					<li>
						<a title="导入数据" href="javascript:;" onclick="$('#file').click()"> 
							<i class="back_icon import_icon"> </i> 
							<span>导入数据</span>
						</a>
						<form name="form" id="form" method="post"  enctype="multipart/form-data">
							<input type="file" id="file" name="file" style="display: none" onchange="importData();"/>
						</form>
					</li>
					<li>
						<a title="导出数据" href="javascript:;" onclick=""> 
							<i class="back_icon import_icon"> </i> 
							<span>导出数据</span>
						</a>
					</li>
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
