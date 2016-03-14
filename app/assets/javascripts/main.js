//= require jquery2
//= require jquery.bpopup
//= require jquery.nicescroll.min
//= require likely
//= require menu

// js
$(document).ready(function() {

    // Кастомный скролл
    $("html").niceScroll({
        cursorcolor: "#000",
        cursorborder: "1px solid transparent",
        zindex: '5000',
        scrollspeed: 70,
        disablemutationobserver: true,
        // touchbehavior: true,
        cursorminheight: 150,
        cursorfixedheight: 150,
    });

    // Якоря
    // Desctop
    $('#Dbtncon').on('click', function(e) {
        $('html,body').stop().animate({ scrollTop: $('#dtask').offset().top }, 1000);
        e.preventDefault();
    });
    // Mobile
    $('#Mbtncon').on('click', function(e) {
        $('html,body').stop().animate({ scrollTop: $('#mtask').offset().top }, 1000);
        e.preventDefault();
    });

        $('#menuCon').on('click', function(e) {
            if (Modernizr.mq('(max-width: 1025px)')){
                $('html,body').stop().animate({ scrollTop: $('#mtask').offset().top }, 1000);
            } 
            else {
            $('html,body').stop().animate({ scrollTop: $('#dtask').offset().top }, 1000);
            }
            
            e.preventDefault();
        });





    // popup
    var url = $('#youtube').attr('src');
    $('.videopopup').bind('click', function(e) {

        // Prevents the default action to be triggered. 
        e.preventDefault();

        // Triggering bPopup when click event is fired
        $('#ck2').bPopup({
            onOpen: function() { $('#youtube').attr('src', url); },
            onClose: function() { $('#youtube').attr('src', ''); }

        });


    });

    // var aTop = $('.mainHeader-leftBlock__header').height();
    // $('.wrapper').css({ "height": (aTop+404) });
    //  $('.circle2').css({"top" : ( .9 * $(window).scrollTop() ) -100 })
    // $('.circle3').css({ "top": (.4 * $(window).scrollTop()) - 200})
    // $('.circle4').css({ "top": (.3 * $(window).scrollTop()) - 80})
    // $('.topstar2').css({ "top": (.1 * $(window).scrollTop()) - 20})


});
$(window).on("scroll", function() {



    if (Modernizr.mq('(min-width: 1025px)')) {
        $('.circle2').css({ "top": (.9 * $(window).scrollTop()) - 100 })
        $('.circle3').css({ "top": (.4 * $(window).scrollTop()) - 200 })
        $('.circle4').css({ "top": (.2 * $(window).scrollTop()) - 80 })
        $('.topstar2').css({ "top": (.1 * $(window).scrollTop()) - 60 })
        $('.topstar3').css({ "top": (.1 * $(window).scrollTop()) - 180 })
        $('.circle1').css({ "top": (.3 * $(window).scrollTop()) - 120 })
    }


    // If I want the parallax balls to also fade out as you scroll ...
    // $('.circle1').css({"top" : ( .5 * $(window).scrollTop() ) ,        "opacity" : ($(window).height() / $(document).scrollTop() ) -.5 })
    // $('.circle2').css({"top" : ( .2 * $(window).scrollTop() ) +200,    "opacity" : ($(window).height() / $(document).scrollTop() ) -.5 })
    // $('.circle3').css({"top" : ( .4 * $(window).scrollTop() ) +20 ,    "opacity" : ($(window).height() / $(document).scrollTop() ) -.5 })
    // $('.circle4').css({"top" : ( .3 * $(window).scrollTop() ) +150,    "opacity" : ($(window).height() / $(document).scrollTop() ) -.5 })
});

$(window).on("load resize scroll", function(e) {
    if (Modernizr.mq('(min-width: 1025px)')) {
        var distanceTop = '400';
        if ($(window).scrollTop() > distanceTop)
            $('.mainHeader').css({ position: "absolute", top: 400 });


        else
            $('.mainHeader').css({ position: "fixed", top: 0 }),
            $('.circle1').css({ top: 0 });
    }
    var hT = $('#Task').offset().top,
        hH = $('#Task').outerHeight(true),
        hTrule = $('#Rule').offset().top,
        hHrule = $('#Rule').outerHeight(true),
        wH = $(window).outerHeight(true),
        wS = $(window).scrollTop();
    // console.log(hT , hH);
    if (wS > (hT + (hH * 1 + 32) - wH)) {
        $('.topMenu__item').css({ "color": '#000' });
        $('.topMenu').css({ 'border-color': '#000' });
        // alert('end reached');
    } else {
        $('.topMenu__item').css({ "color": '#fff' });
        $('.topMenu').css({ 'border-color': '#fff' });
    }
    if (wS > (hTrule + (hH * 1 + 32) - wH)) {
        $('.topMenu__item').css({ "color": '#fff' });
        $('.topMenu').css({ 'border-color': '#fff' });
        // alert('end reached');
    }
});

// $(window).resize(function(){
//   var aTop = $('.mainHeader-leftBlock__header').height();
//     $('.wrapper').css({ "height": (aTop+404) });
// });
// $(function(){
//   $(window).scroll(function(){
//     var aTop = $('.mainHeader-leftBlock__header').height();
//     var top = (aTop-1069);
//     if($(this).scrollTop()>=top){
//         // $('.circle1').css({ "top": (.2 * $(window).scrollTop()) + 80 });
//     }
//   });
// });
