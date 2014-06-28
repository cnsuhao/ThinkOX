/**
 * Created by 95 on 3/21/14.
 */

var atwho_config;

$(function () {
    atwho_config = {
        at: "@",
        data: U('Weibo/Index/atWhoJson'),
        tpl: "<li data-value='@${nickname}'><img class='avatar-img' style='width:2em;margin-right: 0.6em' src='${avatar32}'/>${nickname}</li>",
        show_the_at: true,
        search_key: 'search_key',
        start_with_space: false
    };

    /**
     * 点击评论按钮后提交评论
     */
    $(document).on('click', '.weibo-comment-commit', function () {
        var weiboId = $(this).attr('data-weibo-id');
        var weibo = $('#weibo_' + weiboId);
        var content = $('.weibo-comment-content', weibo).val();
        var url = U('Weibo/Index/doComment');
        var commitButton = $('.weibo-comment-commit', weibo);
        var weiboCommentList = $('.weibo-comment-list', weibo);
        var originalButtonText = commitButton.text();
        commitButton.text('正在发表...').attr('class', 'btn btn-primary disabled');
        var weiboToCommentId = $('#weibo-comment-to-comment-id', weibo);
        comment_id = weiboToCommentId.val();
        $.post(url, {weibo_id: weiboId, content: content, comment_id: comment_id}, function (a) {
            handleAjax(a);
            if (a.status) {
                reloadWeiboCommentList(weiboCommentList);












                weiboCommentList.attr('data-weibo-comment-loaded', '1');
                var weiboId = weiboCommentList.attr('data-weibo-id');
                var weibo = $('#weibo_' + weiboId);
                var weiboContainer = $('.weibo-comment-container', weiboCommentList);
                var url = U('Weibo/Index/commentlist');
                $.post(url, {weibo_id: weiboId}, function (a) {

                    $('#show_comment_'+weiboId).html(a);
                    $('#btn_showall').hide()
                    var commentLinkText = $('.operation', weiboContainer).html();
                    $('.operation', weibo).html(commentLinkText);
                    commitButton.text(originalButtonText);
                    commitButton.attr('class', 'btn btn-primary weibo-comment-commit');
                    $('.weibo-comment-content', weibo).val('');
                });



            } else {
                commitButton.text(originalButtonText);
                commitButton.attr('class', 'btn btn-primary weibo-comment-commit');
            }
        });
    });

    /**
     * 点击删除后删除微博
     */
    $(document).on('click', '.weibo-comment-del', function (e) {
        var weibo_id = $(this).attr('data-weibo-id');
        var $this = $(this);
        $.post(U('Weibo/Index/doDelWeibo'), {weibo_id: weibo_id}, function (msg) {
            if (msg.status) {
                $this.parent().parent().parent().parent().parent().next().fadeOut();
                $this.parent().parent().parent().parent().parent().fadeOut();
                op_success('删除微博成功。', '温馨提示');
            }
        }, 'json');
        //取消默认动作
        e.preventDefault();
        return false;
    });

    /**
     * 点击评论之后载入评论
     */
    $(document).on('click', '.weibo-comment-link', function (e) {
        var weibo_id = $(this).attr('data-weibo-id');
        var weiboCommentList = $('#weibo_' + weibo_id + ' .weibo-comment-list');
        if (weiboCommentList.is(':visible')) {
            hideWeiboCommentList(weiboCommentList);
        } else {
            showWeiboCommentList(weiboCommentList);
        }
        //取消默认动作
        e.preventDefault();
        return false;
    });
    if (typeof(auto_open_detail) != 'undefined') {
        $('.weibo-comment-link').click();
    }
});


/*微博应用使用的js*/

/**
 * 评论微博
 * @param obj
 * @param comment_id 评论ID
 */
function weibo_reply(obj, comment_id, comment_object) {
    var weiboId = $(obj).attr('data-weibo-id');

    var weibo = $('#weibo_' + weiboId);
    var textarea = $('.weibo-comment-content', weibo);
    var content = textarea.val();
    var weiboToCommentId = $('#weibo-comment-to-comment-id', weibo);
    weiboToCommentId.val(comment_id);
    textarea.focus();
    textarea.val('回复 @' + comment_object + ' ：');
}
/**
 * 评论微博
 * @param obj
 * @param comment_id 评论ID
 */
function comment_del(obj, comment_id) {
    var url = U('Weibo/Index/doDelComment');
    var $this = $(obj);
    $.post(url, {comment_id: comment_id}, function (msg) {
        if (msg.status) {
            var weiboId = $this.attr('data-weibo-id');
            var weibo = $('#weibo_' + weiboId);
            var weiboCommentList = $('.weibo-comment-list', weibo);
            reloadWeiboCommentList(weiboCommentList);
            op_success('删除微博成功。', '温馨提示');
        } else {
            op_error(msg.info, '温馨提示');
        }
    }, 'json');

}


/**
 * 显示微博列表
 * @param weiboCommentList
 */
function showWeiboCommentList(weiboCommentList) {
    //判断是否已经载入
    var weiboContainer = $('.weibo-comment-container', weiboCommentList);
    var loaded = weiboCommentList.attr('data-weibo-comment-loaded');

    //如果已经载入，只要显示即可
    if (loaded) {
        weiboCommentList.show();
        return;
    }
    //显示“正在加载评论”
    weiboContainer.html('<span class="text-muted">正在加载...</span>');
    weiboCommentList.show();

    //通过服务器载入评论列表
    reloadWeiboCommentList(weiboCommentList);
}

function hideWeiboCommentList(weiboCommentList) {
    weiboCommentList.hide();
}

/**
 * 重新读入微博评论列表
 * @param weiboCommentList
 */
function reloadWeiboCommentList(weiboCommentList) {
    //标记为已经载入
    weiboCommentList.attr('data-weibo-comment-loaded', '1');

    var weiboId = weiboCommentList.attr('data-weibo-id');

    var weibo = $('#weibo_' + weiboId);
    var weiboContainer = $('.weibo-comment-container', weiboCommentList);
    var url = U('Weibo/Index/loadComment');
    $.post(url, {weibo_id: weiboId}, function (a) {
        weiboContainer.html(a);
        //更新评论数量
        var commentLinkText = $('.operation', weiboContainer).html();
        $('.operation', weibo).html(commentLinkText);

    });
}




/*微博表情*/

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
    //textarea.val(textarea.val()+'['+obj.attr('title')+']');

    pos = getCursortPosition(textarea[0]);
    s = textarea.val();
    textarea.val(s.substring(0, pos)+'['+obj.attr('title')+']'+s.substring(pos));
    setCaretPosition(textarea[0],pos+2+obj.attr('title').length);
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


function getCursortPosition (ctrl) {//获取光标位置函数

    var CaretPos = 0;	// IE Support
    if (document.selection) {
        ctrl.focus ();
        var Sel = document.selection.createRange ();
        Sel.moveStart ('character', -ctrl.value.length);
        CaretPos = Sel.text.length;
    }
    // Firefox support
    else if (ctrl.selectionStart || ctrl.selectionStart == '0')
        CaretPos = ctrl.selectionStart;
    return (CaretPos);
}

function setCaretPosition(ctrl, pos){//设置光标位置函数
    if(ctrl.setSelectionRange)
    {
        ctrl.focus();
        ctrl.setSelectionRange(pos,pos);
    }
    else if (ctrl.createTextRange) {
        var range = ctrl.createTextRange();
        range.collapse(true);
        range.moveEnd('character', pos);
        range.moveStart('character', pos);
        range.select();
    }
}

/*微博表情end*/