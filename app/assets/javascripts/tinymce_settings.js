
//<![CDATA[
(function() {
  if (typeof tinyMCE != 'undefined') {
    tinyMCE.init({
//     // theme: "modern",
//     mode : "specific_textareas",
//     menubar: false,
//     statusbar: false,    
//     toolbar: "bold,italic,underline,|,bullist,numlist,outdent,indent,|,undo,redo,|,pastetext,pasteword,selectall,|,uploadimage",
//     pagebreak_separator: "<p class='page-separator'>&nbsp;</p>",
//     selector: "textarea.tinymce",
//     // toolbar: ["styleselect | bold italic | undo redo","uploadimage | link"],
//     plugins: "link,uploadimage",
// // http://stackoverflow.com/questions/8863366/tinymce-inserting-image-wrong-path      
//     relative_urls: false,
//     language: "ru",
//     fontsize_formats: "8px 10px 12px 14px 16px 18px 20px 24px 36px"

          selector: '.tinymce',
          mode : "specific_textareas",
          menubar: false,
          statusbar: false,
          relative_urls : false,
          language: "ru",
          fontsize_formats: "8px 10px 12px 14px 16px 18px 20px 24px 36px",

          // plugins: 'code preview lists autoresize link uploadimage',
          plugins: 'link uploadimage preview',          
          paste_word_valid_elements: "b,strong,i,em,h1,h2,table,tr,td,th,tbody,thead",
          toolbar: "removeformat | fontsizeselect | bold italic | undo redo | bullist numlist | alignleft | aligncenter | alignright | link | uploadimage | code preview",
          content_css : "/tinymce/tinymce.css",
          uploadimage_default_img_class: "tinymce_image",
    //       setup : function(ed) {

    //           if ($('#'+ed.id).prop('readonly')) {
    //           ed.settings.readonly = true;
    //           }

    //           ed.on('keydown', function(event) {
    //             if (event.keyCode == 9) {
    //               ed.execCommand('mceInsertContent', false, '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
    //               event.preventDefault();                  
    //               return false;
    //             }
    //           });

    //           ed.on('change', function(e) {
    //             watcher();
    //             $scope.ngModel = ed.getContent();
    //             $scope.$apply();                
    //           });
    //        }
    });

        tinyMCE.addI18n('ru', {
          'Insert an image from your computer': 'Загрузите изображение с вашего компьтера',
          'Insert a file from your computer': 'Загрузите файл с вашего компьютера',
          'Insert image': "Загрузить изображение",
          'Choose an image': "Выбрать изображение",
          'Choose a file': "Выбрать файл",
          'You must choose a file': "Вы должны выбрать файл",
          'Got a bad response from the server': "Ошибка сервера",
          "Didn't get a response from the server": "Ответ не получен",
          'Insert': "Готово",
          'Cancel': "Отмена",
          'Image description': "Описание",
          'File description': "Описание",          
        }); 
            
  } else {
    setTimeout(arguments.callee, 50);
  }
})();

//]]>
