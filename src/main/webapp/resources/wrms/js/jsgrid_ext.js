var jgexp = {};

jgexp.json2csv = function(jsgrid) {
	var data = jsgrid.jsGrid("option", "data");
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
	return jsgrid.jsGrid("exportData", {
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
		filename = "report_"+ kutil.dateFormat( new Date(), 'yymmddHHMMss');
    //filename += ReportTitle.replace(/ /g,"_");   
    
    var uri = 'data:text/csv;chartset=UTF-8,\uFEFF' + encodeURI(csv);

    var link = document.createElement("a");    
    link.href = uri;
    
    link.style = "visibility:hidden";
    link.download = filename + ".csv";
    
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}


/******************************************************************************/
/*
 * 
 */

var dataGrid = {grid:null};

dataGrid.config = {
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
	        return $("<th style='height:37px;'>").addClass(grid.headerCellClass)
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
	    			var $th = prepareTh(group).attr("colspan", group.columns).text(group.title).addClass('jsgrid-header-group').appendTo($tr);
	    		}
	    	}
	    });
	    $result = $result.add($tr);
	    
	    /************************************************/
	        
	    $tr = $("<tr>").addClass(grid.headerRowClass);
	    grid._eachField(function(field, index) {
	    	if(field.hasGroup) {

	        	//var $th = $("<th>").text(field.title).width(field.width).appendTo($tr);
	        	var $th = prepareTh(field).text(field.title).addClass(grid.headerCellClass).attr("name", field.name).appendTo($tr);
	            
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
	   			ths[ix].addClass(this._sortOrder === "asc" ? this.sortAscClass : this.sortDescClass);
	   			break;
	   		}
	   	}
	},
	_sortData: function(target) {
        var sortFactor = this._sortFactor(),
            sortField = this._sortField;

        if(sortField) {
        	if(!target) target = this.data;
        	
        	var sortFnc =($.isFunction(sortField.sorter) ? sortField.sorter : null);
        	if(sortFnc) {
        		var grid = this;
                target.sort(function(item1, item2) {
                    return sortFactor * sortFnc(sortField, item1, item2);
                });
        	}
        	else {
        		var fieldFnc = this._getItemFieldValue;
        		target.sort(function(item1, item2) {
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
                });
        	}
            /*target.sort(function(item1, item2) {
                return sortFactor * sortField.sortingFunc(item1[sortField.name], item2[sortField.name]);
            });*/
        }
    },
    /*_getField: function(name) {
        for(var ix=0; ix<this.fields.length; ix++) {
            if(this.fields[ix].visible && this.fields[ix].name == name) {
                return this.fields[ix];
            }
        }
        return null;
    },*/
    setSort: function(name, order) {
    	//var field = this._getField(name);
		this._setSortingParams(name, order);
		this._setSortingCss();
	},
	clearSort: function() {
		this._resetSorting();
	},
    
	data: [],
	noDataContent:null,
};


dataGrid.command = function(cmd, key, value) {
	return this.grid.jsGrid(cmd, key, value);
}

dataGrid.showNodata = function() {
	this.grid.jsGrid("option", "container").find(".jsgrid-nodata-row").find("td.jsgrid-cell")
	.css({
		"height" : "60px"
		, "color" : "#29a3cc"
	})
	.text("검색된 내용이 없습니다.");
}

dataGrid.init = function(container, opt) {
	
    $.extend(true, opt, this.config);
    this.grid = $('#'+ container ).jsGrid(opt);
    return this.grid;
}
