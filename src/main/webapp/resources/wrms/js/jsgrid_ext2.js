var jgexp = {};

jgexp.default_options = function() {
	var height = ($(".content-wrapper").height()) - 150
	var opt = {
		width : '100%',
		//height: height+'px',

		loadIndication : false,
		loadIndicationDelay : 500,
		loadMessage : "LOADING...",
		loadShading : true,

		//noDataContent: "자료가 없습니다.",
		noDataContent: "",
		
		inserting : false,
		editing : false,
		sorting : true,
		
		//paging : true,
		//pageIndex : 1,
		//pageSize : 20,

		// pagerContainer: null,
		// pageButtonCount: 15,
		// pagerFormat: "{first} {prev} {pages} {next} {last} &nbsp;&nbsp;
		// {pageIndex} of {pageCount}",
		pagerFormat : "{first} {prev} {pages} {next} {last}",
		updateOnResize: true,
	/*
	 * pageNavigatorNextText: "...", pageNavigatorPrevText: "...",
	 * pagerContainerClass: "jsgrid-pager-container", pagerClass:
	 * "jsgrid-pager", pagerNavButtonClass: "jsgrid-pager-nav-button",
	 * pagerNavButtonInactiveClass: "jsgrid-pager-nav-inactive-button",
	 * pageClass: "jsgrid-pager-page", currentPageClass:
	 * "jsgrid-pager-current-page",
	 */

	// data : rawrisAjaxPost(opt),
	// fields : list[url] //dataTemplate
	};

	return opt;
}

jgexp.json2csv = function(jsgrid) {
	var data = jsgrid.command("option", "data");
    var array = typeof objArray != 'object' ? JSON.parse(data) : data;

    var str = '';

    for (var i = 0; i < array.length; i++) {
        var line = '';

        for (var index in array[i]) {
            line += array[i][index] + ',';
        }

        // Here is an example where you would wrap the values in double quotes
        // for (var index in array[i]) {
        //    line += '"' + array[i][index] + '",';
        // }

        line.slice(0,line.Length-1); 

        str += line + '\r\n';
    }
    return str; 
}

jgexp.table2csv = function(jsgrid, transforms) {
	return jsgrid.command("exportData", {
		type: "csv", //Only CSV supported
	    subset: "all" | "visible", //Visible will only output the currently displayed page
	    delimiter: ",", //If using csv, the character to seperate fields
	    includeHeaders: true, //Include header row in output
	    encapsulate: true, //Surround each field with qoutation marks; needed for some systems
	    newline: "\r\n", //Newline character to use
	    
	  //Takes each item and returns true if it should be included in output.
	    //Executed only on the records within the given subset above.
	    filter: function(item){return true},
	    
	    //Transformations are a way to modify the display value of the output.
	    //Provide a key of the field name, and a function that takes the current value.
	    transforms: transforms
	    /*transforms: {
	        "obsDate": function(value){
	        	return kutil.dateFormat(value, 'yyyy-mm-dd HH:MM');
	        	}
	    }*/
	});
}

jgexp.download = function(jsgrid, transforms, filename) {
	//var csv = this.json2csv(objArray);
	var csv = this.table2csv(jsgrid, transforms);
	
	if(!filename)
		filename = "report_"+ new Date();
		//filename = "report_"+ kutil.dateFormat( new Date(), 'yymmddHHMMss');

	var info = ['aaa', 11];//browserInfo().split(' ');
	var br =  info[0];
	var ver =  info[1];

	br = 'aaa';
	
	 if (br == 'IE' && ver < 11) {
		alert('구버전 Internet Explore에서는 지원되지 않는 기능입니다.');
		return;
	}

	if ((br == 'IE' && ver >= 11) || br == 'Edge') {						// ms

		var textFileAsBlob = new Blob([ csv ], {type : 'text/plain'});
		
		window.navigator.msSaveBlob(textFileAsBlob, filename + ".csv");

	} else {																// chrome, firefox

		var uri = 'data:text/csv;chartset=UTF-8,\uFEFF' + encodeURI(csv);
		
		var link = document.createElement("a");
		link.href = uri;

		link.style = "visibility:hidden";
		
		link.download = filename + ".csv";

		document.body.appendChild(link);
		link.click();
		
		document.body.removeChild(link);
	}

}


/******************************************************************************/
/*
 * 
 */

