/**
 * @require: ./Content_Javascript/Javascript_DragResize.js
 */


DRpopwnd = function(container_id, options)
{
	var _drpopApi = null;
	var _container_id = container_id;
	
	var _border_radius = 3;
	
	/**************************************************************************/
	/*
	 * 
	 */
	

	var buildContainerHtml = function(width, height)
	{
		width = width||800;
		height = height||600;
		var br = _border_radius;
		
		html =
		'<div id="dr_popwnd_wnd_container" class="drsElement shadow-20px-center" style="display:none;left:250px;top:80px;width:'+ width+'px;height:'+ height +'px;z-index:1001;position:absolute;border-radius:'+br+'px;">' +
			'<div id="dr_popwnd_wnd_border" class="x_panel"' + 
				'style="background:rgb(51, 51, 51);padding:0px;height:100%;position:relative;border-radius:'+br+'px;border:1px solid #435c74;">' +
		
				'<div class="x_title" style="background:#29373d;position:relative;top:0;z-index:5;padding:5px;width:100%; border-radius:'+br+'px '+br+'px 0px 0px;border-bottom:1px solid #222d32;">' +
					'<div id="dr_popwnd_head_handle" style="position:absolute; left:0px; right:80px; height:100%;">' +
						'<h4 style="height:24px;color:#ffffff;padding:3px 0px 0px 10px;margin:0;">' +
							'<span id="dr_popwnd_head_title_name"></span><span> </span>' + 
							'<small id="dr_popwnd_head_title_subname" style="color:#eeeeee;"></small>' +
						'</h4>' +
					'</div>' +
					'<ul class="nav navbar-right panel_toolbox" style="margin-top:0px;margin-right:6px;border:0px solid #ffffff;">' +
							'<li><a id="dr_popwnd_link_togglebtn" style="display:none;"><i id="dr_popwnd_btn_togglebtn" class="fa fa-square-o"></i></a></li>' +
							'<li><a class="close-link" id="dr_popwnd_link_closebtn"><i class="fa fa-close"></i></a></li>' +
					'</ul>' +
					'<div class="clearfix" ></div>' +
				'</div>' +
		
				'<div class="x_content"' + 
					'style="height:'+ (height-40) +'px;position:relative;top:0;padding:0px 1px 4px 1px;z-index:3;width:100%;border-radius:0px 0px '+br+'px '+br+'px">' +
					'<iframe id="dr_popwnd_wnd_contents" scrolling="no" style="width:100%;height:100%;border:0px;background:#ffffff;"></iframe>' +
				'</div>' +
		
			'</div>' +
		'</div>';

		return html;
	}
	
	var createWindow = function(width, height)
	{
		var container	= document.getElementById(_container_id);
		var optionType	= options.windowKind;
		
		if(!container) return;
		
		container.innerHTML = buildContainerHtml(width, height);
		
		var togglebtn = document.getElementById('dr_popwnd_link_togglebtn');
		togglebtn.addEventListener('click', togglebtnClickHandler.bind(this));

		var closebtn = document.getElementById('dr_popwnd_link_closebtn');
		closebtn.addEventListener('click', closebtnClickHandler.bind(this));
		
	}

	var togglebtnClickHandler = function(e)
	{
		controlWindow('toggle');
	}
	var closebtnClickHandler = function(e)
	{
		controlWindow('close');	
	}

	var controlSaveWindow = function(panel) 
	{
		var rect = {
			left: panel.offset().left,
			top: panel.offset().top,
			width: panel.width(),
			height: panel.height()
			};
		
		panel.attr('leftOrignal', rect.left);
		panel.attr('topOrignal', rect.top);
		panel.attr('widthOrignal', rect.width);
		panel.attr('heightOrignal', rect.height);
	}
	var controlFullWindow = function(panel) 
	{
		panel.css('left','0px');
		panel.css('top','0px');
		panel.css('width','100%');
		panel.css('height','100%');
	}
	var controlRestoreWindow = function(panel) 
	{
		var rect = {
				left: panel.attr('leftOrignal'),
				top: panel.attr('topOrignal'),
				width: panel.attr('widthOrignal'),
				height: panel.attr('heightOrignal')
				};
		if(!rect.left)
			rect = {
				left: panel.offset().left,
				top: panel.offset().top,
				width: panel.width(),
				height: panel.height()
				};
		rect.top = 50;
		
		panel.css('left', rect.left+'px');
		panel.css('top', rect.top+'px');
		panel.css('width', rect.width+'px');
		panel.css('height', rect.height+'px');
	}
	
	var controlWindow = function(mode)
	{
		var container = $('#'+ _container_id);
		//var panel = (_container_id == 'DivWidgetPanelArea') ? $('#dr_popwnd_wnd_container') : $('#dr_popwnd_wnd_container_salt');
		var panel = $('#dr_popwnd_wnd_container');
//		var handle = $('#dr_popwnd_head_handle');
		var border = $('#dr_popwnd_wnd_border');
		var icon = $('#dr_popwnd_btn_togglebtn');
		
		var br = _border_radius +'px';
		
		switch (mode)
		{
			case 'open' :
				panel.css('display','block');
				if (panel.attr('mode') == 'full')
				{
					container.css('width','100%');
					container.css('height','100%');
					panel.removeClass('drsElement');
//					handle.removeClass('drsMoveHandle');
					panel.css('border-radius','0px');
					handle.css('border-radius','0px');
					border.css('border-radius','0px');
					panel.attr('mode','full');
					
					controlFullWindow(panel);
					/*panel.attr('leftOrignal',panel.offset().left);
					panel.attr('topOrignal',panel.offset().top);
					panel.attr('widthOrignal',panel.width());
					panel.attr('heightOrignal',panel.height());
					panel.css('left','0px');
					panel.css('top','0px');
					panel.css('width','100%');
					panel.css('height','100%');*/
				}
				else
				{
					container.css('width','1px');
					container.css('height','1px');
					panel.addClass('drsElement');
//					handle.addClass('drsMoveHandle');
					panel.css('border-radius',br);
//					handle.css('border-radius','10px 10px 0px 0px');
					border.css('border-radius',br);
					panel.attr('mode','normal');
					
					controlRestoreWindow(panel);
					/*panel.css('left',panel.attr('leftOrignal')+'px');
					panel.css('top',panel.attr('topOrignal')+'px');
					panel.css('width',panel.attr('widthOrignal')+'px');
					panel.css('height',panel.attr('heightOrignal')+'px');*/
				}
				break;
			case 'close' :
				container.css('width','1px');
				container.css('height','1px');
				panel.css('display','none');
				break;
			case 'toggle' :
				if (!panel.attr('mode'))
				{
					panel.attr('mode','normal');
				}
				if (panel.attr('mode') == 'full')
				{
					icon.removeClass('fa-clone');
					icon.addClass('fa-square-o');
					container.css('width','1px');
					container.css('height','1px');
					panel.addClass('drsElement');
//					handle.addClass('drsMoveHandle');
					panel.css('border-radius',br);
					handle.css('border-radius',br+' '+br+' 0px 0px');
					border.css('border-radius',br);
					panel.attr('mode','normal');
					
					controlRestoreWindow(panel);
					/*panel.css('left',panel.attr('leftOrignal')+'px');
					panel.css('top',panel.attr('topOrignal')+'px');
					panel.css('width',panel.attr('widthOrignal')+'px');
					panel.css('height',panel.attr('heightOrignal')+'px');*/
				}
				else
				{
					icon.addClass('fa-clone');
					icon.removeClass('fa-square-o');
					container.css('width','100%');
					container.css('height','100%');
					panel.removeClass('drsElement');
					handle.removeClass('drsMoveHandle');
					panel.css('border-radius','0px');
					handle.css('border-radius','0px');
					border.css('border-radius','0px');
					panel.attr('mode','full');
					
					controlSaveWindow(panel);
					controlFullWindow(panel);
					/*panel.attr('leftOrignal',panel.offset().left);
					panel.attr('topOrignal',panel.offset().top);
					panel.attr('widthOrignal',panel.width());
					panel.attr('heightOrignal',panel.height());
					panel.css('left','0px');
					panel.css('top','0px');
					panel.css('width','100%');
					panel.css('height','100%');*/
				}
				break;
		}
	}


	var dragresizeWindowIsElement = function(elm)
	{
		if (elm.className && elm.className.indexOf('drsElement') > -1
			&& ('dr_popwnd_wnd_container').indexOf(elm.id) > -1 
		) return true;
	};

	var dragresizeWindowIsHandle = function(elm)
	{
		if (elm.className && elm.className.indexOf('drsMoveHandle') > -1) return true;
	};


	var initClass = function(options)
	{
		//if (DeviceKind == "pc"){
			/*var options = { 
					minWidth: 780, minHeight: 400, minLeft: 0, minTop: 62, maxLeft: 10000, maxTop: 10000, 
					allowBlur: true, paddingVertical: 38, fixWidth: true, fixHeight: true};*/

			var drObj = new DragResize('dradResizePopwnd', options);
			drObj.isElement = dragresizeWindowIsElement;
			drObj.isHandle = dragresizeWindowIsHandle;

			drObj.apply(document);

			_drpopApi = drObj;

			/* 
			drObj.ondragfocus = function(target){};
			drObj.ondragstart = function(isResize, target){};
			drObj.ondragmove = function(isResize, target){};
			drObj.ondragend = function(isResize, target){};
			drObj.ondragblur = function(target){};
			*/

		//}else{}
	};

	/**************************************************************************/
	/*
	 * 
	 */

	this.openWindow = function(window_title, window_subtitle, contents_url, width, height)
	{
		createWindow(width, height);

		document.getElementById('dr_popwnd_head_title_name').innerHTML = window_title;
		document.getElementById('dr_popwnd_head_title_subname').innerHTML = window_subtitle;
		document.getElementById('dr_popwnd_wnd_contents').src = contents_url;

		setTimeout(controlWindow.bind(this), 100, 'open');
	}
	

	this.closeWindow = function()
	{
		controlWindow('close');
	}
	
	/**************************************************************************/
	/*
	 * 
	 */
	
	initClass(options);
}


/**************************************************************************/
/*
 * 
 */



