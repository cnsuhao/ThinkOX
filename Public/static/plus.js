/**
 * Created by 95 on 3/12/14.
 */

/**应用初始化
 */
$(function () {
    ucard();//绑定用户小名片
    bindGoTop();//回到顶部
    checkMessage();//检查一次消息
    bindMessageChecker();//绑定用户消息
    bindLogout();
});


/**
 * 模拟U函数
 * @param url
 * @param params
 * @returns {string}
 * @constructor
 */
function U(url, params, rewrite) {
    var website = _ROOT_ + '/index.php';
    url = url.split('/');
    if (url[0] == '' || url[0] == '@')
        url[0] = APPNAME;
    if (!url[1])
        url[1] = 'Index';
    if (!url[2])
        url[2] = 'index';
    website = website + '?s=/' + url[0] + '/' + url[1] + '/' + url[2];
    if (params) {
        params = params.join('/');
        website = website + '/' + params;
    }
    if (!rewrite) {
        website = website + '.html';
    }
    return website;
}

/**
 * 绑定用户小名片
 */
function ucard() {
    $('[ucard]').qtip({ // Grab some elements to apply the tooltip to
        suppress: false,
        content: {
            text: function (event, api) {
                var uid = $(this).attr('ucard');
                $.get(U('UserCenter/Public/getProfile'), {uid: uid}, function (userProfile) {
                    var follow = '';
                    var progress = userProfile.score * 1.0 / userProfile.total * 100;
                    var signature = userProfile.signature === '' ? '还没想好O(∩_∩)O' : userProfile.signature;
                    if ((MID != uid) && (MID != 0)) {
                        follow = '<div class="row" style="background: #f5f5f5;margin: -10px -15px;margin-top: 10px;padding: 5px 10px">' +
                            '<div class="pull-right">' +
                            '<button type="button" class="btn btn-primary" onclick="ufollow(this,' + userProfile.id + ')" style="padding: 5px 10px">';
                        if (userProfile.followed==1) {
                            follow += '已关注';
                        } else {
                            follow += '关注';
                        }
                        follow += '</button></div></div>';
                    }
                    var tpl = $('<div ><p>头衔：' + userProfile.title + '</p><p>积分：' + userProfile.score + '</p>' +
                        '<div style="width: 200px" class="progress progress-striped active"><div class="progress-bar"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: ' + progress + '%"><span class="sr-only">' + progress + '%</span></div></div>'
                        + '<p>个性签名：' + signature + ' </p><p>最后登录：' + friendlyDate(userProfile.last_login_time) + '</p><p>注册时间：' + friendlyDate(userProfile.reg_time) + '</p>' + follow +
                        '</div>');
                    api.set('content.text', tpl.html());
                    api.set('content.title', '<b>' + userProfile.username + '</b>的小名片');

                }, 'json');
                return '获取数据中...'
            }

        }, show: {delay: 500}, style: {
            classes: 'qtip-shadow qtip-bootstrap'
        }, hide: {
            event: 'unfocus'
        }
    })
}
function ufollow(obj, uid) {
    var obj = $(obj);
    if ($(obj).text() == '已关注') {
        $.post(U('UserCenter/Public/unfollow'), {uid: uid}, function (msg) {
            if (msg.status) {
                op_success('取消关注成功。', '温馨提示');
                obj.text('关注');
            } else {
                op_error('取消关注失败。', '温馨提示');
            }
        }, 'json');
    } else {
        $.post(U('UserCenter/Public/follow'), {uid: uid}, function (msg) {
            if (msg.status) {
                op_success('关注成功。', '温馨提示');
                obj.text('已关注');
            } else {
                op_error('关注失败。', '温馨提示');
            }
        }, 'json');
    }

}
/**
 * 绑定回到顶部
 */
function bindGoTop() {
    $(window).scroll(function () {
        var sc = $(window).scrollTop();
        //var rwidth=$(window).width()
        if (sc > 0) {
            $("#goTopBtn").css("display", "block");
            $("#goTopBtn").css("right", "50px")
        } else {
            $("#goTopBtn").css("display", "none");
        }
    })

    $("#goTopBtn").click(function () {
        var sc = $(window).scrollTop();
        $('body,html').animate({scrollTop: 0}, 500);
    });
}
/**播放背景音乐
 *
 * @param file 文件路径
 */