function DataGrid(container, opt) {

	var _grid = null;

	var _config = {
		pagePrevText: "이전",
        pageNextText: "다음",
		pageFirstText: "처음",
		pageLastText: "마지막",
	
		refreshData: function(data) {
		    var vsp = this._body.scrollTop();
		    //var hsp = this._body.scrollLeft();
		    
		    this._sortData(data);
		    this.option("data", data);
		    
		    this._body.scrollTop(vsp);
		},
	
		headerRowRenderer: function() {
	
		    var $tr;
		    var $result;
		    var grid = this;
	
		    var prepareTh = function(field) {
		        //return $("<th style='height:37px;'>").addClass(grid.headerCellClass)
		    	return $("<th>").addClass(grid.headerCellClass)
		            .addClass(('headercss' && field['headercss']) || field.css)
		            .addClass(field.align ? ("jsgrid-align-" + field.align) : "");
		    };
		    
		    /************************************************/
	
		    $tr = $("<tr>").height(0);
		    grid._eachField(function(field, index) {
		    	$("<th>").width(field.width).appendTo($tr);
		    });
		    $result = $tr;
		    
		    /************************************************/
		    
		    $tr = $("<tr>").addClass(grid.headerRowClass);
	
		    grid._eachField(function(field, index) {
		    	if(!field.hasGroup) {
		    		var $th;
		    		if(field.hasGroup === undefined)
			    		$th = prepareTh(field).html(field.title).addClass(grid.headerCellClass).attr("name", field.name).appendTo($tr);
		    		else
		    			var $th = prepareTh(field).attr("rowspan", 2).html(field.title).addClass(grid.headerCellClass).attr("name", field.name).appendTo($tr);
		    		if(grid.sorting && field.sorting) {
		            	$th.addClass('jsgrid-header-sortable');
		        		$th.on("click", function() {
		                	grid.sort(index);
		            	});
		            }
		    	}
		    	else {
		        	var group = field.group;
		    		if(group) {
		    			//var $th = prepareTh(group).attr("colspan", group.columns).text(group.title).addClass('jsgrid-header-group').appendTo($tr);
		    			var $th = prepareTh(group).attr("colspan", group.columns).html(group.title).addClass('jsgrid-header-group').appendTo($tr);
		    		}
		    	}
		    });
		    $result = $result.add($tr);
		    
		    /************************************************/
		        
		    $tr = $("<tr>").addClass(grid.headerRowClass);
		    grid._eachField(function(field, index) {
		    	if(field.hasGroup) {
	
		        	//var $th = $("<th>").text(field.title).width(field.width).appendTo($tr);
		        	//var $th = prepareTh(field).text(field.title).addClass(grid.headerCellClass).attr("name", field.name).appendTo($tr);
		    		var $th = prepareTh(field).html(field.title).addClass(grid.headerCellClass).attr("name", field.name).appendTo($tr);
		            
		            if(grid.sorting && field.sorting) {
		            	$th.addClass('jsgrid-header-sortable');
		        		$th.on("click", function() {
		                	grid.sort(index);
		            	});
		            }
		    	}
		    });
		    $result = $result.add($tr);
		    
		    /************************************************/
		    
		    return $result;
		},
	
		rowRenderer: function(item, itemIndex) {
		    var $result = $("<tr>");
		    
		    $result.bind('click', function(e) {
		    	$(this).parents('.jsgrid-table').find('tr.selected').removeClass('selected');	
		    	$(this).addClass('selected');
		    });
		    
		    this._renderCells($result, item, itemIndex);
			return $result ;
		},
		_renderCells: function($row, item, itemIndex) {
		    this._eachField(function(field) {
		        $row.append(this._createCell(item, field, itemIndex));
		    });
		    return this;
		},
		_createCell: function(item, field, itemIndex) {
		    var $result;
		    var fieldValue = this._getItemFieldValue(item, field);
		
		    var args = { value: fieldValue, item : item, itemIndex: itemIndex };
		    if($.isFunction(field.cellRenderer)) {
		        $result = this.renderTemplate(field.cellRenderer, field, args);
		    } else {
		        $result = $("<td>").append(this.renderTemplate(field.itemTemplate || fieldValue, field, args));
		    }
	
		    return this._prepareCell($result, field);
		},
		_setSortingCss:	function() {
		    var fieldIndex = $.inArray(this._sortField, this.fields); // this is how you know the sorting field index
		    var ths = this._headerRow.find("th");
		   	for(var ix=0; ix<ths.length; ix++) {
		   		if($(ths[ix]).attr('name') == this.fields[fieldIndex].name) {
		   			$(ths[ix]).addClass(this._sortOrder === "asc" ? this.sortAscClass : this.sortDescClass);
		   			break;
		   		}
		   	}
		},

		_default_sortingFunc: function(item1, item2, fieldFnc, sortField) {
			var comp = 0;
			var v1 = fieldFnc(item1, sortField);	//item1[sortField.name];
			var v2 = fieldFnc(item2, sortField);	//item2[sortField.name];
			/*if(v1 != null && v2 != null)
				comp = sortField.sortingFunc(v1, v2);*/
			if(v1 == null && v2 != null)
				comp = -1;
			else if(v1 != null && v2 == null)
				comp = 1;
			else if(v1 > v2)
				comp = 1;
			else if(v1 < v2)
				comp = -1;
			else
				comp = 0;
			
			return comp;
            //return sortFactor * sortField.sortingFunc(item1[sortField.name], item2[sortField.name]);
	    },
	    
	    _sortData: function(target) {
	        var sortFactor = this._sortFactor(),
            sortField = this._sortField;
	
	        if(sortField) {
	        	if(!target) target = this.data;
	        	
        		var grid = this;
    			var fieldFnc = this._getItemFieldValue;
	        	var sortFnc =($.isFunction(sortField.sorter) ? sortField.sorter : null);
	        	if(sortFnc) {
	                target.sort(function(item1, item2) {
	                    //return sortFactor * sortFnc(sortField, item1, item2);
	                	var ret = sortFnc(item1, item2, fieldFnc, sortField, sortFactor);
	                	if(ret == null)
	                		return sortFactor * grid._default_sortingFunc(item1, item2, fieldFnc, sortField);
	                	return ret;
	                });
	        	}
	        	else {
	        		target.sort( function(item1, item2) {
	        			return sortFactor * grid._default_sortingFunc(item1, item2, fieldFnc, sortField);
	        		});
	        		/*var fieldFnc = this._getItemFieldValue;
	        		target.sort( function(item1, item2) {
	        			var comp = 0;
	        			var v1 = fieldFnc(item1, sortField);	//item1[sortField.name];
	        			var v2 = fieldFnc(item2, sortField);	//item2[sortField.name];
	        			if(v1 != null && v2 != null)
	        				comp = sortField.sortingFunc(v1, v2);
	        			else if(v1 == null && v2 != null)
	        				comp = -1;
	        			else if(v1 != null && v2 == null)
	        				comp = 1;
	        			else
	        				comp = 0;
	        			
	        			return sortFactor * comp;
	                    //return sortFactor * sortField.sortingFunc(item1[sortField.name], item2[sortField.name]);
	                });*/
	        	}
	            /*target.sort(function(item1, item2) {
	                return sortFactor * sortField.sortingFunc(item1[sortField.name], item2[sortField.name]);
	            });*/
	        }
	    },
	    setSort: function(name, order) {
	    	//var field = this._getField(name);
			this._setSortingParams(name, order);
			this._setSortingCss();
		},
		clearSort: function() {
			this._resetSorting();
		},
		
		/* for custom pageLoading, 190619, kyo, */
		loadParams: function() {
			return this._loadStrategy.loadParams();		
		},
		finishLoad: function(data) {
			this._loadStrategy.finishLoad(data);
		},

	    
		data: [],
		noDataContent:null,
	};

	this.command = function(cmd, key, value) {
		return _grid.jsGrid(cmd, key, value);
	};

	this.showNodata = function() {
		_grid.jsGrid("option", "container").find(".jsgrid-nodata-row").find("td.jsgrid-cell")
			.css({
				"height" : "60px"
				, "color" : "#29a3cc"
			})
			.text("자료가 없습니다.");
	};

	this.getItem = function(index, value) {
		var data = _grid.jsGrid('option', 'data');
		if(index >= 0 && index < data.length)
			return data[index];
	}
	
	this.loadParams = function() {
		return _grid.jsGrid("loadParams");
	}
	this.finishLoad = function(data) {
		_grid.jsGrid("finishLoad", data);
	}

	this.reset = function() {
		_grid.jsGrid("reset");
	}

	this.init = function(container, opt) {
		
		$.extend(true, _config, opt);
		
		_grid = $('#'+ container ).jsGrid(_config);
	}
	
	this.init(container, opt);
	
	return this;
}



