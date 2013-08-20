
//amchartsに関する
//**********************************************
//図を作成する
//**********************************************
AmCharts.ready(function() {
	chart = new AmCharts.AmSerialChart();
	chart.startDuration = 1;
	graph = new AmCharts.AmGraph();
	var categoryAxis = chart.categoryAxis;
	var valueAxis = new AmCharts.ValueAxis();
	chart.addValueAxis(valueAxis);
	var valueAxis2 = new AmCharts.ValueAxis();
	chart.addValueAxis(valueAxis2);
	var legend = new AmCharts.AmLegend();
	chart.addLegend(legend);
	var scrollbar = new AmCharts.ChartScrollbar()
	chart.addChartScrollbar(scrollbar);              
    var chartCursor = new AmCharts.ChartCursor();
    chart.addChartCursor(chartCursor);
	
	chart.dataProvider = chartData;
	chart.pathToImages = "/assets/";
	chart.categoryField = "date";
	chart.columnWidth = 0.5;
	setDefaultPopOfChart(chart);

    // GRAPH
	$.each(names, function(i, name) {create_graph(name[0], name[1],chart,i, valueAxis2); i += 1;});
	
	//横軸
	chart.categoryAxis.parseDates = true;								//comment out if categoryAxis is string
	chart.categoryAxis.minPeriod = "mm";								//comment out if categoryAxis is string
    categoryAxis.labelRotation = 90;
    setDefaultAxisAttr(categoryAxis,"時刻");	
	
	//縦軸
	//setGridOfAxis(valueAxis,max,0,max/5,"#000000");
	setGridOfAxis(valueAxis,25,0,5,"#000000");
	setDefaultAxisAttr(valueAxis, "平均売上数");
	setGridOfAxis(valueAxis2,5000,0,1000,"#000000");
	setDefaultAxisAttr(valueAxis2, "平均売上数");
	valueAxis2.position = "right";
	
	// LEGEND
	legend.align = "left";
	legend.labelText = "[[title]]";

	 //スコロールバーの縦横長さの設定
    scrollbar.scrollbarHeight = 25;
    scrollbar.dragIconHeight = 23;
    scrollbar.dragIconWidth = 12;
    //スコロールバーの色設定
    scrollbar.backgroundColor = "#DBDBBF";
    scrollbar.selectedBackgroundColor = "#5B5B58";

chart.write("chartdiv");
});


//**********************************************
//グラフを定義する
//**********************************************
colors_arr = ["#3366CC","#FF9E01","#9999FF","#FCD202","#F8FF01","#B0DE09","#0D8ECF","#0D52D1","#2A0CD0","#754DEB","#999999","#000000"];
　function create_graph(title, valueField,chart,color_index, valueAxis) {
	graph = new AmCharts.AmGraph();
	graph.showHandOnHover = true;
	graph.title = title;
	if (title == "KWH" || title == "CO2"){
		graph.type = "line";
		graph.fillAlphas = 0;
		graph.lineAlpha = 1;
		graph.lineColor = colors_arr[color_index]
		graph.bullet = "round";
		graph.valueAxis = valueAxis;
		graph.balloonText = "10分ごと合計　[[value]] ";
	}else{
	
		graph.type = "column";
		graph.lineAlpha = 0;
		graph.fillAlphas = 1;
		graph.fillColors = colors_arr[color_index];
		graph.balloonText = "合計:　[[value]]";
		set3D(chart, true);
	}
	graph.valueField = valueField;
	
	//图上标记值
	//graph.labelText = "true";
	//graph.showAllValueLabels = true;
	chart.addGraph(graph);	
　}


 function setGraph3D(){
    if (document.getElementById("graph3d_true").checked){
        set3D(chart, true);
    } else{
        set3D(chart, false);
    }
    chart.validateNow();
 }

 function setLabel(){
    if (document.getElementById("label_hide").checked){
        $.each(chart.graphs,function(i,graph){
    		graph.labelText = "";
    	});     
    } else if (document.getElementById("label_show").checked){
    	$.each(chart.graphs,function(i,graph){
    		graph.labelText = "[[value]]";
    	});       
    }
    chart.validateNow();
 }
 
 function setGraphtype(){
    if (document.getElementById("graphtype_column").checked){
        $.each(chart.graphs,function(i,graph){
    		graph.type = "column";
    		graph.lineAlpha = 0;
			graph.fillAlphas = 1;
			graph.bullet = "";
			graph.fillColors = colors_arr[i];
    	});     
    } else if (document.getElementById("graphtype_line").checked){
    	$.each(chart.graphs,function(i,graph){
    		graph.type = "line";
    		graph.lineAlpha = 1;
			graph.fillAlphas = 0;
			graph.bullet = "round";
			graph.lineColor = colors_arr[i];
			graph.bulletColor = colors_arr[i];
    	});       
    }
    chart.validateNow();
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
    axis.gridColor = "#ffffff";
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