function playsound(file) {
    $('embed').remove();
    $('body').append('<embed src="' + file + '" autostart="true" hidden="true" loop="false">');
    var div = document.getElementById('music');
    div.src = file;
}
/**
 * 成功提示
 * @param text 内容
 * @param title 标题
 */
function op_success(text, title) {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-center",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr.success(text, title);
}
/**
 * 失败提示
 * @param text 内容
 * @param title 标题
 */
function op_error(text, title) {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-center",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr.error(text, title);
}
/**
 * 信息提示
 * @param text 内容
 * @param title 标题
 */
function op_info(text, title) {
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "positionClass": "toast-center",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr.info(text, title);
}
/**
 * 警告提示
 * @param text 内容
 * @param title 标题
 */
function op_warning(text, title) {
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "positionClass": "toast-center",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr.warning(text, title);
}


/**
 * 绑定消息检查
 */
function bindMessageChecker() {
    $hint_count = $('#nav_hint_count');
    $nav_bandage_count = $('#nav_bandage_count');

    setInterval(function () {
        checkMessage();
    }, 10000);
}

/**
 * 检查是否有新的消息
 */
function checkMessage() {
    $.get(U('Usercenter/Public/getMessage'), {}, function (msg) {
        if (msg) {
            playsound('Public/static/plusjs/tip.mp3');
            for (var index in msg) {
                tip_message(msg[index]['content'] + '<div style="text-align: right"> ' + msg[index]['ctime'] + '</div>', msg[index]['title']);
                //  var url=msg[index]['url']===''?U('') //设置默认跳转到消息中心


                var new_html = $('<span><li><a href="' + msg[index]['url'] + '"><i class="glyphicon glyphicon-bell"></i>' +
                    msg[index]['title'] + '<br/><span class="time">' + msg[index]['ctime'] +
                    '</span> </a></li></span>');
                $('#nav_message').prepend(new_html.html());


            }
            var count = parseInt($hint_count.text());
            $hint_count.text(count + msg.length);
            $nav_bandage_count.show();
            $nav_bandage_count.text(count + msg.length);
        }
    }, 'json');
}
/**
 * 将所有的消息设为已读
 */
function setAllReaded() {
    $.post(U('Usercenter/Public/setAllMessageReaded'), function () {
        $hint_count.text(0);
        $('#nav_message').html('');
        $nav_bandage_count.hide();
        $nav_bandage_count.text(0);

    });
}


/**
 * 消息中心提示有新的消息
 * @param text
 * @param title
 */
function tip_message(text, title) {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "1000",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
    toastr.info(text, title);
}
/**
 * 友好时间
 * @param sTime
 * @param cTime
 * @returns {string}
 */
function friendlyDate(sTime, cTime) {
    var formatTime = function (num) {
        return (num < 10) ? '0' + num : num;
    };

    if (!sTime) {
        return '';
    }

    var cDate = new Date(cTime * 1000);
    var sDate = new Date(sTime * 1000);
    var dTime = cTime - sTime;
    var dDay = parseInt(cDate.getDate()) - parseInt(sDate.getDate());
    var dMonth = parseInt(cDate.getMonth() + 1) - parseInt(sDate.getMonth() + 1);
    var dYear = parseInt(cDate.getFullYear()) - parseInt(sDate.getFullYear());

    if (dTime < 60) {
        if (dTime < 10) {
            return '刚刚';
        } else {
            return parseInt(Math.floor(dTime / 10) * 10) + '秒前';
        }
    } else if (dTime < 3600) {
        return parseInt(Math.floor(dTime / 60)) + '分钟前';
    } else if (dYear === 0 && dMonth === 0 && dDay === 0) {
        return '今天' + formatTime(sDate.getHours()) + ':' + formatTime(sDate.getMinutes());
    } else if (dYear === 0) {
        return formatTime(sDate.getMonth() + 1) + '月' + formatTime(sDate.getDate()) + '日 ' + formatTime(sDate.getHours()) + ':' + formatTime(sDate.getMinutes());
    } else {
        return sDate.getFullYear() + '-' + formatTime(sDate.getMonth() + 1) + '-' + formatTime(sDate.getDate()) + ' ' + formatTime(sDate.getHours()) + ':' + formatTime(sDate.getMinutes());
    }
}