/** *************************************************************************** */
/*
 * 
 */

var CustomPageLoadingStrategy = function(grid, loadHandler) {
	
	this.loadHandler = loadHandler;
    jsGrid.loadStrategies.PageLoadingStrategy.call(this, grid);
    
};
 
CustomPageLoadingStrategy.prototype = new jsGrid.loadStrategies.PageLoadingStrategy();

CustomPageLoadingStrategy.prototype.openPage = function(index) {
	
	if(this.loadHandler && typeof this.loadHandler == 'function')
		this.loadHandler();
};

CustomPageLoadingStrategy.prototype.sort = function() {
	
	if(this.loadHandler && typeof this.loadHandler == 'function')
		this.loadHandler();
};

CustomPageLoadingStrategy.prototype.finishLoad = function(value) {
	
	if(value && value.length) {
		this._itemsCount = value[0].totalCount;
	}
	else {
		this._itemsCount = 0;
	}
	this._grid.option("data", value);
};

CustomPageLoadingStrategy.prototype.loadParams = function(count) {
	
	var grid = this._grid;
    var pageIndex = grid.option("pageIndex");
    var pageSize =  grid.option("pageSize");
    
	var filt = {};
	filt.rn_top    = pageIndex * pageSize;
	filt.rn_bottom = pageIndex * pageSize - pageSize;
	//filt.search_param: grid.option("searchParam")

	var sort = grid._sortingParams();
	if(sort.sortField)
		filt.sort_field = sort.sortField;
	if(sort.sortOrder)
		filt.sort_order = sort.sortOrder;

    return filt;
};


/** *************************************************************************** */
/*
 * 
 */

var dataGrid = {grid:null};


dataGrid.command = function(cmd, key, value) {
	return this.grid.command(cmd, key, value);
}

dataGrid.showNodata = function() {
	this.grid.showNodata();
}

dataGrid.init = function(container, opt) {
	this.grid = new DataGrid(container, opt);
    return this.grid;
}
