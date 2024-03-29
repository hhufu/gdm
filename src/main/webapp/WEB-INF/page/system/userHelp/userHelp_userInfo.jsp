<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/common/common.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>修改用户</title>
    <meta http-equiv=Content-Type content="text/html; charset=utf-8">
    <link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/css/newStyle.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="<%=path%>/third/layui/css/layui.css"
          type="text/css"/>

    <script type="text/javascript" src="<%=path%>/third/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=path%>/third/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layer/layer.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layui/layui.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/dialog.js"></script>
    <script type="text/javascript" src="<%=path%>/js/core/dialog/closeDialog.js"></script>
    <script type="text/javascript" src="<%=path%>/third/layer/extend/layer.ext.js"></script>

    <style type="text/css">
        th, td {
            padding: 8px;
            font-size: 14px;
        }

        th {
            width: 100px;
        }
    </style>
</head>
<script type="text/javascript">
    $(function () {
        var flag = "${userSign}";
        if (flag != '' && flag != undefined) {
            if (flag == '0') {
                var index =
                    layer.open({
                        type: 2,
                        area: ['80%', '80%'],
                        fix: false, //不固定
                        title: '修改个人信息',
                        content: '<%=path%>/sys/userHelp_openEdit.action?view=userInfoEdit&thisId=${session.userId }&resUri=openEdit&mark=${mark}'
                    });
            }
        }
    });

    $(function () {
        var flag = "${mark}";
        if (flag != '' && flag != undefined && flag == "1") {
            layer.msg('修改成功', {
                icon: 1
            });
        } else if (flag == "0") {
            layer.msg('修改失败', {
                icon: 2
            });
        }
    });
</script>

<script type="text/javascript">
    $(function () {
        //校验手机号码
        $.validator.addMethod("mobile", function (value, element) {
            var length = value.length;
            var mobile = /^(13\d|14[57]|15[^4,\D]|17[678]|18\d)\d{8}|170[059]\d{7}$/;
            return this.optional(element) || (length == 11 && mobile.test(value));
        }, "格式错误");
        //身份证
        $.validator.addMethod("stuIdCard", function (value, element) {
            var idCard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            return this.optional(element) || (idCard.test(value));
        }, "格式错误");
        //qq邮箱
        $.validator.addMethod("qqemail", function (value, element) {
            var email = /^\d{5,12}@[qQ][qQ]\.(com|cn)$/;
            return this.optional(element) || (email.test(value));
        }, "格式错误");
        //校验密码确认密码
        $.validator.addMethod("equalPad", function (value, element) {
            return this.optional(element) || (value == $("#newPsd").val());
        }, "新密码与确认密码不一致");

        $("#form1").validate({
            errorClass: "errorInfo", //默认为错误的样式类为：error
            errorElement: "em",
            focusInvalid: false, //当为false时，验证无效时，没有焦点响应
            onkeyup: false,
            submitHandler: function (form) {   //表单提交句柄,为一回调函数，带一个参数：form
                form.submit();   //提交表单
            },
            rules: {
                "oldPsd": {
                    required: true,
                    remote: {
                        type: "post",
                        url: "<%=path %>/sys/userHelp_checkPassword.action",
                        data: {
                            "oldPsd": function () {
                                return $("#oldPsd").val();
                            }
                        },
                        dataType: "html",
                        dataFilter: function (data, type) {
                            var tag = document.getElementsByTagName("i");
                            tag[0].style.display = "none";
                            if (data == "true") {
                                return true;
                            } else {
                                return false;
                            }
                        }
                    },
                    rangelength: [2, 20],
                    required: true,
                },
                "newPsd": {
                    required: true,
                    rangelength: [6, 20]
                },
                "surePsd": {
                    required: true,
                    rangelength: [6, 20],
                    equalPad: true
                },
                "model.userTel": {
                    required: true,
                    mobile: true
                },

                "model.userEmail": {
                    required: true,
                    qqemail: true
                },
                "stuIdcart":{
                    require: true,
                    stuIdCard: true
                },


            },
            messages: {
                "oldPsd": {
                    required: "请输入旧密码",
                    remote: "密码不正确",
                },
                "newPsd": {
                    required: "请输入新密码",
                    rangelength: "长度为6- 20位"
                },
                "surePsd": {
                    required: "请输入确认密码",
                    rangelength: "长度为6- 20位"
                },
                "model.userTel": {
                    required: "请输入手机号码"
                },
                "model.userEmail": {
                    required: "请输入QQ邮箱"
                },
                "stuIdcart":{
                    required: "请输入"
                }

            },
            errorPlacement: function (error, element) { //错误信息位置设置方法
                error.appendTo(element.parent()); //这里的element是录入数据的对象
            }
        });
    });

