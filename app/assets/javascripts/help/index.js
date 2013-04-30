$(function() {
  $('.expander').click(function() {
    var $this = $(this);
    var $container = $this.parents('.page-header');
    var $listItem = $container.find('#sign-up');

    if($listItem.hasClass('open')) {
      $listItem.slideUp(150, 'swing');
    } else {
      $listItem.slideDown(150, 'swing');
      var $icon = $listItem.find('i');
      $icon.html('');
    }

    $listItem.toggleClass('open');
  });
});
