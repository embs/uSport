$(function() {
  $('.expander').click(function() {
    var $this = $(this);
    var $id = $this.id
    var $container = $this.parents('.page-header');
    var $listItem = $container.find('.expand-help#' + $this[0].id);

    if($listItem.hasClass('open')) {
      $listItem.slideUp(150, 'swing');
      $this.find('i').removeClass('icon-chevron-down').addClass('icon-chevron-right');
    } else {
      $listItem.slideDown(150, 'swing');
      $this.find('i').removeClass('icon-chevron-right').addClass('icon-chevron-down');
    }

    $listItem.toggleClass('open');
  });
});
