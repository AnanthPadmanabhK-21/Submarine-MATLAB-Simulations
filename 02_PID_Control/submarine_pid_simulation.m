%% Submarine PID Control Simulation
% This script simulates yaw stabilization using a PID controller.
% Author: Ananth Padmanabh
% Date: 1 November 2025

clc; clear; close all;

%% PID Controller Parameters
Kp = 0.3;    % Proportional gain
Ki = 0.01;   % Integral gain
Kd = 0.1;    % Derivative gain

setpoint = 0;        % Desired yaw angle (degrees)
prev_error = 0;      
integral = 0;

%% Simulation Setup
num_steps = 300;     % Time steps
dt = 0.1;            % Sampling interval (s)
yaw = zeros(1, num_steps);     % Measured yaw
pid_output = zeros(1, num_steps);
time = (0:num_steps-1) * dt;

% Simulated disturbance (e.g., water current)
disturbance = 5 * sin(0.05 * (1:num_steps));

%% Simulation Loop
for t = 2:num_steps
    % Simulate actual yaw (previous yaw + disturbance - control action)
    yaw(t) = yaw(t-1) + disturbance(t) - pid_output(t-1);
    
    % PID control calculations
    error = setpoint - yaw(t);
    integral = integral + error * dt;
    derivative = (error - prev_error) / dt;
    prev_error = error;

    control_signal = Kp*error + Ki*integral + Kd*derivative;
    control_signal = max(min(control_signal, 1), -1);  % limit to [-1,1]
    
    pid_output(t) = control_signal;
end

%% Plot Results
figure('Position', [100 100 800 500]);
subplot(2,1,1);
plot(time, yaw, 'r', 'LineWidth', 1.5);
hold on; yline(setpoint, '--k', 'Setpoint');
xlabel('Time (s)'); ylabel('Yaw Angle (°)');
title('Submarine Yaw Response');
legend('Yaw', 'Setpoint');
grid on;

subplot(2,1,2);
plot(time, pid_output, 'b', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('PID Output');
title('PID Controller Output Signal');
grid on;

%% Display Learning Points
disp('------------------------------------------------');
disp('Simulation Complete ✅');
disp('You can now learn:');
disp('1. How Kp increases responsiveness but may cause oscillation.');
disp('2. How Ki removes steady-state error but may cause overshoot.');
disp('3. How Kd smooths response and reduces overshoot.');
disp('4. The system stabilizes when PID balances error correction.');
disp('------------------------------------------------');
