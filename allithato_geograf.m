clear
close all
meret=100;
figure()

slider1 = uicontrol('Style', 'slider', 'Min', 50, 'Max', 1000, 'Value', 525, 'Position', [10 10 300 10]);
label1 = uicontrol('Style', 'text', 'Position', [120 20 120 15], 'String', 'Csúcsok száma: 525','FontSize',8);
slider1.Callback = @(src, event) updateLabel1(src, label1);
ember_num = round(slider1.Value);

slider2 = uicontrol('Style', 'slider', 'Min', 0, 'Max', 40, 'Value', 20, 'Position', [320 10 200 10]);
label2 = uicontrol('Style', 'text', 'Position', [370 20 160 15], 'String', 'Fertőzési távolság: 20','FontSize',8);
slider2.Callback = @(src, event) updateLabel2(src, label2);
fert_tav = slider2.Value;

button = uicontrol("Style","pushbutton","Position",[540 10 50 20],"String",'Generál');
button.Callback = @(src, event) generateGraph(slider1, slider2, meret);

function updateLabel1(slider1, label)
    slider_ertek1 =round(slider1.Value);
    label.String = ['Csúcsok száma: ', num2str(slider_ertek1)]; 
end
function updateLabel2(slider2, label)
    slider_ertek2 =round(slider2.Value,2);
    label.String = ['Fertőzési távolság: ', num2str(slider_ertek2)]; 
end

function generateGraph(slider1, slider2, meret)
ember_num = round(slider1.Value);
fert_tav = slider2.Value;
[G,~, Px, Py] = geograf(ember_num,fert_tav, meret);
ax=axes;
h = plot(G,'XData',Px,'YData',Py);
ax.Units = 'normalized';
ax.Position = [0.1, 0.1, 0.8, 0.8];
nodeColors = repmat([0 0 0], numnodes(G), 1); 
h.NodeColor = nodeColors;
h.MarkerSize =1;
h.NodeLabel={};
xticks([]);
yticks([]);
end
