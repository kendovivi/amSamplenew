//html initialize
window.onload=function(){
	
	if (suffix == 1){
		$("#error_msg").show();
	}else {
		$("#error_msg").hide();
	}
	
	/*　selector を使う場合
	//***********************************************
	//set selectors 
	$.each(headers,function(i,header){
		$("#typecolumn1").append($('<option>', { 
	        value: header,
	        text : header 
    	}));
		$("#typecolumn2").append($('<option>', { 
	        value: header,
	        text : header 
        }));
	});	
	//set initial value
	*/
	//***********************************************	
	
	
	
	//dropdown li を使う場合
	//***********************************************
	//set dropdown li
	$.each(headers,function(i,header){
			$('#ul1').append(
    			$('<li>').attr({value: header, onclick: 'showvalue1(this)'}).append(
        			$('<a>').attr('href','#').append(
            			$('<span>').attr('class', 'tab').append(header)
			))); 
			
			$('#ul2').append(
    			$('<li>').attr({value: header, onclick: 'showvalue2(this)'}).append(
        			$('<a>').attr('href','#').append(
            			$('<span>').attr('class', 'tab').append(header)
			)));	
  	});
  	$("#typecolumn2").val(type2);
	$("#typecolumn1").val(type1);
	//***********************************************
	
		
	//***********************************************
	// set times 
    //document.getElementById('start_dt').value = timeshow[0];
    //document.getElementById('start_hm').value = timeshow[1];
	//document.getElementById('finish_dt').value = timeshow[2];
	//document.getElementById('finish_hm').value = timeshow[3];
	document.getElementById('start_dt').value = start_dt;
    document.getElementById('start_hm').value = start_hm;
	document.getElementById('finish_dt').value = finish_dt;
	document.getElementById('finish_hm').value = finish_hm;
	
	//***********************************************	
}

function showvalue1(obj){
    $("#typecolumn1").val(obj.innerText);
}

function showvalue2(obj){
    $("#typecolumn2").val(obj.innerText);
}

function submit(){
 	$("#form").submit();
}