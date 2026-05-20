% submarine_udp_simulator.m
% Combined sender + receiver simulation for MATLAB Online

clc; clear;

disp('🌊 Submarine Command Simulator Started');
disp('--------------------------------------');
disp('Type one of these commands: forward | reverse | left | right | stop | exit');
disp('--------------------------------------');

% Initialize last command
lastCommand = '';

while true
    % === Simulated Sender ===
    cmd = lower(strtrim(input('Enter command: ', 's')));

    if cmd == "exit"
        disp("👋 Exiting simulator...");
        break;
    end

    % Write to temporary file (simulated UDP transmission)
    fid = fopen('udp_message.txt', 'w');
    fprintf(fid, '%s', cmd);
    fclose(fid);

    % === Simulated Receiver ===
    pause(0.2); % small delay for realism

    if isfile('udp_message.txt')
        fid = fopen('udp_message.txt', 'r');
        receivedCmd = lower(strtrim(fscanf(fid, '%s')));
        fclose(fid);

        if ~strcmp(receivedCmd, lastCommand)
            lastCommand = receivedCmd;
            disp(['📩 Received: ' receivedCmd]);

            switch receivedCmd
                case 'forward'
                    disp('🚀 Motors set: FORWARD');
                case 'reverse'
                    disp('🔙 Motors set: REVERSE');
                case 'left'
                    disp('↩️ Motors set: LEFT TURN');
                case 'right'
                    disp('↪️ Motors set: RIGHT TURN');
                case 'stop'
                    disp('🛑 Motors STOPPED');
                otherwise
                    disp('⚠️ Unknown command');
            end
        end
    end
    pause(0.2);
end
