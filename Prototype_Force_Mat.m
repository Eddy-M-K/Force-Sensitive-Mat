clear a
clc
close all
clear vars
format default

% SETUP
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

% fprintf("1.\t2.\t3.\t4.\t5.\t6.\t7.\t8.\t9.\t10.\t11.\t12.\t13.\t14.\t15.\t16.\t17.\t18.\t19.\t20.\t21.\t22.\t23.\t24.\t25.\t26.\t27.\t28.\t29.\t30.\t31.\t32.\t33.\t34.\t35.\t36.\t37.\t38.\t39.\t40.\t41.\t42.\t43.\t44.\t45.\t46.\t47.\t48.\t49.\t50.\t51.\t52.\t53.\t54.\t55.\t56.\t57.\t58.\t59.\t60.\t61.\t62.\t63.\t64.")
% fprintf("\n---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\t---\n")

% LOOP
%====================================

while (true) 
    for pin=0:7
        for i=0:2
            if bitand(pin, bitshift(1,i))
                writeDigitalPin(a, Mux1{i+1}, 1);
            else
                writeDigitalPin(a, Mux1{i+1}, 0);
            end
        end        
    
        for pin2=0:7
            for j=0:2
                if bitand(pin2,bitshift(1,j))
                    writeDigitalPin(a, Mux2{j+1}, 1);
                else
                    writeDigitalPin(a, Mux2{j+1}, 0);
                end
            end
            inputValue = readVoltage(a, 'A0');
%             fprintf("%d\t", inputValue);
            row(1,pin2+1) = inputValue;
        end
        matrix(8-pin,:) = row;
    end
%     fprintf("\n");
    h = heatmap(matrix, 'ColorLimits',[0 5], 'XLabel', '2nd Multiplexer Wires', 'CellLabelColor','none', 'Title', 'Prototype Force Mat');
    drawnow
end