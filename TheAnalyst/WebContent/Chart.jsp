<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ page import="com.google.gson.Gson" %>
 
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Chart</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://www.google.com/jsapi"></script>




<%

Gson gson = new Gson(); 
String json = gson.toJson(request.getAttribute("reqCount")); 
System.out.println("json in string is "+json);
%>


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
    var array = [ <%= json %> ];
   // alert(array);
    debugger;
    //var Arraydata = $.parseJSON(array);
   /*  $.each(array, function(i, item) {
    	 console.log("item is "+item);
    	 console.log("key is "+i);
        //alert(item);
    }); */
    
    //var reqCount = stringggedArray.replace(":",",");
    //alert(array);
    //var cars = ["Saab", "Volvo", "BMW"];
    //var arrayParsed = JSON.parse(array);
    
      google.charts.load("current", {packages:["corechart","line"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
    	  debugger;
    	  var data = new google.visualization.DataTable();
    	  data.addColumn('string', 'Time');
    	  data.addColumn('number', 'JVM1');
    	  data.addColumn('number', 'JVM2');
    	  
    	  
    	  //data.addRows(stringggedArray);
    	
    	    for (var i in array) {
    	    	//console.log("i is "+i);
    	    	   for (var j in array[i]) {
    	    		   //console.log("j is "+j); // time value
    	    	     //console.log(array[i][j]); // req count
    	    	     var time = j.split(' ');
					    data.addRows([
				    	                [time[1], parseInt($.trim(array[i][j])) , parseInt($.trim(array[i][j]))],
				    	              ]);
    	    	   }
    	    	}
    	    
    	    //console.log(data.getValue(0, 1));
    	  

        var options = {
          //legend: 'none',
          //colors: ['#15A0C8'],
          //pointSize: 30,
          pointShape: { type: 'triangle' },
          title : 'Requestor count vs Time',
          hAxis : { textStyle : {fontSize : 10}},
          vAxis : {title : 'Requestor Count'},
          series: {
              1: {curveType: 'function'}
            }
        };

        var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
        chart.draw(data, options);
    
        var handler = function(e) 
        {
    	    //debugger;
    	    alert("hello world from chartsss !!"+e);
    	    var parts = e.targetID.split('#');
    	    if (parts.length >= 2)
    	    {    	    	
    	    	var record = parts[2];
                //alert(record);
    	    	alert(data.getValue(parseInt(record), 0));
            }
      }    
            google.visualization.events.addListener(chart, 'click', handler);      
      }
      
    </script>
</head>
<body>

<table style="font-family:verdana">
<tr>
<td>
</td>

</tr>
<tr><h3>File name and path entered is : "<%= request.getAttribute("FileName1") %>"</h3></tr> 


</table>


<h1> Pega Log Analyst </h1>

 <div id="chart_div" style="width: 100%;"></div>

<br>
</body>
</html>