</script>

<body style="min-width: 200px">
<div class="main" style="max-width:800px; margin:0 auto;">
    <fieldset class="layui-elem-field">
        <legend>个人信息</legend>
        <div class="layui-field-box">
            <form action="<%=path%>/sys/userHelp_editUserInfo.action?view=userInfo" target="rightFrame" method="post" name="form1" id="form1">
                <input type="hidden" name="model.id" value="${model.id }">
                <table class="tablelist">
                    <ul>
                        <li>
                            <tbody>
                            <tr>
                                <th>姓名：</th>
                                <td class="textContent" colspan="1">${model.userName }</td>
                                <th rowspan="4" colspan="2" style="width: 160px">
                                    <div class="layui-upload" id="phone">
                                        <div class="layui-upload-list">
                                            <c:choose>
                                                <c:when test="${model.userImg != null and model.userImg != ''}">
                                                    <img class="layui-upload-img" src="<%=basePath%>${model.userImg}"
                                                         id="demo1" style="width:179px;height:192px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="layui-upload-img" src="<%=path%>/images/photo.jpg"
                                                         id="demo1" style="width:179px;height:192px;">
                                                </c:otherwise>
                                            </c:choose>
                                            <p id="demoText"></p>
                                        </div>
                                        <button type="button" class="layui-btn" id="test1">上传图片</button>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <th><s:if test="student.stuId!=null">学号：</s:if>
                                    <s:if test="teacher.teacherId!=null">职工号：</s:if>
                                </th>
                                <td class="textContent" colspan="1">${model.loginName }</td>
                            </tr>
                            <tr>
                                <th>性别：</th>
                                <td class="textContent" colspan="1">
                                    <s:select cssClass="dfinput" list="#{0:'女',1:'男'}"
                                              listKey="key" listValue="value" value="model.userSex"
                                              id="model.userSex" name="model.userSex"/>
                                </td>
                            </tr>
                            <tr>
                                <th>用户角色：</th>
                                <td class="textContent" colspan="1"><s:iterator id="re"
                                                                                value="model.sysRoles">
                                    ${roleName }
                                </s:iterator></td>
                            </tr>
                            <!--学生-->
                            <s:if test="student.stuId!=null">
                                <tr>
                                    <th>所属院系：</th>
