/**
 * Created by 95 on 3/12/14.
 */


//模拟ts U函数
function U(url, params) {
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
    website = website + '.html';
    return website;
}
$(function () {
    ucard();
    bindGoTop();
});
function ucard() {
    $('[ucard]').qtip({ // Grab some elements to apply the tooltip to

        content: {
            text: function (event, api) {
                $.get(U('UserCenter/Public/getProfile'), {uid: $(this).attr('ucard')}, function (userProfile) {

                    var progress = userProfile.score * 1.0 / userProfile.total * 100;
                    var signature = userProfile.signature === '' ? '还没想好O(∩_∩)O' : userProfile.signature;
                    var tpl = $('<div ><p>头衔：' + userProfile.title + '</p><p>积分：' + userProfile.score + '</p>' +
                        '<div style="width: 200px" class="progress progress-striped active"><div class="progress-bar"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: ' + progress + '%"><span class="sr-only">' + progress + '%</span></div></div>'
                        + '<p>个性签名：' + signature + ' </p></div>');

                    api.set('content.text', tpl.html());
                    api.set('content.title', '<b>' + userProfile.username + '</b>的小名片');

                }, 'json');
                return '获取数据中...'
            }
        }, style: {
            classes: 'qtip-shadow qtip-bootstrap'
        }
    })
}
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
function playsound(file) {
    $('embed').remove();
    $('body').append('<embed src="'+file+'" autostart="true" hidden="true" loop="false">');
    var div = document.getElementById('music');
    div.src=file;
}

function op_success(text,title){
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
    toastr.success(text,title);
}
function op_error(text,title){
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
    toastr.error(text,title);
}
function op_info(text,title){
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
    toastr.info(text,title);
}
function op_warning(text,title){
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
    toastr.warning(text,title);
}