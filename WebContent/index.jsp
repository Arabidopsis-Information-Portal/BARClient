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
    <title>Cytoscape.js initialisation</title>
    <style type="text/css">
        body { 
          font: 14px helvetica neue, helvetica, arial, sans-serif;
        }
        
        #cy {
          height: 80%;
          width: 80%;
          position: absolute;
          left: 0;
          top: 500;
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
    
                // giddy up...
    
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
    
        $.ajax({
            dataType: "json",
            type: 'GET',
            url: "http://localhost:8180/BARClient/get_data",
            data: {'query': query},
            beforeSend: function(jqXHR, settings) {
                url = settings.url + "?" + settings.data;
            },
            success: function(elements) {
                window.elements = elements;
                cy.load(elements)
            },
            error: function(jqXHR, textStatus, errorThrown) {
                //alert("Status: " + textStatus + "  Error: " + errorThrown);
                alert("Status: " + textStatus + "  URL: " + url + "  Error: " + errorThrown);
            },
            complete: function(response) {
                console.log("Response.status = " + response.status);
            }
        });
        console.log("Done with query...");
    
    }
    
    $(function(){
        $('#submit').button().click(function(){
            loadCy();
        });
    });
    </script>
</head>
<body>
<hr>
Query: <input type="text" id="query"/> <button id="submit">Submit</button>
<hr>
<div id="cy"></div>

</body>
</html>