<%--                                    <td class="textContent" colspan="3">--%>
<%--                                        <s:iterator id="p" value="student">--%>
<%--                                            <s:if test="#p.deptNumber == deptNumber">--%>
<%--                                                ${deptName}--%>
<%--                                            </s:if>--%>
<%--                                        </s:iterator>--%>
<%--                                    </td>--%>
                                    <td class="textContent" colspan="1">
                                        <s:select cssClass="dfinput" list="sysDepartments"
                                                  value="student.deptNumber"
                                                  listKey="deptNumber" listValue="deptName"
                                                  id="student.deptNumber" name="student.deptNumber"/>
                                    </td>
                                    <th>学制：</th>
                                    <td colspan="1">
                                        <s:select cssClass="dfinput" list="#{4:'四年',3:'三年',2:'二年',1:'一年'}"
                                                  listKey="key" listValue="value" value="student.stuSchoollength"
                                                  id="student.stuSchoollength" name="student.stuSchoollength"/>
                                    </td>
                                </tr>
                                <tr>
                                    <th>所属专业：</th>
                                    <%--<td class="textContent" colspan="3">${student.majorName}</td>--%>
                                    <td class="textContent" colspan="1">
                                        <s:select cssClass="dfinput" list="majors"
                                                  value="student.majorId"
                                                  listKey="majorId" listValue="majorName"
                                                  id="student.majorId" name="student.majorId"/>
                                    </td>
                                    <th>学历：</th>
                                    <td class="textContent" colspan="1" >
                                        <input  type="text" class="dfinput" name="student.stuArrangement" value="${student.stuArrangement}" maxlength="20">
                                    </td>
                                </tr>
                                <tr>
                                    <th>大类：</th>
                                    <td class="textContent" colspan="1">
                                        <s:select cssClass="dfinput" list="sysCategorys"
                                                  value="student.categoryId"
                                                  listKey="categoryId" listValue="categoryName"
                                                  id="student.categoryId" name="student.categoryId"/>
                                    </td>

                                    <th>身份证：</th>
                                    <td class="textContent" colspan="1">
                                        <input type="text" class="dfinput" name="student.stuIdcart" id="stuIdcart" value="${student.stuIdcart}" maxlength="18">
                                    </td>
                                </tr>
                                <tr>
                                    <th>所属班级：</th>
<%--                                    <td class="textContent" colspan="3">--%>
<%--                                        <s:iterator id="p" value="student">--%>
<%--                                            <s:if test="#p.classId == classId">${className}</s:if>--%>
<%--                                        </s:iterator>--%>
<%--                                    </td>--%>
                                    <td class="textContent" colspan="1">
                                        <s:select cssClass="dfinput" list="classes"
                                                  value="student.classId"
                                                  listKey="classId" listValue="className"
                                                  id="student.classId" name="student.classId"/>
                                    </td>
                                    <th>手机号码：</th>
                                    <td class="textContent" colspan="1">
                                        <input type="text" class="dfinput" placeholder="请输入手机号码"
                                               maxlength="11"
                                               value="${model.userTel}"
                                               name="model.userTel">
                                    </td>
                                </tr>
                                <tr style=" ">
                                    <th>所属年级：</th>
                                    <td colspan="1">
                                        <s:select cssClass="dfinput" list="#{2017:'2017',2018:'2018',2019:'2019',2020:'2020',2021:'2021',2022:'2022',2023:'2023',2024:'2024',2025:'2025',2026:'2026',2027:'2027',2028:'2028',2029:'2029',2030:'2030'}"
                                                  listKey="key" listValue="value" value="student.stuGrade"
                                                  id="student.stuGrade" name="student.stuGrade"/>
                                    </td>

                                    <th>QQ邮箱：</th>
                                    <td class="textContent" colspan="1">
                                        <input type="text" class="dfinput" placeholder="请输入QQ邮箱" id="model.userEmail" value="${model.userEmail}" name="model.userEmail">
                                    </td>
<%--                                    <td class="textContent" colspan="3">${student.stuGrade}</td>--%>
                                </tr>
