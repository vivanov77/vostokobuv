$(document).on('ready', function() {
// http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links	
   $(".regular-slider-4").slick({
     infinite: true,
     slidesToShow: 4,
     slidesToScroll: 1    
   });

   $(".regular-slider-3").slick({
     infinite: true,
     slidesToShow: 3,
     slidesToScroll: 1    
   });

   $(".regular-slider-1").slick({
     infinite: true,
     slidesToShow: 1,
     slidesToScroll: 1    
   });   

   $(".regular-slider-3-2rows").slick({
     infinite: true,
     slidesToShow: 3,
     slidesToScroll: 1,
     rows: 2,
     slidesPerRow: 1
   });


 });