input = audioread('corvaglia.wav');

fs = 44100; % frequenza di campionamento del file audio definito dall'utente 

ele = 10;

s1=hrtfmodel(input, 45, ele, fs);

s2=hrtfmodel(input, 120, ele, fs);

s3=hrtfmodel(input, 270, ele, fs);

s4=hrtfmodel(input, 320, ele, fs);

s=vertcat(s1,s2,s3,s4); % Concatena le matrici verticalmente per unire l'audio a diverse angolazioni

sound(s,fs); % Invia il segnale audio s all'altoparlante alla frequenza di campionamento fs

disp(s); % Mostra matrice delle s