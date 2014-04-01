/**
 * Created by 95 on 3/21/14.
 */

/*微博应用使用的js*/

function weibo_reply(obj,comment_id,comment_object) {
    var weiboId = $(obj).attr('data-weibo-id');

    var weibo = $('#weibo_'+weiboId);
    var textarea=$('.weibo-comment-content', weibo);
    var content =textarea.val();
    var weiboToCommentId=$('#weibo-comment-to-comment-id',weibo);
    weiboToCommentId.val(comment_id);
    textarea.focus();
    textarea.val('回复 '+comment_object+' ：');
}


/**
 * 点击评论按钮后提交评论
 */
$(document).on('click', '.weibo-comment-commit', function () {
    var weiboId = $(this).attr('data-weibo-id');
    var weibo = $('#weibo_'+weiboId);
    var content = $('.weibo-comment-content', weibo).val();
    var url =U('Weibo/Index/doComment');
    var commitButton = $('.weibo-comment-commit', weibo);
    var weiboCommentList = $('.weibo-comment-list', weibo);
    commitButton.text('正在发表...').attr('class', 'btn btn-primary disabled');
    var weiboToCommentId=$('#weibo-comment-to-comment-id',weibo);
    comment_id= weiboToCommentId.val();
    $.post(url, {weibo_id: weiboId, content: content,comment_id:comment_id}, function (a) {
        if (a.status) {
            reloadWeiboCommentList(weiboCommentList);

        } else {
            commitButton.text(a.info).attr('class', 'btn btn-danger weibo-comment-commit');
        }
    });
});


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
        var commentLinkText = $('.weibo-comment-link-text', weiboContainer).text();
        $('.weibo-comment-link', weibo).text(commentLinkText);
    });
}

