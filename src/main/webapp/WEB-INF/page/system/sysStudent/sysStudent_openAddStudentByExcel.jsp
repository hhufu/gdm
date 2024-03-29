<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/common.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>添加学生</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css" />

<script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>

<script type="text/javascript">

$(function(){
	$("#form1").validate({
        errorClass:"errorInfo", //默认为错误的样式类为：error
        errorElement:"em",
        focusInvalid: false, //当为false时，验证无效时，没有焦点响应  
        onkeyup: false,   
        submitHandler: function(form){   //表单提交句柄,为一回调函数，带一个参数：form
			var loadingIndex = layer.load(2, { //icon支持传入0-2
				shade: [0.5, 'gray'], //0.5透明度的灰色背景
				content: '导入中...',
				success: function (layero) {
					layero.find('.layui-layer-content').css({
						'padding-top': '39px',
						'width': '60px'
					});
				}
			});
			// layer.load(2); //又换了种风格
              form.submit();   //提交表单
        },   
        rules:{
        	"excelFile":{
                required:true
        	},
        },
        messages:{
            "excelFile":{
            	required:"请选择文件"
            },
    },
    errorPlacement: function(error, element) { //错误信息位置设置方法
		error.appendTo( element.parent() ); //这里的element是录入数据的对象
    }
    });
	//显示文件
	$("#excelFile").change(function(){
		var filePath=$(this).val();
		if(filePath.indexOf("xlsx")!=-1){
			var arr=filePath.split('\\');
			var fileName=arr[arr.length-1];
			$("#inputXlsx").text(fileName);
		}else{
			return false
		}
	})
});
$(function(){
    var flag="${mark}";
    if(flag!='' && flag!=undefined){
   	 if(flag=="1"){
       $('#submit').attr('disabled','disabled');
	     var flag="${exitList}";
	     if(flag!='' && flag!=undefined){
	     layer.msg('添加成功,信息重复');
	    }else{
	    	 layer.msg('添加成功');
	        setTimeout(function(){
	           parent.location.reload();
	           layer.close(index);
	        },1000);
	    }
  
    }else if(flag=="0"){
    layer.msg('添加失败');
    }
   }
});

   // layui.use('form', function(){
	//     var form = layui.form;
	// });



</script>

<style type="text/css">
.rightText {text-align: right;width: 16%;}
td {padding: 4px;font-size: 14px;color: red;}
.inputfrom{width: 78%;height: 40px;border: 1px  solid #C1DAD7;font-size: 16px;}
.warn{color: red;font-size: 25px;}
h1{color: red;font-size: 15px;}
.file {
	position: relative;
	/*display: inline-block;*/
	background: #D0EEFF;
	border: 1px solid #99D3F5;
	border-radius: 4px;
	margin-right: 5px;
	padding: 9px 43px;
	overflow: hidden;
	color: #1E88C7;
	text-decoration: none;
	text-indent: 0;
	line-height: 30px;
}
.file input {
	position: absolute;
	/*font-size: 100px;*/
	height: 30px;
	width: 135px;
	right: 0;
	top: 0;
	opacity: 0;
}
.file:hover {
	background: #AADFFD;
	border-color: #78C3F3;
	color: #004974;
	text-decoration: none;
}
</style>
</head>

<body><div class="place">
<span>位置：</span>
<ul class="placeul">
<li><a href="<%=path%>/sys/login_view.action?view=right" target="rightFrame">首页</a></li>
<li>学生管理</li>
</ul>

</html>
</div>
      <div class="rightinfo">
			<div class="formtitle">
				<span>导入学生信息</span>
			</div>
    	<form action="<%= basePath%>/sys/student_addStudentByExcel.action?view=openAddStudentByExcel" enctype="multipart/form-data" method="post" style="margin-left: 20px;" id="form1">
<%--			<button type="button" class="layui-btn" id="test1">--%>
<%--				<i class="layui-icon">&#xe67c;</i>选择文件--%>
<%--			</button>--%>
	<table>
		<tr>
			<td>
				<a href="javascript:void(0)" class="file" id="choice">选择文件
					<input type="file" id="excelFile"  name="excelFile"/>
				</a></td>
			<td><span id="inputXlsx"></span></td>
		</tr>
		<tr>
			<td>
				<input type="submit" name="" class="btn" value="确认导入"/></td>
			<td>
				<a href="<%=path%>/sys/download.action?filePath=templete/templeteStudent.xlsx"><input type="button" name=""  class="btn" value="下载模板"/></a></td>
		</tr>
	</table>

<%--			<input id="excelFile" class="layui-upload-file" type="file" name="excelFile" multiple="">--%>
    	</form>
		<br/>
			<s:if test="exitList!=null&&exitList!=[]">
			<h1>*该信息已存在</h1>
		  <table class="tablelist" >
    	<thead>
    	<tr>
    	<th>序号</th>
   		<th>学号</th>
   		<th>姓名</th>
   		<th>性别</th>
   		<th>身份证号</th>
   		<th>家庭地址</th>
   		<th>学历层次</th>
   		<th>入学时间</th>
   		<th>学制</th>
   		<th>年级</th>
   		<th>联系方式</th>
   		<th>邮箱</th>
   		<th>院系 </th>
   		<th>专业</th>
   		<th>班级</th>
   		<th>操作</th>
        </tr>
        </thead>
        <tbody>
				<s:iterator id="p" value="pageResult.data" status="pp">
					<tr id="tr_${id}">
						<td align="center"><s:property value="#pp.count" /></td>
						
						<td align="center" >${stuId}</td>
						<td align="center" >${stuName}</td>
						<td align="center" >${stuSex}</td>
						<td align="center" >${stuIdcart}</td>
						<td align="center" >${stuAddress}</td>
						<td align="center" >${stuArrangement}</td>
						<td align="center" >${stuEntrance}</td>
						<td align="center" >${stuSchoollength}</td>
						<td align="center" >${stuGrade}</td>
						<td align="center" >${stuPhone}</td>
						<td align="center" >${stuEmail}</td>
					    <td>
				        	<s:iterator value="sysDepartmentList" id="sdl">
				        		<s:if test="#p.deptNumber == #sdl.deptNumber">
				        			${deptName}
				        		</s:if>
				        	</s:iterator>
		               </td>
					   <td>
				        	<s:iterator value="sysMajorList" id="sml">
				        		<s:if test="#p.majorId == #mil.majorId">
				        			${majorName}
				        		</s:if>
				        	</s:iterator>
		                </td>
				        <td>
				        	<s:iterator value="sysClassList" id="scl">
				        		<s:if test="#p.classId == #scl.classId">
				        			${className}
				        		</s:if>
				        	</s:iterator>
				        </td> 
					</tr>
				</s:iterator>
				</tbody>
</table>
		</s:if>
		<br/>
	
    </div>
</body>
</html>