<%--                                <tr>--%>
<%--                                    <th>学制：</th>--%>
<%--                                    <td colspan="3">--%>
<%--                                        <s:select cssClass="dfinput" list="#{4:'四年',3:'三年',2:'二年',1:'一年'}"--%>
<%--                                                  listKey="key" listValue="value" value="student.stuSchoollength"--%>
<%--                                                  id="student.stuSchoollength" name="student.stuSchoollength"/>--%>
<%--                                    </td>--%>
<%--&lt;%&ndash;                                    <td class="textContent" colspan="3">${student.stuSchoollength }</td>&ndash;%&gt;--%>
<%--                                </tr>--%>
<%--                                <tr>--%>
<%--                                    <th>学历：</th>--%>
<%--                                    <td class="textContent" colspan="3"  >--%>
<%--                                                <input  type="text" value="${student.stuArrangement}" name="student.stuArrangement">--%>
<%--                                    </td>--%>
<%--                                </tr>--%>
<%--                                <tr>--%>
<%--                                    <th>身份证：</th>--%>
<%--                                    <td class="textContent" colspan="3">--%>
<%--                                        <input type="text" style="width: 100%;" name="student.stuIdcart" value="${student.stuIdcart}" maxlength="18">--%>
<%--                                    </td>--%>
<%--                                </tr>--%>
                                <tr>
                                    <th>家庭住址：</th>
                                    <td class="textContent" colspan="3">
                                        <input class="dfinput" type="text" style="width: 100%; height: 50px" name="student.stuAddress" value="${student.stuAddress}" maxlength="200">
                                    </td>
                                </tr>
                            </s:if>
                            <s:if test="teacher.teacherId!=null">
                                <tr>
                                    <th>所属教研室：</th>
                                    <td class="textContent" colspan="3">
                                        <s:select cssClass="dfinput" list="majors"
                                                  value="teacher.staffroomId"
                                                  listKey="majorId" listValue="staffName"
                                                  id="teacher.staffroomId" name="teacher.staffroomId"/>
                                    </td>
                                <tr>
                                <tr>
                                    <th>大类：</th>
                                    <td class="textContent" colspan="3">
                                        <s:select cssClass="dfinput" list="sysCategorys"
                                                  value="teacher.categoryId"
                                                  listKey="categoryId" listValue="categoryName"
                                                  id="teacher.categoryId" name="teacher.categoryId"/>
                                    </td>
                                <tr>
                            <%--二级学院--%>
                                <tr>
                                    <th>二级学院：</th>
                                    <td class="textContent" colspan="3">
                                        <s:select cssClass="dfinput" list="sysDepartments"
                                                  value="teacher.deptNumber"
                                                  listKey="deptNumber" listValue="deptName"
                                                  id="teacher.deptNumber" name="teacher.deptNumber"/>
                                    </td>
                                <tr>
                                    <th>职称：</th>
                                <td class="textContent" colspan="3">
                                    <s:select cssClass="dfinput" list="sysTechnicals"
                                              value="teacher.technicalId"
                                              listKey="technicalId" listValue="technicalName"
                                              id="teacher.technicalId" name="teacher.technicalId"/>
                                </td>
<%--                                    <td class="textContent" colspan="3">${teacher.technicalName }</td>--%>
                                </tr>
                                <tr>
                                    <th>职务：</th>
                                    <td class="textContent" colspan="3">
                                        <s:select cssClass="dfinput" list="duties"
                                                  listKey="dutiesNo" listValue="dutiesName"
                                                  value="teacher.dutiesNo"
                                                  id="teacher.dutiesId" name="teacher.dutiesNo"/>
                                    </td>
