// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.ui.datepicker
//= require private_pub
//= require_tree .

$(function (){
  // single dataset
  $('input.typeahead').typeahead([
    {
      name: 'users',
      remote: 'http://localhost:3000/users.json?q=%QUERY'
    }
  ]);
});

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