/**
 * Ajax系列
 */

/**
 * 处理ajax返回结果
 */
function handleAjax(a) {
    //弹出提示消息
    if (a.status) {
        op_success(a.info);
    } else {
        op_error(a.info);
    }

    //需要跳转的话就跳转
    var interval = 1500;
    if (a.url == "refresh") {
        setTimeout(function () {
            location.href = a.url;
            location.reload();
        }, interval);
    } else if (a.url) {
        setTimeout(function () {
            location.href = a.url;
        }, interval);
    }
}

$(function () {
    /**
     * ajax-form
     * 通过ajax提交表单，通过oneplus提示消息
     * 示例：<form class="ajax-form" method="post" action="xxx">
     */
    $(document).on('submit', 'form.ajax-form', function (e) {
        //取消默认动作，防止表单两次提交
        e.preventDefault();

        //禁用提交按钮，防止重复提交
        var form = $(this);
        $('[type=submit]', form).addClass('disabled');

        //获取提交地址，方式
        var action = $(this).attr('action');
        var method = $(this).attr('method');

        //检测提交地址
        if (!action) {
            return false;
        }

        //默认提交方式为get
        if (!method) {
            method = 'get';
        }

        //获取表单内容
        var formContent = $(this).serialize();

        //发送提交请求
        if (method == 'post') {
            $.post(action, formContent, function (a) {
                handleAjax(a);
                $('[type=submit]', form).removeClass('disabled');
            });
        }

        //返回
        return false;
    });
})


/**
 * 初始化聊天框
 */
function op_initTalkBox() {
    $('#scrollArea').slimScroll({
        height: '400px',
        alwaysVisible: true,
        start: 'bottom'
    });
}
/**
 * 向聊天窗添加一条消息
 * @param html 消息内容
 */
function op_appendMessage(html) {
    $('#scrollContainer').append(html);
    $('#scrollArea').slimScroll({scrollTo: $('#scrollContainer').height()});
    ucard();
}
/**
 * 渲染消息模板
 * @param message 消息体
 * @param mid 当前用户ID
 * @returns {string}
 */
function op_fetchMessageTpl(message, mid) {
    var tpl_right = '<div class="row talk_right">' +
        '<div class="time"><span class="timespan">{ctime}</span></div>' +
        '<div class="row">' +
        '<div class="col-md-10 bubble_outter">' +
        '<h3>我</h3>' +
        '<i class="bubble_sharp"></i>' +
        '<div class="talk_bubble">{content}' +
        '</div>' +
        '</div>' +
        ' <div class="col-md-2 "><img ucard="{uid}" class="avatar-img talk-avatar"' +
        'src="{avatar128}"/>' +
        '</div> </div> </div>';

    var tpl_left = '<div class="row">' +
        '<div class="time"><span class="timespan">{ctime}</span></div>' +
        '<div class="row">' +
        '<div class="col-md-2 "><img ucard="{uid}" class="avatar-img talk-avatar"' +
        'src="{avatar128}"/>' +
        '</div><div class="col-md-10 bubble_outter">' +
        '<h3>{username}</h3>' +
        '<i class="bubble_sharp"></i>' +
        '<div class="talk_bubble">{content}' +
        '</div></div></div></div>';
    var tpl = message.uid == mid ? tpl_right : tpl_left;
    $.each(message, function (index, value) {
        tpl = tpl.replace('{' + index + '}', value);
    });
    return tpl;
}
/**
 * 绑定登出事件
 */
function bindLogout() {
    $('[event-node=logout]').click(function () {
        $.get(U('userCenter/Index/logout'), function (msg) {
            op_success(msg.message + '。', '温馨提示');
            setTimeout(function () {
                location.href = msg.url;
            }, 1500);
        }, 'json')
    });
}
