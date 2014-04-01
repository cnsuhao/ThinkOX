$(function () {

    var reply_btn = $('.reply_btn');
    reply_btn.click(function () {

        var args = getArgs($(this).attr('args'))
        var to_f_reply_id = args['to_f_reply_id'];
        $('#show_textarea_' + to_f_reply_id).show();

        $('#reply_' + to_f_reply_id).val('回复@' + args['to_username'] + ' ：');
        $('#submit_' + to_f_reply_id).attr('args', $(this).attr('args'));

    })


    $('.input_tips').keypress(function (e) {
        if (e.ctrlKey && e.which == 13 || e.which == 10) {
            var re = $(this).attr('args');
            var args = getArgs($('#submit_' + re).attr('args'));

            var to_f_reply_id = args['to_f_reply_id'];
            var post_id = $('#submit_' + re).attr('post_id');
            var content = $('#reply_' + to_f_reply_id).val();
            var to_reply_id = args['to_reply_id'];
            var to_uid = args['to_uid'];
            submitLZLReply(post_id, to_f_reply_id, to_reply_id, to_uid, content);
        }
        this.preventDefault();
    });

    var submitLZLReply = function (post_id, to_f_reply_id, to_reply_id, to_uid, content) {
        var url =U('Forum/LZL/doSendLZLReply');

        $.post(url, {post_id: post_id, to_f_reply_id: to_f_reply_id, to_reply_id: to_reply_id, to_uid: to_uid, content: content}, function (msg) {
            if (msg.status) {
                op_success(msg.info, '温馨提示');
                $('#lzl_reply_list_' + to_f_reply_id).load(U('Forum/LZL/lzlList&to_f_reply_id=' + to_f_reply_id + '&page=' + msg.url, '', true), function () {
                    ucard()
                })
                $('#reply_' + to_f_reply_id).val('');
            } else {
                op_error(msg.info, '温馨提示');
            }
        });
    }
    $(".submitReply").click(function () {
        var args = getArgs($(this).attr('args'));
        var to_f_reply_id = args['to_f_reply_id'];
        var post_id = $(this).attr('post_id');
        var content = $('#reply_' + to_f_reply_id).val();
        var to_reply_id = args['to_reply_id'];
        var to_uid = args['to_uid'];

        submitLZLReply(post_id, to_f_reply_id, to_reply_id, to_uid, content);

        this.preventDefault();
    })

    $('.reply_btn').click(function () {
        var args = $(this).attr('args');
        $('#lzl_reply_div_' + args).toggle();
        this.preventDefault();
    });

    $('.show_textarea').click(function () {
        var args = $(this).attr('args');
        $('#show_textarea_' + args).toggle();
        this.preventDefault();
    })


});


var getArgs = function (uri) {
    if (!uri) return {};
    var obj = {},
        args = uri.split("&"),
        l, arg;
    l = args.length;
    while (l-- > 0) {
        arg = args[l];
        if (!arg) {
            continue;
        }
        arg = arg.split("=");
        obj[arg[0]] = arg[1];
    }
    return obj;
};

