# DO NOT DELETE:
# The window is 840×400 and its origin is at the lower-left corner.

f = uifigure("position", [350,250, 840,400], "name", "Temprature Perdiction");

p = uipanel(f,"bordertype","none")

uicontrol(p, "style", "text", "string", "Temperature Perdiction", ...
             "Units" ,"normalized", ...
             "position" , [0, 0.93, 1, 0.075], ...
             "horizontalalignment", "center");

# Number of days label and input field
uicontrol(p, "style", "text", "string", "Enter number of days :", ...
             "Units" ,"normalized", ...
             "position", [0.1, 0.8, 0.5, 0.05], ...
             "horizontalalignment", "left");

inputField = uicontrol(p, "style", "edit","Units" ,"normalized", "position", [0.35, 0.8, 0.1, 0.05]);

# Button for next step:
uicontrol(f, "style", "pushbutton", "string", "Next", ...
             "Units" ,"normalized", ...
             "position", [0.45 ,0.68 ,0.09 ,0.08], ...
             "callback", @(src, event) Next(inputField, p));

# Function to create the next section:
function Next(inputField, f)
    userInput = str2double(get(inputField, "string"));

    if isnan(userInput) || userInput <= 0
        errordlg('Please enter a valid positive number for days.', 'Invalid Input');
        return;
    end

    number_of_days = round(userInput);

    data = cell(2,number_of_days);

    table_width = min(0.9,(65+(63*number_of_days))/700);

    rowNames = {'Day', 'Temperature'};

 # Create table with number_of_days column
    t = uitable(f,"Data", data, ...
                "rowName", rowNames, ...
                "ColumnEditable", true, ...
                "Units" ,"normalized", ...
                "Position", [0.05, 0.45, table_width, 0.155]);

 # Box to enter the day user wants to estimate
    uicontrol(f, "style", "text", "string", "Enter number of day you want :", ...
             "Units" ,"normalized", ...
             "position", [0.1, 0.32, 0.5, 0.05], ...
             "horizontalalignment", "left");

    targetDay = uicontrol(f, "style", "edit","Units" ,"normalized", "position", [0.35, 0.32, 0.1, 0.05]);

 # Button for estimate
    uicontrol(f, "Style", "pushbutton", "String", "Estimate", ...
          "Units", "normalized", ...
          "Position", [0.4, 0.1, 0.2, 0.1], ...
          "Callback", @(src, event) Estimate(t,targetDay));


end

# funtion for estimate use Lagrange or leastSquares
function Estimate(data,targetDay)

    Data = get(data, "Data");
    x_points = cell2mat(Data(:,1));
    y_points = cell2mat(Data(:,2));
    Day = targetDay;

    if (Day >= x_points(1) && Day <= rows(x_points))
      result = Lagrange(x_points,y_points,Day);
    else
      Coff = leastSquares(x_points,y_points,3);
      result = Coff(1) + Coff(2)*Day + Coff(3)*Day^2 + Coff(4)*Day^3;
    endif

end
