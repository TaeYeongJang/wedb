jAlert = {
	open: function(type, title, content, callback) {
		var options = {
			id: 'jquery.alert.'+ type,
			title: title,
			content: content,
			type: type || 'info',
			lang : 'co_KR',
			resize : false,
			fixed : true,
			drag: false,
			prefix: 'jalert',
			opacity: 0.25,
			icons: null,
			onClose: callback
		};

		var alert = $.msgbox(options);
		alert.title(title);
		alert.content(options.content);
		
		return alert;
	},
	text: function(title, content, callback) {
		return this.open('text', title, content, callback);
	},
	html: function(title, content, callback) {
		return this.open('html', title, content, callback);
	},
	alert: function(title, content, callback) {
		return this.open('alert', title, content, callback);
	},
	warning: function(title, content, callback) {
		return this.open('warning', title, content, callback);
	},
	info: function(title, content, callback) {
		return this.open('info', title, content, callback);
	},
	error: function(title, content, callback) {
		return this.open('error', title, content, callback);
	},
	success: function(title, content, callback) {
		return this.open('success', title, content, callback);
	},
	confirm: function(title, content, callback) {
		return this.open('confirm', title, content, callback);
	},
	prompt: function(title, content, callback) {
		return this.open('prompt', title, content, callback);
	}
};

function jAlert(title, content, type) {
	var options = {
		id: 'jquery.alert.'+ type,
		title: title,
		content: content,
		type: type || 'info',
		lang : 'co_KR',
		resize : false,
		fixed : true,
		drag: false,
		prefix: 'jalert',
		icons: null
	};

	var alert = $.msgbox(options);
	alert.title(title);
	alert.content(options.content);
}

