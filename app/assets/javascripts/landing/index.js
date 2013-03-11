$(document).ready(function(){
  tbAdaptor();

  $(window).resize(function() {
    //resize just happened, pixels changed
    tbAdaptor();
  });
});

function tbAdaptor(){
  // adjust the span of various columns to match the screen size
  // all adjustments are pulled from the HTML attributes
  //
  // inital
  var docWidth = $(document).width();

  //first save the default value
  $(".span1, .span2, .span3, .span4, .span5, .span6, .span7, .span8, .span9, .span10, .span11, .span12").not("div[tb-d]").each(function(index){
    $(this).attr("tb-d",$(this).attr("class"));
  });

  if (docWidth>=1600){
    $("div[tb-g-1600]").each(function(index){
      $(this).removeClass("row-fluid span1 span2 span3 span4 span5 span6 span7 span8 span9 span10 span11 span12 hide").addClass($(this).attr("tb-g-1600"));
    });
  }else if (docWidth>=1400){
    $("div[tb-g-1400]").each(function(index){
      $(this).removeClass("row-fluid span1 span2 span3 span4 span5 span6 span7 span8 span9 span10 span11 span12 hide").addClass($(this).attr("tb-g-1400"));
    });
  }else if (docWidth>=1200){
    $("div[tb-g-1200]").each(function(index){
      $(this).removeClass("row-fluid span1 span2 span3 span4 span5 span6 span7 span8 span9 span10 span11 span12 hide").addClass($(this).attr("tb-g-1200"));
    });
  }else if(docWidth>=980){
    $("div[tb-d]").each(function(index){
      $(this).removeClass("row-fluid span1 span2 span3 span4 span5 span6 span7 span8 span9 span10 span11 span12 hide").addClass($(this).attr("tb-d"));
    });
  }else if(docWidth>=768){
    $("div[tb-768-980]").each(function(index){
      $(this).removeClass("row-fluid span1 span2 span3 span4 span5 span6 span7 span8 span9 span10 span11 span12 hide").addClass($(this).attr("tb-768-980"));
    });
  }
}
