//size of canvas view
var VIEW_SIZE;
//DEVICE (mobile device) measurements
var DEVICE_SIZE;
var DEVICE_RECT;

var SCROLL_SPEED = 5; //bigger = slower

//Style
var TEXT_FONT = 'arial';

var COLOR_BACKGROUND = new Color(0.1, 0.1, 0.1);
var COLOR_TILES = new Color(0.2, 0.2, 0.25);
var COLOR_OVERLAY = new Color(1, 0.6, 0);
var COLOR_OVERLAY_2 = new Color(0, 0.5, 1);//new Color(1, 0.6, 0);
var COLOR_SYMBOL = new Color(0/255, 103/255, 202/255);
var COLOR_LGHTBACK = new Color(0.3, 0.3, 0.3);
var COLOR_ALT = new Color(0.6, 0.6, 0.6);
var COLORS_PIE = [new Color(1, 0.6, 0),
                    new Color(0, 0.6, 1),
                    new Color(1, 0, 0),
                    new Color(0, 1, 0),
                    new Color(0.9, 0, 0.9)]

var COLOR_SUNNY = new Color(1, 0.8, 0);
var COLOR_CLOUDY = new Color(0.4, 0.4, 0.4);
var COLOR_RAINY = new Color(0, 0.4, 0.9);
var COLOR_WINDY = new Color(0.7, 0.8, 0.7);

//TILE sizes
var TILE_padding = 10;
var TILE_SCALE;
var TILE_GRAPH;
var TILE_1;
var TILE_2;
var TILE_GRAPH_2;
var TILE_3;

InitialiseDevice();

//Setup window for canvas
function InitialiseDevice() {

    //clear canvas for redraw
    project.clear();

    //save view size = window size
    VIEW_SIZE = view.size;

    //calculate simulated device size
    DEVICE_SIZE = new Point(VIEW_SIZE.width * 1, VIEW_SIZE.height * 1);
    //calculate simulated device rec (in centre of view)
    DEVICE_RECT = new Rectangle(new Point(0, 0), DEVICE_SIZE);
    DEVICE_RECT.center = new Point(VIEW_SIZE.width / 2, VIEW_SIZE.height / 2);

    //set tile size
    TILE_SCALE = DEVICE_RECT.height / 4;

    //Background
    var path = new Path.Rectangle(DEVICE_RECT);
    path.fillColor = COLOR_BACKGROUND;

    //var tileRec = new Rectangle(new Point(0, 0), new Point(100, 100));
    //var tileTest = new Path.Rectangle(tileRec);
    //tileTest.fillColor = COLOR_TILES;

    /*var basePos = new Point(150, 150);
    var segments = [basePos, basePos + new Point(0, 100),
                    basePos + new Point(100, 100), basePos + new Point(100, 0),
                    basePos];
    tileT = new Tile(segments);
    tileT.name = 'cirAttend' + i;
    tileT.fillColor = 'red';
    tileT.strokeColor = 'white';
    tileT.strokeWidth = 2;*/
    FormatTiles();
}

//Window Event Calls
function OnWindowResize() {
    //resize the object scale data
    InitialiseDevice();
}

//add listeners
window.addEventListener('resize', OnWindowResize);
//--------------------------------------------------

//FINANACE DISPLAY-------------------------------------
//-----------------------------------------------------
function FormatTiles(){

    //GRAPH TILE
    TILE_GRAPH = new Rectangle(new Point(TILE_padding, TILE_padding),
                                new Size(TILE_SCALE * 3, TILE_SCALE * 2));
    drawTile(TILE_GRAPH, COLOR_TILES);

    var scaleValue = TILE_GRAPH.width * 0.04;
    randomGraph(new Rectangle(new Point(TILE_GRAPH.x + scaleValue, TILE_GRAPH.y + scaleValue),
                                new Size(TILE_GRAPH.width - scaleValue * 2, TILE_GRAPH.height - scaleValue * 2)), COLOR_OVERLAY);

    //TILE 1
    TILE_1 = new Rectangle(new Point(TILE_GRAPH.right + TILE_padding, TILE_padding),
                                new Size(TILE_SCALE, TILE_SCALE));
    drawTile(TILE_1, COLOR_TILES);

    //randomGraph(TILE_1, 'blue');
    circlePercent(TILE_1, Math.random(), "spendings\ntoday", COLOR_OVERLAY);


    //TILE 2
    TILE_2 = new Rectangle(new Point(TILE_1.right + TILE_padding, TILE_padding),
                                new Size(TILE_SCALE, TILE_SCALE));
    drawTile(TILE_2, COLOR_TILES);

    descriptionNumber(TILE_2, "$2000", "Deposit:");

    //GRAPH TILE 2
    TILE_GRAPH_2 = new Rectangle(new Point(TILE_GRAPH.right + TILE_padding, TILE_1.bottom + TILE_padding),
                                new Size(TILE_SCALE * 3, TILE_SCALE * 2));
    drawTile(TILE_GRAPH_2, COLOR_TILES);

    //randomGraph(TILE_GRAPH_2, 'red');
    randomGraphThread(TILE_GRAPH_2);

    //TILE 3
    TILE_3 = new Rectangle(new Point(TILE_padding, TILE_GRAPH.bottom + TILE_padding),
                                new Size(TILE_SCALE * 2, TILE_SCALE * 2));
    drawTile(TILE_3, COLOR_TILES);

    pieChart(TILE_3, [0.3, 0.3, 0.3], "today", COLOR_OVERLAY);
}

