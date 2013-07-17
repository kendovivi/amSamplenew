
//initialize
window.onload=function(){
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
}

colors_arr = ["#3366CC","#FF6600","#FF9E01","#FCD202","#F8FF01","#B0DE09","#0D8ECF","#0D52D1","#2A0CD0","#754DEB","#999999","#000000"];
function create_graph(title, valueField,chart,color_index, valueAxis) {
	graph = new AmCharts.AmGraph();
	graph.showHandOnHover = true;
	graph.title = title;
	if (title == "電気量" || title == "AIR" || title == "KWH" || title == "CO2"){
		graph.type = "line";
		graph.fillAlphas = 0;
		graph.lineAlpha = 1;
		graph.lineColors = colors_arr[color_index]
		graph.bullet = "round";
		graph.valueAxis = valueAxis;
		graph.balloonText = "10分ごと合計　[[value]] ";
	}else{
		graph.type = "column";
		graph.lineAlpha = 0;
		graph.fillAlphas = 1;
		graph.fillColors = colors_arr[color_index];
		graph.balloonText = "平均:　[[value]]";
	}
	graph.valueField = valueField;
	

	//图上标记值
	//graph.labelText = "true";
	//graph.showAllValueLabels = true;
	chart.addGraph(graph);
}

function set3D(chart,suffix){
	if (suffix) {
        chart.depth3D = 8; 
        chart.angle = 5; 
        chart.plotAreaFillAlphas = 1; 
    } else {
        chart.depth3D = 0;
        chart.angle = 0; 
        chart.plotAreaFillAlphas = 0; 
    }
	
}

function setGridOfAxis(axis, max, min, step, color) {
    axis.maximum = max; 
    axis.minimum = min; 

    axis.autoGridCount = false;
    axis.gridCount = axis.maximum / step;
    axis.gridColor = color;
}

//軸の共通設定
function setDefaultAxisAttr(axis, title) {
    axis.axisAlpha = 1; 
    axis.titleBold = true;
    axis.title = title;
    axis.labelRotation = 0; 
}

//POP表示設定
function setDefaultPopOfChart(chart) {
    chart.balloon.color = "#000000"; //文字カラー
    chart.balloon.adjustBorderColor = true;
    chart.balloon.fillColor = "#ffffff";
}


