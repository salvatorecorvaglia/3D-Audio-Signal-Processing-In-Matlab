recObj = audiorecorder(8000, 16, 2);
get(recObj)

% Registra la tua voce per 5 secondi
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

myRecording = getaudiodata(recObj); % Memorizza i dati

filename = 'myRecording.wav';
audiowrite(filename,myRecording,8000);

plot(myRecording); % Traccia la forma d'onda

input = audioread('MyRecording.wav');

ele = 10;

s1=hrtfmodel(input, 45, ele, 8000);

s2=hrtfmodel(input, 120, ele, 8000);

s3=hrtfmodel(input, 270, ele, 8000);

s4=hrtfmodel(input, 320, 0, 8000);

s=vertcat(s1,s2,s3,s4); % Concatena le matrici verticalmente per unire l'audio a diverse angolazioni

sound(s,8000); % Invia il segnale audio s all'altoparlante alla frequenza di campionamento 8000 Hz

disp(s); % Mostra matrice delle s