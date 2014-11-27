function addTimeLine() {
	$length = $(".slider li").length;
	$plan = $("#plan");
	
	$plan.append('<li class="activeButton"></li>');
	for($i=1; $i<$length; ++$i)
		$plan.append('<li class="otherButton"></li>');
}
			
$(function(){
	$("#pause").click(function() {
		$(this).dequeue();
		clearInterval(timer);
		$("#play").show();
		$("#pause").hide();
	});

	$("#play").click(function() {
		clearInterval(timer);
		timer = setInterval(nextDiapo, slideInterval);
		$("#pause").show();
		$("#play").hide()
	});

	$("#next").click(function() {
		var taille = -1*$(".slider li").width();
		$(".slider").animate({marginLeft:-1800},1000,function(){  
			$(this).css({marginLeft:-900}).find(".slider li:last").after($(this).find(".slider li:first"));  
		});
	});

	$('#prev').click(function(){
		var taille = -1*$(".slider li").width();
		 $(".slider").animate({marginLeft:0},1000,function(){  
			$(this).css({marginLeft:-900}).find(".slider li:first").before($(this).find(".slider li:last"));  
		}) 
	});
});










