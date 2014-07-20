(function(){
	var supporterPacks = $('.supporter-wrap'),
		ticketsUrl = 'https://www.entrio.hr/api/webcamp_2014/get_ticket_count?key=846b896bb5c710de27b957385be60a60',
		names = ["Supporter package", "VIP tickets (supporter pack)"]
	if(supporterPacks.length){
		var req = $.ajax({
			url : ticketsUrl,
			dataType : 'jsonp'
		});
		req.then(function(data){
			var supporters = 0;

			for(var i = 0; i < data.length; i++){
				if($.inArray(data[i].category_name, names) > -1){
					supporters += data[i].count;
				}
			}

			$('.sold').html(supporters + ' / 300 Supporter Packs sold!').removeClass('loading');
			$('.progress-bar').width((supporters / 300 * 100) + '%');
		})
	}
})();