<%--                                    <td class="textContent" colspan="3">${teacher.dutiesName }</td>--%>
                                </tr>
                                <th>所带专业：</th>
                                <td class="textContent" colspan="2"><s:iterator id="p"
                                                                                value="teacher.teacherMajorList">
                                    ${majorName}
                                </s:iterator></td>
                                <td width="auto">
                                    <a href="javascript:dialogReload('100%','100%','所带专业','<%=path%>/sys/teacher_openMajorList.action?view=major_list&teacherMajor.teacherId=${teacher.teacherId }', 'true','0%');">
                                        <font color="green"> <i class="layui-icon">&#xe642;</i>修改</font></a>
                                </td>
                                </tr>
                                <tr>
                                    <th>研究方向：</th>
                                    <td class="textContent" colspan="2"><s:iterator id="p"
                                                                                    value="teacher.teacherDirectionList">
                                        ${directionsName}
                                    </s:iterator></td>
                                    <td>
                                        <a href="javascript:dialogReload('100%','100%','研究方向','<%=path%>/sys/teacher_openDirectionsList.action?view=directions_list&teacherDirections.teacherId=${teacher.teacherId }', 'true','0%');">
                                            <font color="green"> <i class="layui-icon">&#xe642;</i>修改</font></a>
                                    </td>
                                </tr>
                            <tr>
                                <th>手机号码：</th>
                                <td class="textContent" colspan="3">
                                    <input type="text" class="dfinput" placeholder="请输入手机号码"
                                           value="${model.userTel}"
                                           id="model.userTel" name="model.userTel">
                                </td>
                            </tr>
                            <tr>
                                <th>QQ邮箱：</th>
                                <td class="textContent" colspan="3">
                                    <input type="text" class="dfinput" placeholder="请输入QQ邮箱"
                                           value="${model.userEmail}"
                                           id="model.userEmail" name="model.userEmail">
                                </td>
                            </tr>

                            </s:if>
                            <tr>
                                <th>是否修改密码：</th>
                                <td class="textContent" colspan="3">
                                    <div class="layui-form">
                                        <input type="radio" name="isPsd" value="1" title="是"> <input type="radio" name="isPsd" value="0" title="否" checked>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </li>
                    </ul>
                </table>

                <table class="tablelist" id="PsdDiv">
                    <tr>
                        <th>旧密码：</th>
                        <td class="textContent" colspan="3">
                            <input type="password" class="dfinput"
                                   id="oldPsd" name="oldPsd"> <i class="warn">*</i>
                        </td>
                    </tr>
                    <tr>
                        <th>新密码：</th>
                        <td class="textContent" colspan="3">
                            <input type="password" class="dfinput"
                                   id="newPsd" name="newPsd"><i class="warn">*</i>
                        </td>
                    </tr>
                    <tr>
                        <th>确认密码：</th>
                        <td class="textContent" colspan="3">
                            <input type="password" class="dfinput"
                                   id="surePsd" name="surePsd"> <i class="warn">*</i>
                        </td>
                    </tr>
                </table>
                <li>
                    <div style="text-align: center;">
                        <input name="" type="submit" class="scbtn" value="修改"
                        />
                    </div>
                </li>
                </ul>
            </form>
        </div>
    </fieldset>

</div>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
    $(function () {
        $("#PsdDiv").hide();
    });
    layui.use('form', function () {
        var form = layui.form;
        form.on('radio', function (data) {
            if (data.value == 1) {
                $("#PsdDiv").show();
            } else if (data.value == 0) {
                $("#PsdDiv").hide();
            }
        });
    });
</script>
<script type="text/javascript">
    layui.use('upload', function () {
        var upload = layui.upload;
        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1',
            url: '<%=path%>/sys/userHelp_loadUserHelpImg.action?thisId=${model.id}'
            , accept: 'file'
            , field: 'upload',
            before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj
                    .preview(function (index,
                                       file, result) {
                        $('#demo1').attr('src',
                            result); //图片链接（base64）
                    });
            },
            done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg('上传失败');
                } else {
                    return layer.msg('上传成功');
                }
                //上传成功
            },
            error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on(
                    'click', function () {
                        uploadInst.upload();
                    });
            }
        });

    });

    function loginOutTip() {
        layer.open({
            title:'系统提示'
            ,content: '您确认退出吗？'
            ,offset: ['40%', '40%']
            ,btn: ['确定退出', '取消']
            ,shadeClose: true
            ,yes: function(index, layero){
                layer.msg('退出成功',{icon:1})
                top.location = "<%=path%>/Userlogin_logout.action";
            }
            ,btn2: function(index, layero){
            }
            ,cancel: function(){
            }
        });
    }
</script>


</body>
</html>
