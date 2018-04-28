var app = {
    //首页-轮播图
    indexSwiper: function () {
        try {
            var swiper = new Swiper('.swiper-container', {
                nextButton: '.swiper-button-next',
                prevButton: '.swiper-button-prev',
                pagination: '.swiper-pagination',
                paginationType: 'fraction',
                autoplay: 2500,
                autoplayDisableOnInteraction: false
            });
        } catch (e) {
        }
    },
    //星座频道页
    xzTab: function () {
        var xzTit = [
            '白羊座','金牛座','双子座','巨蟹座','狮子座','处女座','天秤座','天蝎座','射手座','摩羯座','水瓶座','双鱼座'
        ]
        var xzTxt = [
            '白羊座男生的23个特点 假设你知道自己想要的东西是什么。如果是寻欢找乐，白羊座男人身上要多少有多少',
            '222',
            '333',
            '444',
            '555',
            '666',
            '777',
            '888',
            '999',
            '10',
            '11',
            '12'
        ];
        $('#xzTab a').on('click',function () {
            $(this).addClass('current').siblings().removeClass('current');
            var z = $(this).attr ( 'data-value') ;//自定义属性 data-value="1"
            $('#xzPic img').attr("src","../statics/images/xz/" + z + ".png");//对应图片
            $('#xzWords').html(xzTit[$(this).index()]);//索引
            $('#xzTxt').html(xzTxt[$(this).index()]);//索引
        })

    },
    //生肖频道页
    sxTab: function () {
        var tit = [
            '鼠','牛','虎','兔','龙','蛇','马','羊','猴','鸡','狗','猪'
        ]
        var txt = [
            '白羊座充满了正义感者的领导风范，但在方法上总到意想不到的失败。这会使老天所赐予的天赋从此偃旗息鼓，难有用武之地。此偃旗息鼓，难有用武之地此偃旗息鼓，难有用武之地',
            '222',
            '333',
            '444',
            '555',
            '666',
            '777',
            '888',
            '999',
            '10',
            '11',
            '12'
        ];
        $('#sxTab a').on('click',function () {
            $(this).addClass('current').siblings().removeClass('current');
            var z = $(this).attr ( 'data-value') ;//自定义属性 data-value="1"
            $('#sxPic img').attr("src","../statics/images/sx/" + z + ".png");//对应图片
            $('#sxWords').html(tit[$(this).index()]);//索引
            $('#sxTxt').html(txt[$(this).index()]);//索引
        })

    }
}
$(function() {
    //遍历执行app中的方法
    for (var key in app) {
        typeof app[key] == 'function' && app[key]();
    }
})

