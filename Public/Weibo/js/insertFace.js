
var insertFace = function(obj){
$('.XT_insert').css('z-index','1000');
    $('.XT_face').remove();
    var html ='<div class="XT_face  XT_insert"><div class="triangle sanjiao"></div><div class="triangle_up sanjiao"></div>' +
        '<div class="XT_face_main"><div class="XT_face_title"><span class="XT_face_bt" style="float: left">常用表情</span>' +
        '<a onclick="close_face()" class="XT_face_close">X</a></div><div id="face" style="padding: 10px;"></div></div></div>';
    obj.parent().parent().next().html(html);
    getFace(obj);
}

var face_chose =function(obj){
    var textarea  =obj.parents('.emot_content').prev().find('textarea');
    textarea.focus();
    textarea.val(textarea.val()+'['+obj.attr('title')+']');

}

var getFace=function(obj){
    $.post(U('Weibo/Index/getSmile'), {}, function(data) {
        var _imgHtml='';
        for(var k in data) {
            _imgHtml += '<a href="javascript:void(0)" title="'+data[k].title+'" onclick="face_chose($(this))";><img src="'+data[k].src+'" width="24" height="24" /></a>';
        }
        _imgHtml += '<div class="c"></div>';
        obj.parent().parent().next().find('#face').html(_imgHtml);

    }, 'json');
}

var close_face = function(){
    $('.XT_face').remove();
}