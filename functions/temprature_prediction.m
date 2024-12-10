# DO NOT DELETE:
# The window is 700×400 and its origin is at the lower-left corner.

f = figure("position", [300,200, 700,400], "name", "Temprature Perdiction", "toolbar", "none");

uicontrol(f, "style", "text", "string", "Temperature Perdiction", ...
             "position", [0, 370, 700, 30], ...
             "horizontalalignment", "center");

# Number of days label and input field
uicontrol(f, "style", "text", "string", "Enter number of days:", ...
             "position", [5, 330, 150, 30], ...
             "horizontalalignment", "left");

inputField = uicontrol(f, "style", "edit", "position", [155, 330, 150, 30]);

# Button to generate the table:
uicontrol(f, "style", "pushbutton", "string", "Generate Table", ...
             "position", [5, 300, 140, 30], ...
             "callback", @(src, event) createTable(inputField, f));

# Function to create the table:
function createTable(inputField, f)
    userInput = str2double(get(inputField, "string"));

    if isnan(userInput) || userInput <= 0
        errordlg('Please enter a valid positive number for days.', 'Invalid Input');
        return;
    end

    number_of_days = round(userInput);

    data = cell(number_of_days, 2);

    for i = 1:number_of_days
        data{i, 1} = i;
        data{i, 2} = '';
    end

    columnNames = {'Day:', 'Temperature:'};
    uitable(f, ...
            "Data", data, ...
            "ColumnName", columnNames, ...
            "ColumnEditable", [false, true], ...
            "Position", [5, 10, 200, 250]);
end

