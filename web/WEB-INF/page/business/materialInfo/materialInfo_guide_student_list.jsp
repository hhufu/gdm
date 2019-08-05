<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>课题信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css" />

<script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
<s"C:/Users/liyixia/Desktop/14物联网班 开题报告登记表12.14.xls"cript type="text/javascript" src="<%=path%>/third/layer/extend/layer.ext.js"></script>
<script type="text/javascript" src="<%=path%>/js/core/dialog/dialog.js"></script>
<script type="text/javascript" src="<%=path%>/js/core/dialog/enable.js"></script>
<script type="text/javascript" src="<%=path%>/datePicket/WdatePicker.js"></script>
<script type="text/javascript">

 //搜索
    function openSearch(name){
    	$("#form1").submit();
    }
</script>

<style >
</style>
</head>
<body>
		<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="<%=path%>/sys/login_view.action?view=right" target="rightFrame">首页</a></li>
		<li>所带学生信息</li>
		</ul>
		</div>
		<div class="rightinfo">
			<div class="formtitle">
				<span>所带学生列表</span>
			</div>
        <form id="form1" name="form1"  action="<%=path%>/biz/materialInfo_guideStudentList.action?view=guide_student_list&flag=13" method="post">
        	<div class="place">
		<ul class="placeul">
		<li><span>院系：</span>${teacher.deptName }</li>
		<li><span>大类：</span>${teacher.categoryName }</li>
					<li>当前年度：
					<input class="dfinput" type="text"
						id="issueInfo.year" name="thisYear" readonly value="${model.year}"
						style="text-align: center;"
						onClick="WdatePicker({dateFmt:'yyyy'});"></td>
				</li>
				<li class="click">
	        		<a href="javascript:void(0);"  onclick="openSearch(this);"><img src="<%=path%>/images/search.png"  />搜索</a>
				</li> 
		</ul>
		</div>
       </form>
       
         <table class="tablelist" >
    	  <thead>
	    	<tr>
				<th width="80px;" rowspan="2">
					<input onclick="selectAll()" type="checkbox" name="controlAll" style="controlAll" id="controlAll" />&nbsp;全选
				</th>
	    	<th rowspan="2">序号</th>
	    	<th colspan="4">学生信息</th>
	    	<th colspan="2">课题信息</th>
	    	<th rowspan="2">任务书</th>
	    	<th rowspan="2">开题报告</th>
	    	<th rowspan="2">进度情况</th>
	   		<th rowspan="2">评阅</th>
	   		<th rowspan="2">审查</th>
	   		<th rowspan="2">答辩记录</th>
	   		<th rowspan="2">年度</th>
	        </tr>
	        <tr>
			<th>学院</th>
	    	<th>专业</th>
	    	<th>班级</th>
	    	<th>姓名</th>
	    	<th>课题</th>
	    	<th>课题类型</th>
	    	<th></th>
	    	<th></th>
	        </tr>
         </thead>
         <tbody>
         <s:iterator id="p" value="planProgressList">
				  <%--      <s:if test="progressItemNo==00"><s:set name=""></s:set></s:if>
				       <s:if test="progressItemNo==00"><s:set name=""></s:set></s:if>
				       <s:if test="progressItemNo==00"><s:set name=""></s:set></s:if>
				       <s:if test="progressItemNo==00"><s:set name=""></s:set></s:if>
				       <s:if test="progressItemNo==00"><s:set name=""></s:set></s:if> --%>
		</s:iterator>
         <s:iterator id="p" value="guideStudentList" status="pp">
         <tr id="tr_${taskId }">
			 <td align="center">
				 <s:if test="groupAllotId==null" >
					 <input value="${stuId}"  title="${stuName }"  type="checkbox" name="selected"/>
				 </s:if>
				 <s:else>
					 <font color="red"> <i class="layui-icon">&#xe618;</i></font>
				 </s:else>
			 </td>
						<td align="center"><s:property value="#pp.count" /></td>
						  <td align="center">
				        			${student.deptName}
		               </td>
					   <td align="center">
				        			${student.majorName}
		                </td>
				        <td align="center">
				        			${student.className}
				        </td>
				        
						<td align="center" >${student.stuName}</td>
				       <td align="center">
					       <s:if test="issueInfo.issueId==null">
					        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 课题信息',
					        '<%=path%>/biz/issueInfo_openEdit.action?view=add&thisStuId=${student.stuId }&thisYear=${model.year }', 'true','20%');" target="rightFrame" >  
					       <font color="red">未录入</font></a>
					       </s:if>
					       <s:else>
					        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 课题信息',
					        '<%=path%>/biz/issueInfo_openEdit.action?view=edit&thisStuId=${student.stuId }&thisId=${issueInfo.issueId }&thisYear=${model.year }', 'true','20%');" target="rightFrame" >  
					       <font color="blue">${issueInfo.issueName}</font></a>
					       </s:else>
				        </td> 
						  <td align="center" >
							  <s:if test="issueInfo.issueType==''||issueInfo.issueType==null">
								  <font color="red">未录入</font>
							  </s:if>
							  <s:else>
								  <s:iterator  id="p" value="issueTypeList" status="sp">
									  <s:if test="issueInfo.issueType!=null&&issueInfo!=null&&issueInfo.issueType.contains(\"&\"+issueTypeId+\"&\")">${issueTypeName }&nbsp;</s:if>
								  </s:iterator>
							  </s:else>
					    </td>
				        
						<td align="center">
						<s:if test="taskId==null">
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font> 】任务书信息','
				          <%=path%>/biz/taskBook_openAdd.action?view=add&thisStuId=${student.stuId }&thisYear=${model.year }&tabFlag=01&flag=03', 'true','20%');" target="rightFrame" >  
				       <font color="red">未录入</font></a>
				       </s:if><s:else>
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 任务书信息','
				          <%=path%>/biz/taskBook_openEdit.action?view=edit&thisStuId=${student.stuId }&thisId=${taskId }&thisYear=${model.year }&tabFlag=01&flag=03', 'true','20%');" target="rightFrame" >  
				       <font color="blue">查看</font></a></s:else>
				        </td> 
				        
					<td align="center">
					<s:if test="reportId==null">
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 开题报告信息','
				          <%=path%>/biz/openReport_openAdd.action?view=add&thisStuId=${student.stuId }&thisYear=${model.year }&tabFlag=02&flag=04','true','20%');" target="rightFrame" >  
				       <font color="red">未录入</font></a>
				       </s:if><s:else>
				        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 开题报告信息','
				          <%=path%>/biz/openReport_openEdit.action?view=edit&thisStuId=${student.stuId }&thisId=${reportId }&thisYear=${model.year }&tabFlag=02&flag=04','true','20%');" target="rightFrame" >  
				       <font color="blue">查看</font></a></s:else>
				        </td> 
				        
						
						<td align="center">
						<s:if test="reportId==null">-</s:if><s:else>
				        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 进度情况信息','
				          <%=path%>/biz/progressSitu_list.action?view=list&thisStuId=${student.stuId }&thisId=${progressId }&thisYear=${model.year }&tabFlag=03&flag=05', 'true','20%');" target="rightFrame" >  
				        <s:if test="progressId==null"><font color="red">未录入</font>
				        </s:if><s:else><font color="blue">查看</font></s:else></a>
				        </s:else>
				        </td> 
				        
				        <td align="center">
				        <s:if test="progressId==null">-</s:if><s:else>
				       <s:if test="reviewGuideId==null">
				        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 指导老师评阅信息','
				          <%=path%>/biz/review_openAdd.action?view=add&thisStuId=${student.stuId }&thisReviewType=00&thisYear=${model.year }&flag=07', 'true','20%');" target="rightFrame" >  
				       <font color="red">未录入</font></a>
				       </s:if><s:else>
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font> 】指导老师评阅信息','
				          <%=path%>/biz/review_openEdit.action?view=edit&thisId=${reviewGuideId }&thisStuId=${student.stuId }&thisReviewType=00&thisYear=${model.year }&flag=07', 'true','20%');" target="rightFrame" >  
				      <font color="blue">查看</font></a>
				       </s:else></s:else>
				        </td>  
				        
				       <td align="center">
				        <s:if test="progressId==null">-</s:if><s:else>
				         <s:if test="reviewCheckId==null">
				        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 规范审查信息','
				          <%=path%>/biz/review_openAdd.action?view=add&thisStuId=${student.stuId }&thisReviewType=02&thisYear=${model.year }&flag=07', 'true','20%');" target="rightFrame" >  
				       <font color="red">未录入</font></a>
				       </s:if><s:else>
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 规范审查信息','
				          <%=path%>/biz/review_openEdit.action?view=edit&thisId=${reviewCheckId }&thisStuId=${student.stuId }&thisReviewType=02&thisYear=${model.year }&flag=07', 'true','20%');" target="rightFrame" >  
				      <font color="blue">查看</font></a>
				       </s:else></s:else>
				        </td>  
				       
				         <td align="center">
				          <s:if test="reviewCheckId==null|reviewGuideId==null">-</s:if><s:else>
				           <s:if test="defenseId==null">
				        <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 答辩记录信息','
				          <%=path%>/biz/defenseRecord_openAdd.action?view=add&thisStuId=${student.stuId}&thisYear=${model.year }&flag=11', 'true','20%');" target="rightFrame" >  
				       <font color="red">未录入</font></a>
				       </s:if><s:else>
				         <a href="javascript:dialog('100%','100%','【<font color=blue >${student.stuName }</font>】 答辩记录信息','
				          <%=path%>/biz/defenseRecord_openEdit.action?view=edit&thisId=${defenseId }&thisStuId=${student.stuId }&thisYear=${model.year }&flag=11', 'true','20%');" target="rightFrame" >  
				      <font color="blue">查看</font></a>
				       </s:else></s:else>
				        </td> 
				        
				         <td align="center">  ${model.year} </td> 
						</tr>
			</s:iterator>
	     </tbody>
      </table>
</div>
<script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
</script>
<script type="text/javascript">
//删除
function del(name,id){
	var re=$(name).parent().parent();
	layer.confirm('您确定要删除该课题吗?', {icon: 3, title:'提示'}, function(index){
		  layer.close(index);
		var index = layer.load(1);
		 $.ajax({
	        type: "post",
	        cache: false,
	        url: '<%=path%>/biz/issueInfo_del.action',
					dataType : "json",
					data : {
						"thisId" : id
					},success : function(result) {
						layer.close(index); 
						if (result) {
							re.remove();
							layer.alert('删除成功',{icon: 1},function(){
								 location.reload();
								});
						}else{
							layer.msg('删除失败',{icon: 2});
						}
					},
					error : function(result) {
						layer.close(index); 
						layer.msg('删除失败',{icon: 2});
					}
				});
});
}
</script>
</body>
</html>


