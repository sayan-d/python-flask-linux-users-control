/* 
 *     Text fields 
 *     */
$(function(){
	$(document).on('focus', 'div.form-group-options div.input-group-option:last-child input', function(){
		var sInputGroupHtml = $(this).parent().html();
		var sInputGroupClasses = $(this).parent().attr('class');
		$(this).parent().parent().append('<div class="'+sInputGroupClasses+'">'+sInputGroupHtml+'</div>');
	});
	
	$(document).on('click', 'div.form-group-options .input-group-addon-remove', function(){
		$(this).parent().remove();
	});
});

/* 
 *     Selects 
 *     */


$(function(){
    $('.create-delete').css("display", "none");
    $('.enable-disable').css("display", "none");
    $('.setnew-modify').css("display", "none");
    $('.modifyhome').css("display", "none");
    $('.newpass').css("display", "none");
	var values = new Array();
	
	$(document).on('change', '.form-group-multiple-selects .input-group-multiple-select:last-child select', function(){
        
		var selectsLength = $('.form-group-multiple-selects .input-group-multiple-select select').length;
		var optionsLength = ($(this).find('option').length)-1;
		
		if(selectsLength < optionsLength){
                $('.create-delete').hide();
                $('.enable-disable').hide();
	        $('.setnew-modify').hide();
		$('.modifyhome').hide();
	        $('.newpass').hide();
			var sInputGroupHtml = $(this).parent().html();
			var sInputGroupClasses = $(this).parent().attr('class');

            var selected = $(this).val();  
              if(selected == '4') {
               $('.setnew-modify').show();
	       $('.newpass').show();
//                } else {
//               $('.setnew-modify').hide();
                }
            if(selected == '5' || selected == '2') {
               $('.enable-disable').show();
//               $(this).parent().parent().addClass('enable-disable');
               }
//		else {
//               $('.enable-disable').hide();
//                }   
            if(selected == '3') {
	       $('.setnew-modify').show();
               $('.modifyhome').show();
//                } else {
//               $('.modifyhome').hide();
                                                              
                }
            if(selected == '1') {
               $('.create-delete').show();
//                } else {
//               $('.create-delete').hide();
                                                              }             
		}
		
		updateValues();
		
	});
	
	$(document).on('change', '.form-group-multiple-selects .input-group-multiple-select:not(:last-child) select', function(){
		
		updateValues();
		
	});
	
	$(document).on('click', '.input-group-addon-remove', function(){
		$(this).parent().remove();
		updateValues();
	});
	
	function updateValues()
	{
		values = new Array();
		$('.form-group-multiple-selects .input-group-multiple-select select').each(function(){
			var value = $(this).val();
			if(value != 0 && value != ""){
				values.push(value);
			}
		});
		
		$('.form-group-multiple-selects .input-group-multiple-select select').find('option').each(function(){
			var optionValue = $(this).val();
			var selectValue = $(this).parent().val();
			if(in_array(optionValue,values)!= -1 && selectValue != optionValue)
			{
				$(this).attr('disabled', 'disabled');
			}
			else
			{
				$(this).removeAttr('disabled');
			}
		});
	}
	
	function in_array(needle, haystack){
		var found = 0;
		for (var i=0, length=haystack.length;i<length;i++) {
			if (haystack[i] == needle) return i;
			found++;
	    }
	    return -1;
	}
});
