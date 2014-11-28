function addTimeLine() {
	$length = $(".slider li").length;
	$plan = $("#plan");
	
	$plan.append('<li class="activeButton"><a></a></li>');
	for($i=1; $i<$length; ++$i)
		$plan.append('<li><a></a></li>');
}

function goTo(indexLi) {
	$currentSlide = $("#plan li").eq(indexLi);
	$capt = $currentSlide.find(".picCaption");
	($capt.html() != "") ? $capt.show() : $capt.hide();
	
	$("#timeline").html((currentIndex+1) + "/" + $lastChild);
	$("#plan li").removeClass("activeButton");
	$currentSlide.addClass("activeButton");
}

function prevDiapo() {
	var transi = Math.round(Math.random() * (2 - 1) + 1);
	//$formerDiapo = $(".slider li").eq(currentIndex).hide();
	currentIndex = (currentIndex == 0) ? $(".slider li").length-1 : currentIndex-1;
	
	/*switch(transi) {
		case 1 :
				$("#next, #prev").unbind("click");
				$(".slider li").fadeIn(600, function() {
					$("#next").click(nextDiapo);
					$("#prev").click(prevDiapo);
				});
				break;
		case 2 : */
				$(".slider").dequeue().animate({marginLeft:0},1000,function(){  
					$(this).css({marginLeft:-900}).find("li:first").before($(this).find("li:last"));  
				});
			/*	break;
		default : break;
	}*/
	
	goTo(currentIndex);
}

function nextDiapo() {
	var transi = Math.round(Math.random() * (2 - 1) + 1);
	//$formerDiapo = $(".slider li").eq(currentIndex).hide();
	currentIndex = (currentIndex == ($(".slider li").length-1)) ? 0 : currentIndex+1;
	
	/*switch(transi) {
		case 1 :
				$("#next, #prev").unbind("click");
				$(".slider li").eq(currentIndex).fadeIn(600, function() {
					$("#next").click(nextDiapo);
					$("#prev").click(prevDiapo);
				});
				break;
		case 2 : */
				$(".slider").dequeue().animate({marginLeft:-1800},1000,function(){  
					$(this).css({marginLeft:-900}).find("li:last").after($(this).find("li:first"));  
				});				
			/*	break;
		default : break;
	}*/
	
	goTo(currentIndex);
}

$(function() {
	$(".containerSlide").bind("mouseenter", function() { if($("#play").is(":hidden")) { clearInterval(timer) }})
						.bind("mouseleave", function() { if($("#play").is(":hidden")) { timer = setInterval(nextDiapo, slideInterval) }});

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
		$("#play").hide();
	});
        
	//ffdsfsfd
	$("#plan li").live("click", function() {
		var index = $("#plan li").index($(this));
		$currentSlide = $(".slider li").eq(index);
		$formerSlide = $(".slider li").eq(currentIndex);
		goTo(index);
		
		$formerSlide.hide();
		$currentSlide.show();
		
		currentIndex = index; 
		$("#pause").trigger("click");
	});
		
	
	$("#next").click(nextDiapo);
	$('#prev').click(prevDiapo);
});
