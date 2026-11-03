/**
 * Exponential Admin UI: the preview of a version (content/view/versionview.tpl): the preview frame takes the size
 * of the device button picked (remembered in localStorage) and follows the window in the desktop size.
 */
$(document).ready(function(){
    $('.content-body').addClass('contentPreview');

    /* preview iframe resizing */
    (function(){
        var frame = $('#preview-frame'),
            container = $('.preview-frame-container'),
            containerDesign = $('.container-design'),
            initialW = localStorage.getItem('previewIframeW'),
            initialH = localStorage.getItem('previewIframeH'),
            control = $('.iframe-control'),
            sizes = [],
            screenW = $(document).width(),
            contHeight = function(){
                var fContainer = $('.preview-page'),
                    fContainerH = $(document).height() - fContainer.offset().top - (parseInt(fContainer.css('padding-top'), 10) * 2) - 20;
                return fContainerH;
            },
            sizing = function(w, h){
                container.width(w).height(h);
                containerDesign.width(w).height(h);
                frame.width(w).height(h);
            }
            switching = function(el, w, h){
                containerDesign.attr('class', 'container-design');
                switch (w) {
                    case '320':
                        containerDesign.addClass('mobile-vertical');
                        break;
                    case '480':
                        containerDesign.addClass('mobile-horizontal');
                        break;
                    case '768':
                        containerDesign.addClass('tablet-vertical');
                        break;
                    case '1024':
                        containerDesign.addClass('tablet-horizontal');
                        break;
                    default:
                        containerDesign.addClass('desktop');
                        h = contHeight();
                }
                el.addClass('active').siblings().removeClass('active');
                sizing(w, h);
            };
        control.children('.btn').each(function(){
            sizes.push($(this).attr('data-width'));
        });
        if(initialW == undefined) {
            var i = Math.max.apply(Math, sizes.filter(function(x){return x <= screenW})),
                initialTrigger = $('.btn[data-width=' + i + ']');
            initialW = initialTrigger.attr('data-width');
            initialH = initialTrigger.attr('data-height');
        } else {
            var initialTrigger = $('.btn[data-width=' + initialW + ']');
        }
        switching(initialTrigger, initialW, initialH);
        control.on('click', '.btn', function(){
            var trigger = $(this),
                frameW = trigger.attr('data-width'),
                frameH = trigger.attr('data-height');
            localStorage.setItem('previewIframeW', frameW);
            localStorage.setItem('previewIframeH', frameH);
            switching(trigger, frameW, frameH);
        });
        $(window).on('resize', function(){
            if(containerDesign.hasClass('desktop')) {
                var contW = containerDesign.width();
                sizing(contW, contHeight());
            }
        });
    })();

});
