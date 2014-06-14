/**
 * Created by Administrator on 14-6-14.
 * @author 郑钟良<zzl@ourstu.com>
 */
/**
 * 用户扩展信息验证
 * @param args
 * @param id
 * @returns {boolean}
 */
function check(args,id){
    var value=$('#expand_'+id).val();
    var text_type=args.getAttribute("text_type");
    var required=args.getAttribute("require");
    if(value.length==0){
        if(required=="1"){
            document.getElementById("label_"+id).innerHTML="该项不能为空";
            $('#canSubmit_'+id).val(0);
            return false;
        }
    }else{
        switch(text_type){
            case "number":
                var reg = new RegExp("^[0-9]*$");
                var min_length=args.getAttribute("min_length");
                var max_length=args.getAttribute("max_length");
                if(reg.test(value)){
                    if((min_length!=0&&value.length<min_length)||(max_length!=0&&value.length>max_length)){
                        document.getElementById("label_"+id).innerHTML="数字长度必须在"+min_length+"-"+max_length+"之间";
                        $('#canSubmit_'+id).val(0);
                        return false;
                    }
                }else{
                    document.getElementById("label_"+id).innerHTML="输入内容必须为数字";
                    $('#canSubmit_'+id).val(0);
                    return false;
                }
                document.getElementById("label_"+id).innerHTML="";
                $('#canSubmit_'+id).val(1);
                return true;
            case "phone":
                var reg = new RegExp("^[0-9]{11}$");
                if(!reg.test(value)){
                    document.getElementById("label_"+id).innerHTML="请输入正确的手机号码";
                    $('#canSubmit_'+id).val(0);
                    return false;
                }
                document.getElementById("label_"+id).innerHTML="";
                $('#canSubmit_'+id).val(1);
                return true;
            case "email":
                var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
                if(!reg.test(value)){
                    document.getElementById("label_"+id).innerHTML="请输入正确的邮箱地址";
                    $('#canSubmit_'+id).val(0);
                    return false;
                }
                document.getElementById("label_"+id).innerHTML="";
                $('#canSubmit_'+id).val(1);
                return true;
            case "string":
                var min_length=args.getAttribute("min_length");
                var max_length=args.getAttribute("max_length");
                if((min_length!=0&&value.length<min_length)||(max_length!=0&&value.length>max_length)){
                    if(max_length==0){
                        max_length='';
                    }
                    document.getElementById("label_"+id).innerHTML="字符串长度必须在"+min_length+"-"+max_length+"之间";
                    $('#canSubmit_'+id).val(0);
                    return false;
                }
                document.getElementById("label_"+id).innerHTML="";
                $('#canSubmit_'+id).val(1);
                return true;
        }
    }
}
function check_textarea(args,id){
    var value=document.getElementById("expand_"+id).value;
    var required=args.getAttribute("require");
    if(value.length==0){
        if(required=="1"){
            document.getElementById("label_"+id).innerHTML="该项不能为空";
            $('#canSubmit_'+id).val(0);
            return false;
        }
    }else{
        var min_length=args.getAttribute("min_length");
        var max_length=args.getAttribute("max_length");
        if((min_length!=0&&value.length<min_length)||(max_length!=0&&value.length>max_length)){
            if(max_length==0){
                max_length='';
            }
            document.getElementById("label_"+id).innerHTML="文本长度必须在"+min_length+"-"+max_length+"之间";
            $('#canSubmit_'+id).val(0);
            return false;
        }
    }
    document.getElementById("label_"+id).innerHTML="";
    $('#canSubmit_'+id).val(1);
    return true;
}
$(document).ready(function(){
    $(":submit[id=submit_btn]").click(function(check){

        var canSubmit=true;
        $('.canSubmit').each(function(){
            if($(this).val()==0){
                canSubmit=false;
            }
        });
        if(!canSubmit){
            check.preventDefault();
        }
    });
});