function drawTile(boundRec, color){

    var tileGraph = new Path.Rectangle(boundRec);
    tileGraph.fillColor = color;

    //tile bottom frame
    var frameSize = 2;
    var recBottom = new Rectangle(new Point(boundRec.left, boundRec.top), new Size(frameSize, boundRec.height));
    var tileFrame = new Path.Rectangle(recBottom);
    tileFrame.fillColor = COLOR_OVERLAY;
}

//function that creates a random graph for testing
function randomGraph(boundRec, color){
    //random graph data
    x = [];
    y = [];
    var points = RandFromInt(10, 50);
    //var scale = boundRec.width / points;
    for(var i = 0; i < points; ++i){
        x.push(i);
        y.push(RandFromInt(0, boundRec.height));
    }
    graph(boundRec, x, y, color, true);
}

//function that creates a random graphPrediction for testing
function randomGraphPrediction(boundRec){
    //random graph data
    x = [];
    y_fixed = [];
    y_predicted = [];
    var points = RandFromInt(50, 150);
    //var scale = boundRec.width / points;
    //create x variables
    for(var i = 0; i < points; ++i){
        x.push(i);
    }
    //create y_fixed values
    for(var i = 0; i < points; ++i){
        y_fixed.push(RandFromInt(0, boundRec.height));
        y_predicted.push(RandFromInt(0, boundRec.height));
    }
    graphPrediction(boundRec, x, y_fixed, y_predicted, COLOR_LGHTBACK, COLOR_OVERLAY_2);
}

function randomGraphThread(boundRec){
    //random graph data
    x = [];
    ySets = [];
    var sets = 10;
    var points = RandFromInt(10, 50);
    //var scale = boundRec.width / points;
    //create sets
    for(var s = 0; s < sets; ++s){
        var set = [];
        ySets.push(set);
    }
console.log(" sets y:" + ySets.length);
    for(var i = 0; i < points; ++i){
        x.push(i);
        for(var j = 0; j < ySets.length; ++j){
            ySets[j].push(x[i] * x[i] * RandFromInt(boundRec.height / 10, boundRec.height / 6) / 500);
        }
    }
    var c = new Color(COLOR_OVERLAY.red, COLOR_OVERLAY.green, COLOR_OVERLAY.blue, 0.5);
    graphThread(boundRec, x, ySets, c, true);
}

function findBiggestValue(list){
    var max = 0;

    for(var i = 0; i < list.length; ++i){
        if(max < list[i])
            max = list[i];
    }

    return max;
}

function graph(boundRec, xPoints, yPoints, color, displayLastValue){

    //scale the graph bounds for inputting dimensions
    var scaleValue = 0; //boundRec.width * 0.1;

    var scaledBound = new Rectangle(new Point(boundRec.x + scaleValue, boundRec.y + scaleValue), new Size(boundRec.width - scaleValue * 2, boundRec.height - scaleValue * 2));

    //values for graph are represented as pairs of x and y
    basePos = new Point(scaledBound.left, scaledBound.top);
    var xRate = scaledBound.width / xPoints.length;
    var yRate = scaledBound.height / yPoints.length;
    var segments = new Path();
    //console.log(basePos);
    //console.log(xPoints);
    //console.log(TILE_SCALE);
    for(var i = 0; i < xPoints.length; ++i){
        var posPoint = basePos + new Point((xPoints[i] - xPoints[0]) * xRate,  scaledBound.height - yPoints[i]);
        segments.add(posPoint);

        //draw each point
        var pointC = new Path.Circle(posPoint, 2);
        pointC.strokeColor = color;
        pointC.strokeWidth = 1;
    }
    //console.log(segments);
    segments.strokeColor = color;
    segments.strokeWidth = 2;
    //segments.smooth();

    //write out last value at end of graph
    if(displayLastValue){
        var numOffset = TILE_SCALE * 0.1;
        var endOfGraphPoint = basePos + new Point((xPoints[xPoints.length - 1] - xPoints[0])  * xRate + numOffset, scaledBound.height - yPoints[xPoints.length - 1]);
        drawSmallText(yPoints[xPoints.length - 1], endOfGraphPoint);
    }
}

