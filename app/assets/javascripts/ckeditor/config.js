CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.height = '250px';
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  config.extraPlugins = 'codesnippet,widget,lineutils';
  config.toolbar_easy = [
    '/', {
      name: 'basicstyles',
      items: ['Source','Bold', 'Italic', 'Underline', 'Strike','-', 'RemoveFormat']
    }, {
      name: 'paragraph',
      items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 
             'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Link', 'Unlink', 'Format', 'Font', 'FontSize']
    }, '/', {
      name: 'insert',
      items: ['Image', 'Table', 'HorizontalRule', 'PageBreak', 'CodeSnippet' ]
    }
  ];
  config.toolbar = 'easy';
  return true;
};