<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/common/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>添加课题</title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css" type="text/css"/>

    <script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/dialog.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/enable.js"></script>
    <script type="text/javascript" src="<%=path%>/datePicket/WdatePicker.js"></script>

    <script type="text/javascript">

        $(function () {
            $("#form1").validate({
                errorClass: "errorInfo", //默认为错误的样式类为：error
                errorElement: "em",
                focusInvalid: false, //当为false时，验证无效时，没有焦点响应
                onkeyup: false,
                submitHandler: function (form) {   //表单提交句柄,为一回调函数，带一个参数：form

                    if (confirm("是否要保存信息？")) {
                        var index = layer.load(2, {time: 10 * 1000}); //又换了种风格，并且设定最长等待10秒
                        form.submit();   //提交表单

                    }
                },
                rules: {
                    "model.issueName": {
                        required: true
                    }
                },
                messages: {
                    "model.issueName": {
                        required: "请输入课题名称"
                    }
                },
                errorPlacement: function (error, element) { //错误信息位置设置方法
                    error.appendTo(element.parent()); //这里的element是录入数据的对象
                }
            });
        });

        $(function () {
            var flag = "${mark}";
            if (flag != '' && flag != undefined) {
                if (flag == "1") {
                    layer.msg('保存成功', {icon: 1});
                    setTimeout(function () {
                        parent.location.reload();
                    }, 1000);
                } else if (flag == "0") {
                    layer.msg('保存失败', {icon: 2});
                }
            }
        });
        layui.use('form', function () {
            // var form = layui.form();
            var form = layui.form;
        }) //搜索
        function openSearch(name) {
            // $("#form1").submit();
        };
    </script>

    <style type="text/css">
        .rightText {
            text-align: right;
            width: 100px;
        }

        table {
            margin: 0 auto;
        }

        td {
            padding: 4px;
            font-size: 14px;
        }

        .title {
            height: 40px;
        }

        .warn {
            color: red;
            font-size: 25px;
        }

        .textContent {
            font-size: 16px;
            padding: 4px;
            color: #3EAFE0;
        }
    </style>
</head>
<body style="min-width: 200px">

<form id="form1" name="form1" action="<%=path%>/biz/issueInfo_info.action?view=info&page=${pageResult.page}"
      method="post">
    <div class="place">
        <ul class="placeul">
            <li><span>院系：</span>${deptName }</li>
            <li>当前年度：
                <input class="dfinput" type="text"
                       id="issueInfo.year" name="thisYear" readonly value="${model.year}"
                       style="text-align: center;"
                       onClick="WdatePicker({dateFmt:'yyyy'});"></td>
            </li>
            <li class="click">
                <a href="javascript:void(0);" onclick="openSearch(this);"><img src="<%=path%>/images/search.png"/>搜索</a>
            </li>
        </ul>
    </div>
</form>
<div class="formbody">
    <div id="usual1" class="usual">
<%--        <%@ include file="/WEB-INF/page/business/materialInfo/select_tab.jsp" %>--%>
        <div id="tab1" class="tabson">
            <div class="rightinfo" style="text-align: center;">
                <fieldset class="layui-elem-field">
                    <legend>课题信息</legend>
                    <div class="layui-field-box">
                        <form
                                action="<%=path%>/biz/issueInfo_edit.action?view=edit"
                                method="post" name="form1" id="form1" style="border:1px  solid #C1DAD7;">
                            <input name="thisStuId" type="hidden" value="${thisStuId }">
                            <input type="hidden" name="thisId" value="${thisId }">
                            <input type="hidden" name="thisYear" value="${thisYear }">
                            <ul>
                                <li>
                                    <table class="tablelist" border="10" cellspacing="0" cellpadding="0">
                                        <tbody>
                                        <tr class="title">
                                            <td class="rightText">学院：</td>
                                            <td class="textContent">${student.deptName }</td>
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText">专业：</td>
                                            <td class="textContent">${student.majorName }</td>
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText">班级：</td>
                                            <td class="textContent">${student.className }</select></td>
                                        </tr>

                                        <tr class="title">
                                            <td class="rightText">学号：</td>
                                            <td class="textContent">${student.stuNo }</td>
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText">姓名：</td>
                                            <td class="textContent">${student.stuName }</td>
                                        </tr>
                                        <tr class="title">
                                            <td class="rightText">指导 老师：</td>
                                            <td class="textContent">${teacher.teacherName }</td>
                                        </tr>
                                        <tr>
                                            <td class="rightText">课题类型：</td>
                                            <td colspan="10">
                                                <s:iterator id="p" value="issueTypeList" status="sp">
                                                    <input type="checkbox"
                                                           name="issueTypeList[${sp.count-1 }].issueTypeId"
                                                           value="${issueTypeId}"
                                                           <s:if test="model.issueType.contains(\"&\"+issueTypeId+\"&\")">checked="checked"</s:if>>
                                                    ${issueTypeName }&nbsp;
                                                </s:iterator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="rightText">课题：</td>
                                            <td colspan="10">
                                                <textarea placeholder="请输入课题" style="width: 100%;height: 300px;" id="model.issueName" name="model.issueName">${model.issueName }</textarea>
                                            </td>
                                        </tr>
                                        <!--是否为教师-->
<%--                                        <s:if test="true">--%>
<%--                                            <tr>--%>
<%--                                                <th>是否通过：</th>--%>
<%--                                                <td class="textContent" colspan="2">--%>
<%--                                                    <s:select cssClass="dfinput" list="#{0:'通过',1:'不通过'}"--%>
<%--                                                              listKey="key" listValue="value" value="model.isPass"--%>
<%--                                                              id="model.userSex" name="model.isPass"/>--%>
<%--                                                </td>--%>
<%--                                            </tr>--%>
<%--                                        </s:if>--%>
                                        </tbody>
                                    </table>
                                <li>
                                    <div style="text-align: center;">
                                        <input name="" id="submit" type="submit" class="scbtn" value="保存"/>
                                    </div>
                                </li>
                            </ul>
                        </form>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $('.tablelist tbody tr:odd').addClass('odd');
    </script>
</body>
</html>
