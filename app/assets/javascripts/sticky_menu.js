// http://getbootstrap.com/javascript/#affix

// http://stackoverflow.com/questions/18683303/bootstrap-3-0-affix-with-list-changes-width
// https://github.com/twbs/bootstrap/issues/6350

// function set_sticky_panel(param="")  {
function set_sticky_panel()  {  

  // alert($(document).scrollTop());

  var affixElement = $('#navbar-main');

  // var navbarElementHeight = "0";

//   if ($('#top_navbar').length) {
// // http://stackoverflow.com/questions/31044/is-there-an-exists-function-for-jquery    
//     navbarElementHeight = $('#top_navbar').height();
//   }

  var width = affixElement.parent().width();
  affixElement.width(width);

// http://stackoverflow.com/questions/3410765/get-full-height-of-element
  var affixElementHeight = $('#navbar-main').outerHeight(true);

// https://finiteheap.com/webdev/2014/12/26/bootstrap-affix-flickering.html  
  affixElement.parent().height(affixElementHeight);

// http://stackoverflow.com/questions/23797241/resetting-changing-the-offset-of-bootstrap-affix
  $(window).off('.affix')
  affixElement.removeData('bs.affix').removeClass('affix affix-top affix-bottom')


  affixElement.affix({
    offset: {
    // Distance of between element and top page
      top: function () {
      // how much scrolling is done until sticking the panel
      // alert(parseInt($('#ymap_container').height(),10));
// http://stackoverflow.com/questions/178325/how-to-check-if-an-element-is-hidden-in-jquery      
        // return (this.top = affixElement.offset().top - parseInt(navbarElementHeight,10))
        return (this.top = affixElement.offset().top)
        // console.log(affixElement.offset().top + " " + param);
        // return (this.top = affixElement.offset().top)
        // return (this.top = affixElement.offset().top + 387)        
      }
    }
  });


  // affixElement.on('affix.bs.affix', function (){
  // the absolute position where the sticked panel is to be located
    // affixElement.css('top', navbarElementHeight + 'px');
    affixElement.css('top', 0);
    affixElement.css('z-index', 10);
    // alert('affix.bs.affix');
  // });
// alert("set_sticky_panel");
}

$(document).on('ready', set_sticky_panel);

$(window).resize(set_sticky_panel);