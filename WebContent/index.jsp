<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
    <meta name="description" content="[An example of getting started with Cytoscape.js]" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="http://cytoscape.github.io/cytoscape.js/api/cytoscape.js-latest/cytoscape.min.js"></script>
    <meta charset=utf-8 />
    <title>Cytoscape.js Demo</title>
    <style type="text/css">
        body { 
          font: 14px helvetica neue, helvetica, arial, sans-serif;
        }
        
        #cy {
          height: 80%;
          width: 80%;
          position: absolute;
          left: 0;
          top: 150px;
        }
        
        .warning, .error {
          border: 1px solid;
          margin: 10px 0px;
          padding: 15px 10px 15px 50px;
          background-repeat: no-repeat;
          background-position: 10px center;
        }
        
        .warning {
          color: #9F6000;
          background-color: #FEEFB3;
        }
        
        .error {
          color: #D8000C;
          background-color: #FFBABA;
        }
    </style>
    <script type="text/javascript">
    function loadCy() {
        options = {
            style: cytoscape.stylesheet()
            .selector('node')
              .css({
                'content': 'data(name)',
                'text-valign': 'center',
                'color': 'white',
                'text-outline-width': 2,
                'text-outline-color': '#888'
              })
            .selector('edge')
              .css({
                'target-arrow-shape': 'none'
              })
            .selector(':selected')
              .css({
                'background-color': 'black',
                'line-color': 'black',
                'target-arrow-color': 'black',
                'source-arrow-color': 'black'
              })
            .selector('.faded')
              .css({
                'opacity': 0.25,
                'text-opacity': 0
            }),
            ready: function(){
                window.cy = this;
    
                cy.elements().unselectify();
                cy.zoomingEnabled(false);
                cy.fit();
    
                cy.on('tap', 'node', function(e){
                    var node = e.cyTarget; 
                    var neighborhood = node.neighborhood().add(node);
    
                    cy.elements().addClass('faded');
                    neighborhood.removeClass('faded');
                });
    
                cy.on('tap', function(e){
                    if( e.cyTarget === cy ){
                        cy.elements().removeClass('faded');
                    }
                });
            }
        };
        window.cy = $('#cy').cytoscape(options);
    
        var query = $('#query').val();
        console.log("Query: " + query);
        var encodedQuery = encodeURIComponent(query);
    
        $.ajax({
            dataType: "json",
            type: 'GET',
            url: "get_data",
            data: {'query': encodedQuery},
            beforeSend: function(jqXHR, settings) {
                url = settings.url + "?" + settings.data;
            },
            success: function(elements) {
                console.log("URL: " + url);
                if (jQuery.isEmptyObject(elements)) {
                    $('#status').html("Query returned no results.").addClass('warning');
                } else {
                    window.elements = elements;
                    cy.load(elements)
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                $('#status').html("Status: " + textStatus + "  URL: " + url + "  Error: " + errorThrown).addClass('error');
            },
            complete: function(response) {
                console.log("Response.status = " + response.status);
            }
        });
        console.log("Done with query...");
    
    }
    
    $(function(){
        $('#submit').button().click(function(){
            $('#status').empty();
            $('#status').removeClass('warning');
            $('#status').removeClass('error');
            loadCy();
        });
    });
    </script>
</head>
<body>
<hr>
<h3 align="center">Cytoscape.js Viewer</h3>
<p align="center"><em>Arabidopsis thaliana</em> protein interaction data queried from <a href="http://bar.utoronto.ca/">BAR's</a> (The Bio-Analytic Resource for Plant Biology) PSICQUIC webservices</p>
<hr>
<table border="0" cellpadding="5">
<tr>
<td nowrap><b>Query</b> <em style="font-size: .8em;">(Any gene name or AGI ID, e.g. ASK1, AT1G10940, AT3G62980)</em>: <input type="text" id="query"/> <button id="submit">Submit</button></td>
<td align="left" width="99%"><div id="status"></div></td>
</tr>
</table>
<hr>
<div id="cy"></div>

</body>
</html>