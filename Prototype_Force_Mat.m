clear a
clc
close all
clear vars
format default

%SETUP
%====================================

a = arduino('COM4', 'Uno');

Mux1 = {'D10', 'D9', 'D8'};
for i=1:3 
    configurePin(a, Mux1{i}, 'DigitalOutput');
    writeDigitalPin(a, Mux1{i}, 0);
end

Mux2 = {'D13', 'D12', 'D11'};
for i=1:3
    configurePin(a, Mux2{i}, 'DigitalOutput');
    writeDigitalPin(a, Mux2{i}, 1);
end

zOutput = 'D5'; 
configurePin(a, zOutput, 'PWM');
writePWMDutyCycle(a, zOutput, 1);

zInput = 'A0'; 
configurePin(a, zInput, 'AnalogInput');

matrix = zeros(8,8);
row = zeros(1,8);

% LOOP
%====================================

while (true) 
    for row=0:7
        for i=0:2
            if bitand(row, bitshift(1,i))
                writeDigitalPin(a, Mux1{i+1}, 1);
            else
                writeDigitalPin(a, Mux1{i+1}, 0);
            end
        end        
    
        for column=0:7
            for j=0:2
                if bitand(column,bitshift(1,j))
                    writeDigitalPin(a, Mux2{j+1}, 1);
                else
                    writeDigitalPin(a, Mux2{j+1}, 0);
                end
            end
            inputValue = readVoltage(a, 'A0');
            matrix(8-row,column+1) = inputValue;
            h = heatmap(matrix, 'ColorLimits',[0 5], 'XLabel', '2nd Multiplexer Wires', 'CellLabelColor','none', 'Title', 'Prototype Force Mat');
            drawnow
        end
    end
end