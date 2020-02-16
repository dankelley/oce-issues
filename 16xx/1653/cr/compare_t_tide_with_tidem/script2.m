data = readtable('CO-OPS_8720218_wl.csv');

time = strcat(data.Date, {' '}, data.Time_GMT_);
time = datenum(time, 'yyyy/mm/ddHH:MM'); 

timeh = (time - time(1))*24;
interval = (time(2) - time(1))*24;

[NAME,FREQ,TIDECON,XOUT]=t_tide(data.Verified_m_, 'interval', interval, 'start time', time(1) ...
   , 'rayleigh', ['M2 '; 'N2 ' ; 'MM '; 'S2 '; 'K1 '; 'L2 '; 'MSF'; 'O1 '; 'M4 '; 'MU2']);

clf;
plot(time, data.Verified_m_, 'k');
hold on;
plot(time, XOUT, 'r');

rmse = sqrt(mean((data.Verified_m_ - XOUT).^2));

save('ml_prediction_ten_consituents.mat', 'XOUT');
