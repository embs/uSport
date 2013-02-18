$(document).ready(function () {
	$(".popup").mousemove(function (event) {
		$("#oculta").html($(this).html());
		$("#oculta").css("display", "block");
		$("#oculta").css("position", "absolute");
		$("#oculta").css("top", (event.pageY + 10) + "px");
		$("#oculta").css("left", (event.pageX + 10) + "px");
		$("#oculta").css("padding", "10px");
	})

	$(".popup").mouseout(function () {
		$("#oculta").css("display", "none");
	})
})