function pieChart(boundRec, percentages, description, color){

    //draw background of ring
    //drawRing(boundRec, 1.1, COLOR_BACKGROUND, 12);

    //reverse add all ring percentages
    for(var i = percentages.length - 1; i >= 0; --i){
        //var finalValue = i > 0 ? percentages[i] * rateOffset : 1.1;
        percentages[i] += i < percentages.length - 1 ? percentages[i + 1] : 0;
    }
    //final biggest value is over 1 for a full ring
    percentages[0] = 1.1;

    //draw all the rings in normal order (low to high)
    for(var i = 0; i < percentages.length; ++i){
        drawRing(boundRec, percentages[i], COLORS_PIE[i], 12);
    }

    descriptionNumber(boundRec, "", description);
}

function circlePercent(boundRec, percentage, description, color){

    //background of ring
    drawRing(boundRec, 1.1, COLOR_BACKGROUND, 6);
    //draw percentage of ring
    drawRing(boundRec, percentage, color, 6);
    //draw description
    descriptionNumber(boundRec, parseInt(percentage * 100) / 100.0, description);

}

function drawRing(boundRec, percentage, color, thickness){
    var radius = boundRec.width * 0.4;
    var padding = boundRec.width * 0.3;
    var pos = boundRec.center;
    var fillP = 30;
    var twoPi = 2 * 3.1415926 / fillP;

    var segments = new Path();
    for(var i = 0; i < fillP * percentage; ++i){
        segments.add(pos + new Point(Math.cos(twoPi * i) * radius,
                                    Math.sin(twoPi * i) * radius));
    }

    segments.strokeColor = color;
    segments.strokeWidth = thickness;
    //segments.selected = true;
    segments.smooth();

}

function graphPrediction(boundRec, xPoints, yPoints_fixed, yPoints_predicted, color_fixed, color_predict){

    //divide graph bounds in half (two seperate graphs)
    var scaleVal = boundRec.width * 0.04;
    bounds_fixed = new Rectangle(new Point(boundRec.x + scaleVal, boundRec.y), new Size(boundRec.width / 2 - scaleVal, boundRec.height));
    bounds_predict = new Rectangle(new Point(bounds_fixed.right, boundRec.y), new Size(boundRec.width / 2 - scaleVal, boundRec.height));

    //draw graph that is based off fixed values
    graph(bounds_fixed, xPoints.slice(0, xPoints.length / 2), yPoints_fixed, color_fixed, false);

    //draw graph that is based off predictive model values
    //yPoints_predicted.unshift(yPoints_fixed.get(yPoints_fixed -1)); //add the first non-predict value to the predicted values to merge them
    graph(bounds_predict, xPoints.slice(xPoints.length / 2, xPoints.length), yPoints_predicted, color_predict, true);

}

function graphThread(boundRec, xPoints, yPointsSet, color){

    for(var y = 0; y < yPointsSet.length; ++y){
        graph(boundRec, xPoints, yPointsSet[y], color, false);
    }
}

function descriptionNumber(boundRec, Value, description){

    drawLargeText(Value, boundRec.center);

    drawSmallText(description, boundRec.center - new Point(0, boundRec.height / 4.5));

}

function drawLargeText(text, pos){
    var percentText = new PointText({
            point: pos,
            content: text,
            fillColor: 'white',
            fontFamily: TEXT_FONT,
            fontWeight: 'bold',
            //sizes can't be smaller than 3
            fontSize: 30,
            justification: 'center'//,
    });
}

function drawSmallText(text, pos){
    var percentText = new PointText({
            point: pos,
            content: text,
            fillColor: 'white',
            fontFamily: TEXT_FONT,
            fontWeight: 'bold',
            //sizes can't be smaller than 3
            fontSize: 10,
            justification: 'center'//,
    });
}

/*function Tile(Pathdata){
    Path.apply(this, Pathdata);
}
Tile.prototype = new Path;*/


//HELPER FUNCTIONS-------------------------
// random number from x to y inclusive
function RandFrom(min, max){
    return min + (Math.random() * (max - min));
}

function RandFromInt(min, max){
    return Math.floor(min + (Math.random() * (max - min)));
}
