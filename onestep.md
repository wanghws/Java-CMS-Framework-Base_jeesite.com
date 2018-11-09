## 表单验证
```
function validform() {
    return $("#inputForm").validate();
}
$(document).ready(function() {

    $(validform());

    $("#SubmitButton").click(function () {
        if(validform().form()){
            $("#inputForm").submit();
        }else{
            alert("验证未通过");
            return;
        }
    });
});
```
## 自定义表单验证
```
$(document).ready(function() {
    $.validator.addClassRules("points", {range:[0,100]});
    $.validator.addMethod("checkPoints",function (value, element) {
        if(value != 1){//value是当前表单value值
            return false;//false不通过验证，显示错误信息
        }
        return true;//通过验证
    }, "自定义错误信息：value必须为1");
});
```

## WdatePicker日历控件时间参数控制
1.  dateFmt：格式化
2.  isShowClear：是否显示清除按钮
3.  minDate：最小时间设置
4.  maxDate：最大时间设置
5.
   ```
   <input name="beginTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" value="" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:true,minDate:\'%y-%M-{%d+1}\'});"/>
   ```
6. 例如：
   ```
   $('.Wdate').datepicker({  format: 'yyyy-mm-dd',  weekStart: 1, startDate: new Date(2013,10, 27), /*开始时间，在这时间之前都不可选*/  endDate:'+1', /*结束时间，在这时间之后都不可选*/ autoclose:  true, todayBtn:  'linked', language:  'zh-CN' });
   ```
## 部门机构选择器
```
    <div class="control-group">
        <label class="control-label">部门:</label>
        <div class="controls">
            <sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}" title="机构" url="/sys/office/treeData?type=2" extId="${office.id}" cssClass="" allowClear="${office.currentUser.admin}"/>
        </div>
    </div>
```
## 归属地区选择器
```
    <div class="control-group">
        <label class="control-label">归属区域:</label>
        <div class="controls">
            <sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}" title="区域" url="/sys/area/treeData" cssClass="required"/>
        </div>
    </div>
```
## 弹出窗口--选择界面
   1. 父页面：
   2. ```
      $("#clickOpenPopWindow").click(function () {
            var parameter = $("#parameter").val();
             top.$.jBox.open("iframe:/child/window/page",
                "选择",
                1024,
                520,
                {ajaxData:{"parameter1":parameter}}
            );
        });
      ```
    3.  子页面
         ```
         parent.window.frames["mainFrame"].parentPageFunction(p1,p2,p3);
         top.$.jBox.close(true);
         ```
## 多表单效验
   ```
   $('form').each(function() {
        $(this).validate({
            ignore: ".ignore",
            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
   ```
