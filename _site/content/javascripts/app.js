(function(){

	var templates = {
		img : '<img src="http://www.gravatar.com/avatar/{email_hash}?s=50">',
		name : '<span class="visitor-name">{first_name} {last_name}</span>',
		twitter : '<a href="http://twitter.com/{twitter}" class="visitor-twitter">@{twitter}</a>'
	};

	var renderTemplate = function(template, obj){
		return templates[template].replace(/\{([a-z_]+)\}/g, function(all, match){
			return obj[match].replace(/^@/, '');
		})
	}


	var supporterPacks = $('.supporter-wrap'),
		visitors = $('.visitors-wrap'),
		ticketsUrl = 'https://www.entrio.hr/api/webcamp_2014/get_ticket_count?key=846b896bb5c710de27b957385be60a60',
		names = ["Supporter package", "VIP tickets (supporter pack)"],
		visitorsUrl = 'https://www.entrio.hr/api/webcamp_2014/get_visitors?key=846b896bb5c710de27b957385be60a60';

	if(supporterPacks.length){
		(function(){
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
		})()
	}

	if(visitors.length){
		(function(){
			var req = $.ajax({
				url : visitorsUrl,
				dataType : 'jsonp'
			});
			req.then(function(data){
				var html = [],
					visitorHtml, visitor;
				for(var i = 0; i < data.length; i++){
					visitor = data[i];

					visitorHtml = ['<div class="visitor cf">'];

					visitorHtml.push(renderTemplate('img', visitor));
					visitorHtml.push(renderTemplate('name', visitor));
					
					if(visitor.twitter){
						visitorHtml.push(renderTemplate('twitter', visitor));
					}

					visitorHtml.push('</div>');
					html.push(visitorHtml.join(''));
				}

				visitors.html(html.join(''));
			})
		})()
	}
})();